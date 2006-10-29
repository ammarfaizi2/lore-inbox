Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWJ2WiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWJ2WiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 17:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWJ2WiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 17:38:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030395AbWJ2WiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 17:38:23 -0500
Date: Sun, 29 Oct 2006 23:38:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6 git kernel reporting bug in knodemgrd_0 during boot
Message-ID: <20061029223822.GH27968@stusta.de>
References: <76366b180610291341y7342a968ycd244753ce9bbbb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76366b180610291341y7342a968ycd244753ce9bbbb7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 04:41:54PM -0500, Andrew Paprocki wrote:

> I just upgraded my dev box to the latest 2.6 source via git and this
> is now printing out in dmesg upon every boot. Hardware is a standard
> VIA EPIA-MII motherboard w/ nothing extra added. I can supply
> additional info if anyone requests it. -Andrew

The ieee1394 maintainers (Cc'ed) might be the best contact.

> Probing IDE interface ide0...
> hda: HITACHI_DK23DA-40, ATA DISK drive
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0040635000015f17]
> ------------[ cut here ]------------
> Kernel BUG at [verbose debug info unavailable]

The bug message with CONFIG_DEBUG_BUGVERBOSE=y set might be interesting.

> invalid opcode: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<b014932e>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.19-rc3-g2da6dc28 #1)
> EIP is at cache_alloc_refill+0x18e/0x400
> eax: 00000000   ebx: 0000003c   ecx: 00000000   edx: 00000000
> esi: bdfed770   edi: bdfed760   ebp: bdfea000   esp: bd2bbe00
> ds: 007b   es: 007b   ss: 0068
> Process knodemgrd_0 (pid: 174, ti=bd2ba000 task=bdfa8ab0 task.ti=bd2ba000)
> Stack: 000200d2 000000d2 bdfef0c0 bdfee1e0 0000003c 00000000 00000001 
> b03a61ec
>       000000d2 b03a61ec bdfa8ab0 00000246 00001fff 000000d2 00000163 
>       b0149192
>       be800000 b0143085 bd2bbe7c 00000002 ffffffff 00000001 000000d2 
>       ffffffff
> Call Trace:
> [<b0149192>] kmem_cache_alloc+0x22/0x30
> [<b0143085>] __get_vm_area_node+0x95/0x160
> [<b0143187>] get_vm_area_node+0x37/0x40
> [<b014370c>] __vmalloc_node+0x3c/0x60
> [<b014375f>] __vmalloc+0xf/0x20
> [<b0269ced>] csr1212_attach_keyval_to
> _directory+0x1d/0x60
> [<b026a52c>] csr1212_parse_keyval+0x14c/0x200
> [<b026a9be>] _csr1212_read_keyval+0x3de/0x420
> [<b0268185>] nodemgr_probe_ne+0x205/0x390
> [<b0179561>] sysfs_add_file+0x61/0x70
> [<b0268c3c>] nodemgr_host_thread+0x82c/0x980
> [<b0268410>] nodemgr_host_thread+0x0/0x980
> [<b0125a4f>] kthread+0xaf/0xe0
> [<b01259a0>] kthread+0x0/0xe0
> [<b0103d47>] kernel_thread_helper+0x7/0x10
> =======================
> Code: 04 89 37 83 7c 24 10 00 0f 8f 5a ff ff ff 8b 47 18 2b 45 00 89
> 47 18 83 7d 00 00 0f 85 61 02 00 00 f7 44 24 04 0e 80 f8 ff 74 02 <0f>
> 0b f7 44 24 04 00 20 00 00 0f 85 2d 02 00 00 8b 5c 24 04 81
> EIP: [<b014932e>] cache_alloc_refill+0x18e/0x400 SS:ESP 0068:bd2bbe00
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

