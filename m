Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTHYMpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTHYMpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:45:50 -0400
Received: from ls401.hinet.hr ([195.29.150.2]:52161 "EHLO ls401.hinet.hr")
	by vger.kernel.org with ESMTP id S261814AbTHYMpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:45:43 -0400
Date: Mon, 25 Aug 2003 14:45:36 +0200
From: Mario Mikocevic <mario.mikocevic@htnet.hr>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test4 repeatable
Message-ID: <20030825124536.GG14801@danielle.hinet.hr>
References: <20030825091846.GA15017@danielle.hinet.hr> <20030825104035.B30952@flint.arm.linux.org.uk> <20030825102504.GC14801@danielle.hinet.hr> <20030825115538.C30952@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030825115538.C30952@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Pon, Kol 25, 2003 at 12:55:38 +0200
X-Mailer: Balsa 2.0.13
X-Trace: ls401.hinet.hr 1061815538 9020 195.29.148.143 (Mon, 25 Aug 2003 14:45:38 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2003.08.25 12:55, Russell King wrote:
> Ok so it isn't a BUG().  The next thing I'd consider is whether it was
> a corrupted pci driver list, but it doesn't look like it.
> 
> Ok, lets try to get some extra info from your kernel - please apply
> the patch below.  This is likely to produce a fair amount of extra
> messages at boot.  It should also produce another raft of messages
> when you insert the cardbus card but before the module, and another
> raft afterwards.
> 
> I'm only interested in the ones around the time when you insert the
> cardbus card and the module.

OK, first some additional testing info, at first I thought it was
repeatable in the _very_ _same_ manner but not _quite_.
I have two possible scenarios ->

 - after some time (never more than a minute or two) of plugging DWL-650+
   into slot thinkpad-r40 just shuts itself down, no oops, _no_ nothing

 - loading modules shortens time to shutdown to few seconds and _sometimes_
   produces oops, so I have to do several plug_in/*plonk*/turn_on/fsck/reboot
   iterations to get oops

Here's latest oops, this time provocated with loading modules snd-intel8x0 and
acx100_pci (yesterdays 0.1h version from http://acx100.sourceforge.net/) ->


Aug 25 13:42:09 mozz-r40 kernel: pci_dev: 0000:00:1f.5 driver: d0916580 name: Intel ICH table: d0915be0 probe: d0911f9e
Aug 25 13:42:10 mozz-r40 kernel: intel8x0: clocking to 48000
Aug 25 13:42:26 mozz-r40 kernel: pci_dev: 0000:03:00.0 driver: d090c400 name: acx100_pci table: d090c3a0 probe: d0823000
Aug 25 13:42:26 mozz-r40 kernel: Unable to handle kernel paging request at virtual address d0823000
Aug 25 13:42:26 mozz-r40 kernel:  printing eip:
Aug 25 13:42:26 mozz-r40 kernel: d0823000
Aug 25 13:42:26 mozz-r40 kernel: *pde = 012d0067
Aug 25 13:42:26 mozz-r40 kernel: *pte = 00000000
Aug 25 13:42:26 mozz-r40 kernel: Oops: 0000 [#1]
Aug 25 13:42:26 mozz-r40 kernel: CPU:    0
Aug 25 13:42:26 mozz-r40 kernel: EIP:    0060:[<d0823000>]    Not tainted
Aug 25 13:42:26 mozz-r40 kernel: EFLAGS: 00010286
Aug 25 13:42:26 mozz-r40 kernel: EIP is at 0xd0823000
Aug 25 13:42:26 mozz-r40 kernel: eax: d090c3a0   ebx: d090c400   ecx: d090c3a0   edx: d090c3a0
Aug 25 13:42:26 mozz-r40 kernel: esi: c135c400   edi: ffffffed   ebp: c135c4a8   esp: ce037ba8
Aug 25 13:42:26 mozz-r40 kernel: ds: 007b   es: 007b   ss: 0068
Aug 25 13:42:26 mozz-r40 kernel: Process cardctl (pid: 3352, threadinfo=ce036000 task=cf1ba700)
Aug 25 13:42:26 mozz-r40 kernel: Stack: c01a604b c135c400 d090c3a0 d090c3a0 d0823000 c135c400 d090c400 ffffffed
Aug 25 13:42:26 mozz-r40 kernel:        c01a619c d090c400 c135c400 d090c400 c135c400 c01a61db d090c400 c135c400
Aug 25 13:42:26 mozz-r40 kernel:        d090c428 c135c454 c01eaaa7 c135c454 d090c428 d090c458 c135c454 c0322d1c
Aug 25 13:42:26 mozz-r40 kernel: Call Trace:
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a604b>] pci_device_probe_static+0x8d/0x9e
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a619c>] __pci_device_probe+0x3b/0x4e
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a61db>] pci_device_probe+0x2c/0x4a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eaaa7>] bus_match+0x3f/0x6a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eab13>] device_attach+0x41/0x91
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eacd2>] bus_add_device+0x5b/0x9f
Aug 25 13:42:26 mozz-r40 kernel:  [<c01e9d97>] device_add+0xca/0x100
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a2a85>] pci_bus_add_devices+0xcf/0x114
Aug 25 13:42:26 mozz-r40 kernel:  [<d08cc04a>] cb_alloc+0xab/0xe5 [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08c90e3>] socket_insert+0x7f/0x92 [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08cb63d>] pcmcia_insert_card+0x71/0x7e [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08bbbed>] ds_ioctl+0x285/0x670 [ds]
Aug 25 13:42:26 mozz-r40 kernel:  [<c0179323>] padzero+0x28/0x2a
Aug 25 13:42:26 mozz-r40 kernel:  [<c0179fe5>] load_elf_binary+0x522/0xb51
Aug 25 13:42:26 mozz-r40 kernel:  [<c011b775>] pgd_alloc+0x18/0x1c
Aug 25 13:42:26 mozz-r40 kernel:  [<c011e8ff>] mm_init+0x98/0xd2
Aug 25 13:42:26 mozz-r40 kernel:  [<c013d963>] buffered_rmqueue+0xc1/0x15a
Aug 25 13:42:26 mozz-r40 kernel:  [<c013da8e>] __alloc_pages+0x92/0x30c
Aug 25 13:42:26 mozz-r40 kernel:  [<c0181921>] proc_alloc_inode+0x4c/0x75
Aug 25 13:42:26 mozz-r40 kernel:  [<c0146d78>] do_anonymous_page+0x138/0x22a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01473b3>] handle_mm_fault+0xd9/0x16e
Aug 25 13:42:26 mozz-r40 kernel:  [<c011ba26>] do_page_fault+0x23a/0x44b
Aug 25 13:42:26 mozz-r40 kernel:  [<c0139e39>] find_get_page+0x2d/0x57
Aug 25 13:42:26 mozz-r40 kernel:  [<c013af05>] filemap_nopage+0x223/0x303
Aug 25 13:42:26 mozz-r40 kernel:  [<c0155667>] unlock_buffer+0x33/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156d17>] __find_get_block+0x6b/0xe0
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156db7>] __getblk+0x2b/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156d17>] __find_get_block+0x6b/0xe0
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156db7>] __getblk+0x2b/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c018bffb>] ext2_release_inode+0x7a/0xad
Aug 25 13:42:26 mozz-r40 kernel:  [<c018c16a>] ext2_free_inode+0x13c/0x183
Aug 25 13:42:26 mozz-r40 kernel:  [<c018f9d9>] ext2_destroy_inode+0x1b/0x1f
Aug 25 13:42:26 mozz-r40 kernel:  [<c016c118>] destroy_inode+0x35/0x50
Aug 25 13:42:26 mozz-r40 kernel:  [<c016d37a>] iput+0x62/0x7c
Aug 25 13:42:26 mozz-r40 kernel:  [<c0163427>] sys_unlink+0x86/0x135
Aug 25 13:42:26 mozz-r40 kernel:  [<c016598a>] sys_ioctl+0xf9/0x27b
Aug 25 13:42:26 mozz-r40 kernel:  [<c010b1b5>] sysenter_past_esp+0x52/0x71
Aug 25 13:42:26 mozz-r40 kernel:
Aug 25 13:42:26 mozz-r40 kernel: Code:  Bad EIP value.

ksymoops 2.4.9 on i686 2.6.0-test4-rk1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.0-test4-rk1/ (default)
     -m /boot/System.map-2.6.0-test4-rk1 (specified)

No modules in ksyms, skipping objects
Aug 25 13:39:27 mozz-r40 kernel: Machine check exception polling timer started.
Aug 25 13:39:28 mozz-r40 kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Aug 25 13:39:28 mozz-r40 kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Aug 25 13:39:28 mozz-r40 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 25 13:39:28 mozz-r40 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
Aug 25 13:39:28 mozz-r40 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 25 13:42:26 mozz-r40 kernel: Unable to handle kernel paging request at virtual address d0823000
Aug 25 13:42:26 mozz-r40 kernel: d0823000
Aug 25 13:42:26 mozz-r40 kernel: *pde = 012d0067
Aug 25 13:42:26 mozz-r40 kernel: Oops: 0000 [#1]
Aug 25 13:42:26 mozz-r40 kernel: CPU:    0
Aug 25 13:42:26 mozz-r40 kernel: EIP:    0060:[<d0823000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 25 13:42:26 mozz-r40 kernel: EFLAGS: 00010286
Aug 25 13:42:26 mozz-r40 kernel: eax: d090c3a0   ebx: d090c400   ecx: d090c3a0   edx: d090c3a0
Aug 25 13:42:26 mozz-r40 kernel: esi: c135c400   edi: ffffffed   ebp: c135c4a8   esp: ce037ba8
Aug 25 13:42:26 mozz-r40 kernel: ds: 007b   es: 007b   ss: 0068
Aug 25 13:42:26 mozz-r40 kernel: Stack: c01a604b c135c400 d090c3a0 d090c3a0 d0823000 c135c400 d090c400 ffffffed
Aug 25 13:42:26 mozz-r40 kernel:        c01a619c d090c400 c135c400 d090c400 c135c400 c01a61db d090c400 c135c400
Aug 25 13:42:26 mozz-r40 kernel:        d090c428 c135c454 c01eaaa7 c135c454 d090c428 d090c458 c135c454 c0322d1c
Aug 25 13:42:26 mozz-r40 kernel: Call Trace:
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a604b>] pci_device_probe_static+0x8d/0x9e
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a619c>] __pci_device_probe+0x3b/0x4e
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a61db>] pci_device_probe+0x2c/0x4a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eaaa7>] bus_match+0x3f/0x6a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eab13>] device_attach+0x41/0x91
Aug 25 13:42:26 mozz-r40 kernel:  [<c01eacd2>] bus_add_device+0x5b/0x9f
Aug 25 13:42:26 mozz-r40 kernel:  [<c01e9d97>] device_add+0xca/0x100
Aug 25 13:42:26 mozz-r40 kernel:  [<c01a2a85>] pci_bus_add_devices+0xcf/0x114
Aug 25 13:42:26 mozz-r40 kernel:  [<d08cc04a>] cb_alloc+0xab/0xe5 [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08c90e3>] socket_insert+0x7f/0x92 [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08cb63d>] pcmcia_insert_card+0x71/0x7e [pcmcia_core]
Aug 25 13:42:26 mozz-r40 kernel:  [<d08bbbed>] ds_ioctl+0x285/0x670 [ds]
Aug 25 13:42:26 mozz-r40 kernel:  [<c0179323>] padzero+0x28/0x2a
Aug 25 13:42:26 mozz-r40 kernel:  [<c0179fe5>] load_elf_binary+0x522/0xb51
Aug 25 13:42:26 mozz-r40 kernel:  [<c011b775>] pgd_alloc+0x18/0x1c
Aug 25 13:42:26 mozz-r40 kernel:  [<c011e8ff>] mm_init+0x98/0xd2
Aug 25 13:42:26 mozz-r40 kernel:  [<c013d963>] buffered_rmqueue+0xc1/0x15a
Aug 25 13:42:26 mozz-r40 kernel:  [<c013da8e>] __alloc_pages+0x92/0x30c
Aug 25 13:42:26 mozz-r40 kernel:  [<c0181921>] proc_alloc_inode+0x4c/0x75
Aug 25 13:42:26 mozz-r40 kernel:  [<c0146d78>] do_anonymous_page+0x138/0x22a
Aug 25 13:42:26 mozz-r40 kernel:  [<c01473b3>] handle_mm_fault+0xd9/0x16e
Aug 25 13:42:26 mozz-r40 kernel:  [<c011ba26>] do_page_fault+0x23a/0x44b
Aug 25 13:42:26 mozz-r40 kernel:  [<c0139e39>] find_get_page+0x2d/0x57
Aug 25 13:42:26 mozz-r40 kernel:  [<c013af05>] filemap_nopage+0x223/0x303
Aug 25 13:42:26 mozz-r40 kernel:  [<c0155667>] unlock_buffer+0x33/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156d17>] __find_get_block+0x6b/0xe0
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156db7>] __getblk+0x2b/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156d17>] __find_get_block+0x6b/0xe0
Aug 25 13:42:26 mozz-r40 kernel:  [<c0156db7>] __getblk+0x2b/0x51
Aug 25 13:42:26 mozz-r40 kernel:  [<c018bffb>] ext2_release_inode+0x7a/0xad
Aug 25 13:42:26 mozz-r40 kernel:  [<c018c16a>] ext2_free_inode+0x13c/0x183
Aug 25 13:42:26 mozz-r40 kernel:  [<c018f9d9>] ext2_destroy_inode+0x1b/0x1f
Aug 25 13:42:26 mozz-r40 kernel:  [<c016c118>] destroy_inode+0x35/0x50
Aug 25 13:42:26 mozz-r40 kernel:  [<c016d37a>] iput+0x62/0x7c
Aug 25 13:42:26 mozz-r40 kernel:  [<c0163427>] sys_unlink+0x86/0x135
Aug 25 13:42:26 mozz-r40 kernel:  [<c016598a>] sys_ioctl+0xf9/0x27b
Aug 25 13:42:26 mozz-r40 kernel:  [<c010b1b5>] sysenter_past_esp+0x52/0x71
Aug 25 13:42:26 mozz-r40 kernel: Code:  Bad EIP value.


>>EIP; d0823000 <__crc_neigh_parms_release+357d6/b22398>   <=====

>>eax; d090c3a0 <__crc_neigh_parms_release+11eb76/b22398>
>>ebx; d090c400 <__crc_neigh_parms_release+11ebd6/b22398>
>>ecx; d090c3a0 <__crc_neigh_parms_release+11eb76/b22398>
>>edx; d090c3a0 <__crc_neigh_parms_release+11eb76/b22398>
>>esi; c135c400 <__crc_skb_under_panic+4125f/11200a>
>>edi; ffffffed <__kernel_rt_sigreturn+1bad/????>
>>ebp; c135c4a8 <__crc_skb_under_panic+41307/11200a>
>>esp; ce037ba8 <__crc_cdrom_mode_sense+211ce2/2a69c4>

Trace; c01a604b <pci_device_probe_static+8d/9e>
Trace; c01a619c <__pci_device_probe+3b/4e>
Trace; c01a61db <pci_device_probe+2c/4a>
Trace; c01eaaa7 <bus_match+3f/6a>
Trace; c01eab13 <device_attach+41/91>
Trace; c01eacd2 <bus_add_device+5b/9f>
Trace; c01e9d97 <device_add+ca/100>
Trace; c01a2a85 <pci_bus_add_devices+cf/114>
Trace; d08cc04a <__crc_neigh_parms_release+de820/b22398>
Trace; d08c90e3 <__crc_neigh_parms_release+db8b9/b22398>
Trace; d08cb63d <__crc_neigh_parms_release+dde13/b22398>
Trace; d08bbbed <__crc_neigh_parms_release+ce3c3/b22398>
Trace; c0179323 <padzero+28/2a>
Trace; c0179fe5 <load_elf_binary+522/b51>
Trace; c011b775 <pgd_alloc+18/1c>
Trace; c011e8ff <mm_init+98/d2>
Trace; c013d963 <buffered_rmqueue+c1/15a>
Trace; c013da8e <__alloc_pages+92/30c>
Trace; c0181921 <proc_alloc_inode+4c/75>
Trace; c0146d78 <do_anonymous_page+138/22a>
Trace; c01473b3 <handle_mm_fault+d9/16e>
Trace; c011ba26 <do_page_fault+23a/44b>
Trace; c0139e39 <find_get_page+2d/57>
Trace; c013af05 <filemap_nopage+223/303>
Trace; c0155667 <unlock_buffer+33/51>
Trace; c0156d17 <__find_get_block+6b/e0>
Trace; c0156db7 <__getblk+2b/51>
Trace; c0156d17 <__find_get_block+6b/e0>
Trace; c0156db7 <__getblk+2b/51>
Trace; c018bffb <ext2_release_inode+7a/ad>
Trace; c018c16a <ext2_free_inode+13c/183>
Trace; c018f9d9 <ext2_destroy_inode+1b/1f>
Trace; c016c118 <destroy_inode+35/50>
Trace; c016d37a <iput+62/7c>
Trace; c0163427 <sys_unlink+86/135>
Trace; c016598a <sys_ioctl+f9/27b>
Trace; c010b1b5 <sysenter_past_esp+52/71>



-- 
Mario Mikocevic (Mozgy)
mozgy at hinet dot hr
It's never too late to have a good childhood!
      The older you are, the better the toys!
My favourite FUBAR ...
