Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUHNDmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUHNDmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 23:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUHNDmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 23:42:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268005AbUHNDmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 23:42:45 -0400
Date: Fri, 13 Aug 2004 23:18:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Possible dcache BUG
Message-ID: <20040814021809.GD30627@logos.cnet>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408110047.32611.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org> <200408130027.24470.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408130027.24470.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:27:24AM -0400, Gene Heskett wrote:
> On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
> >I wrote:
> >> Notably, the output of "/proc/meminfo" and "/proc/slabinfo". "ps
> >> axm" helps too.
> >
> >That should be "ps axv" of course. Just shows what a retard I am.
> >
> >		Linus

> Acck!  I just logged an Oops:
> Aug 13 00:02:00 coyote kernel: kjournald starting.  Commit interval 5 seconds
> Aug 13 00:02:00 coyote kernel: EXT3 FS on hdb3, internal journal
> Aug 13 00:02:00 coyote kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Aug 13 00:05:09 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> Aug 13 00:05:09 coyote kernel:  printing eip:
> Aug 13 00:05:09 coyote kernel: c014e0dc
> Aug 13 00:05:09 coyote kernel: *pde = 00000000
> Aug 13 00:05:09 coyote kernel: Oops: 0002 [#1]
> Aug 13 00:05:09 coyote kernel: PREEMPT
> Aug 13 00:05:09 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
> Aug 13 00:05:09 coyote kernel: CPU:    0
> Aug 13 00:05:09 coyote kernel: EIP:    0060:[<c014e0dc>]    Not tainted
> Aug 13 00:05:09 coyote kernel: EFLAGS: 00010246   (2.6.8-rc4)
> Aug 13 00:05:09 coyote kernel: EIP is at remove_inode_buffers+0x4c/0x90
> Aug 13 00:05:09 coyote kernel: eax: 00000000   ebx: d7ff68b4   ecx: d7ffffb4   edx: 00000000
> Aug 13 00:05:09 coyote kernel: esi: d7ff67e0   edi: 00000001   ebp: c198bed8   esp: c198bec8
> Aug 13 00:05:09 coyote kernel: ds: 007b   es: 007b   ss: 0068
> Aug 13 00:05:09 coyote kernel: Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
> Aug 13 00:05:09 coyote kernel: Stack: d7ff67e0 d7ff67e8 d7ff67e0 0000001e c198bf04 c0165242 d7ff67e0 c198b000
> Aug 13 00:05:09 coyote kernel:        00000000 0000001e d7ff6988 ed3be928 00000080 00000000 c198b000 c198bf10
> Aug 13 00:05:09 coyote kernel:        c016532f 00000080 c198bf44 c013a32c 00000080 000000d0 0002cc1d 013b0a00
> Aug 13 00:05:09 coyote kernel: Call Trace:
> Aug 13 00:05:09 coyote kernel:  [<c010476f>] show_stack+0x7f/0xa0
> Aug 13 00:05:09 coyote kernel:  [<c0104908>] show_registers+0x158/0x1b0
> Aug 13 00:05:09 coyote kernel:  [<c0104a89>] die+0x89/0x100
> Aug 13 00:05:09 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
> Aug 13 00:05:09 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
> Aug 13 00:05:09 coyote kernel:  [<c0165242>] prune_icache+0x142/0x1f0
> Aug 13 00:05:09 coyote kernel:  [<c016532f>] shrink_icache_memory+0x3f/0x50
> Aug 13 00:05:09 coyote kernel:  [<c013a32c>] shrink_slab+0x14c/0x190
> Aug 13 00:05:09 coyote kernel:  [<c013b639>] balance_pgdat+0x1a9/0x1f0
> Aug 13 00:05:09 coyote kernel:  [<c013b73f>] kswapd+0xbf/0xd0
> Aug 13 00:05:09 coyote kernel:  [<c0102471>] kernel_thread_helper+0x5/0x14
> Aug 13 00:05:09 coyote kernel: Code: 89 50 04 89 02 89 49 04 89 09 8b 03 39 d8 89 c1 75 e2 b8 00
> Aug 13 00:05:09 coyote kernel:  <6>note: kswapd0[66] exited with preempt_count 1
> 
> The first 3 entries are from a nightly run of rsync, which mounts a
> normally unmounted partition for the duration of its run.

Hi fellows,

I've taken some time to look at this oopses, and I truly believe we 
are facing real corruption.

The symptom is that an inode's (blockdev) i_mapping->private_list gets corrupted, 
one of its buffer_head's contains a b_assoc_mapping list_head with NULL pointers. 

And this is not an SMP race, because Gene is not running SMP.

Gene's oops happens when remove_inode_buffers calls  __remove_assoc_queue(bh)

Ingo's oops happens while remove_inode_buffers does

 struct buffer_head *bh = BH_ENTRY(list->next);

which is

	mov ffffffd8(%ecx), (%somewhere)

%ecx is zero, so...

There is a bug somewhere.

--- a/fs/buffer.c.original	2004-08-14 00:19:55.000000000 -0300
+++ b/fs/buffer.c	2004-08-14 00:34:57.000000000 -0300
@@ -802,6 +802,8 @@
  */
 static inline void __remove_assoc_queue(struct buffer_head *bh)
 {
+	BUG_ON(bh->b_assoc_buffers.next == NULL);
+	BUG_ON(bh->b_assoc_buffers.prev == NULL);
 	list_del_init(&bh->b_assoc_buffers);
 }
 
@@ -1073,6 +1075,7 @@
 
 		spin_lock(&buffer_mapping->private_lock);
 		while (!list_empty(list)) {
+			BUG_ON(list->next == NULL);
 			struct buffer_head *bh = BH_ENTRY(list->next);
 			if (buffer_dirty(bh)) {
 				ret = 0;


Ingo oops for reference:
Unable to handle kernel paging request at virtual address ffffffd8
 printing eip:
c016a3d0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c016a3d0>]    Not tainted VLI
EFLAGS: 00010217   (2.6.8-rc2-mm2) 
EIP is at remove_inode_buffers+0x60/0xe0
eax: 00000000   ebx: c03ba9dc   ecx: 00000000   edx: c03ba8d0
esi: c03ba8d0   edi: c0379b2a   ebp: c4115ec4   esp: c4115eac
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 39, threadinfo=c4114000 task=c40aa070)
Stack: c03ba8d0 c0379b76 00000001 c03ba8d8 c03ba8d0 00000000 c4115ef8 c0186c4c 
       c03ba8d0 00000077 c4114000 00000000 0000004d 00000000 c4115ee4 c4115ee4 
       c4114000 c07fd6a0 00004e09 c4115f04 c0186df5 00000080 c4115f38 c014f4b3 
Call Trace:
 [<c01059ff>] show_stack+0x8f/0xb0
 [<c0105bb3>] show_registers+0x163/0x1d0
 [<c0105dc6>] die+0xe6/0x1c0
 [<c0117773>] do_page_fault+0x213/0x6c0
 [<c0105674>] exception_start+0x6/0xe
 [<c0186c4c>] prune_icache+0x20c/0x390
 [<c0186df5>] shrink_icache_memory+0x25/0x50
 [<c014f4b3>] shrink_slab+0x123/0x1d0
 [<c01511ee>] balance_pgdat+0x24e/0x2a0
 [<c015130c>] kswapd+0xcc/0xe0
 [<c0102899>] kernel_thread_helper+0x5/0xc
Code: 00 e0 ff ff 21 e0 ff 40 14 8d 47 4c 89 45 ec 31 c0 86 47 4c 84 c0 0f 8e 79 00 \
00 00 8b 86 0c 01 00 00 39 d8 74 23 89 c1 8d 76 00 <8b> 41 d8 a8 02 75 5a 8b 01 8b 51 \
04 89 02 89 09 89 50 04 8b 03   <6>note: kswapd0[39] exited with preempt_count 1

