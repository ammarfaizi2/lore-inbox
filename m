Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWGLIt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWGLIt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWGLIt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:49:57 -0400
Received: from mail.gmx.net ([213.165.64.21]:23991 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750964AbWGLIt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:49:56 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after
	failed suspend
From: Mike Galbraith <efault@gmx.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020607100440m2522fccie2b009a6a19fb630@mail.gmail.com>
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
	 <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
	 <1152527148.8700.8.camel@Homer.TheSimpsons.net>
	 <84144f020607100333s57159d38ha1101c65e8c099b1@mail.gmail.com>
	 <1152528686.9122.5.camel@Homer.TheSimpsons.net>
	 <84144f020607100440m2522fccie2b009a6a19fb630@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 10:55:53 +0200
Message-Id: <1152694553.8625.10.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 14:40 +0300, Pekka Enberg wrote:
> On Mon, 2006-07-10 at 13:33 +0300, Pekka Enberg wrote:
> > > Curious... GCC cuts line and file information after ud2a. Looking at
> > > your stack trace, I am wondering who calls free_block() as we don't
> > > see cache_flusharray() in the trace. Do you have CONFIG_NUMA enabled?
> 
> On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> > It got inlined.
> 
> Right. Can't spot anything obviously wrong with the code. Try
> CONFIG_DEBUG_SLAB if you can reproduce it.

I reproduced it, but got no info from CONFIG_DEBUG_SLAB, because it
didn't get that far.

BUG: unable to handle kernel paging request at virtual address 6c657472
 printing eip:
b108558c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in: ohci1394 prism54 xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device saa7134 ieee1394 edd ir_kbd_i2c snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore i2c_i801 bt878 snd_page_alloc ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom sd_mod nls_iso8859_1 nls_cp437 nls_utf8
CPU:    1
EIP:    0060:[<b108558c>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18-rc1-smp #1) 
EIP is at prune_one_dentry+0x23/0x7a
eax: 6c65746e   ebx: b15b611c   ecx: b15b6130   edx: b22390ec
esi: b15aa720   edi: ef660d84   ebp: ebb30e9c   esp: ebb30e94
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 29772, ti=ebb30000 task=ea87eaa0 task.ti=ebb30000)
Stack: b15b611c b15aa720 ebb30eb8 b1085826 b15b6124 00000375 ef04daf0 b15aa720 
       b15aa6e4 ebb30ed8 b108592c b15aa720 b15aa6e4 0000038f ef660d84 b15aa6e4 
       b148a740 ebb30ef4 b1074acb 00000000 cfb90000 0000000f b148a720 ebb30f4c 
Call Trace:
 [<b1085826>] prune_dcache+0x144/0x157
 [<b108592c>] shrink_dcache_parent+0xb4/0xe8
 [<b1074acb>] generic_shutdown_super+0x27/0x131
 [<b1074c19>] kill_anon_super+0x12/0x35
 [<b1074c55>] kill_litter_super+0x19/0x1c
 [<b1074cb5>] deactivate_super+0x5d/0x6f
 [<b1089506>] mntput_no_expire+0x44/0x74
 [<b107b0cf>] path_release_on_umount+0x15/0x18
 [<b108a5bc>] sys_umount+0x3b/0x265
 [<b108a7ff>] sys_oldumount+0x19/0x1b
 [<b10030b7>] syscall_call+0x7/0xb
 [<a7f3f73d>] 0xa7f3f73d
Code: fe ff ff 89 d8 5b 5d c3 55 89 e5 56 53 89 c3 8b 40 04 a8 10 75 1f 83 c8 10 89 43 04 8d 4b 14 8b 43 14 8b 51 04 89 02 85 c0 74 03 <89> 50 04 c7 41 04 00 02 20 00 8d 4b 34 8b 53 34 8b 41 04 89 42 
EIP: [<b108558c>] prune_one_dentry+0x23/0x7a SS:ESP 0068:ebb30e94

(gdb) list *prune_one_dentry+0x23
0xb108558c is in prune_one_dentry (list.h:614).
609     {
610             struct hlist_node *next = n->next;
611             struct hlist_node **pprev = n->pprev;
612             *pprev = next;
613             if (next)
614                     next->pprev = pprev;
615     }
616
617     static inline void hlist_del(struct hlist_node *n)
618     {
(gdb) list *prune_dcache+0x144
0xb1085826 is in prune_dcache (dcache.c:457).
452                     /*
453                      * If this dentry is for "my" filesystem, then I can prune it
454                      * without taking the s_umount lock (I already hold it).
455                      */
456                     if (sb && dentry->d_sb == sb) {
457                             prune_one_dentry(dentry);
458                             continue;
459                     }
460                     /*
461                      * ...otherwise we need to be sure this filesystem isn't being
(gdb)

