Return-Path: <linux-kernel-owner+w=401wt.eu-S1753103AbWLQWLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbWLQWLz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbWLQWLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 17:11:55 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:38989 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753099AbWLQWLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 17:11:54 -0500
X-Greylist: delayed 4152 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 17:11:53 EST
Date: Sun, 17 Dec 2006 23:02:10 +0200
From: Riku Voipio <riku.voipio@iki.fi>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       romieu@fr.zoreil.com, rmk@arm.linux.org.uk
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061217210209.GA13632@kos.to>
References: <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061215211435.GB10367@flint.arm.linux.org.uk> <20061216230901.GA23143@xi.wantstofly.org> <20061216233134.GA25177@electric-eye.fr.zoreil.com> <20061216235245.GA23238@xi.wantstofly.org> <20061217192812.GD17535@deprecation.cyrius.com> <20061217195635.GA10181@kos.to> <20061217195728.GF23747@xi.wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217192812.GD17535@deprecation.cyrius.com>
X-message-flag: Warning: message not sent with a DRM-Certified client
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > bah. 2.6.20-git shows nothing (with or without Lennert's patch) after
> > the following:
 
> > Uncompressing Linux..........................................................................................done, booting the kernel.
> 
> Try the printascii()-in-printk() hack in my svn tree.

Thanks, that was priceless advice. I reverted 
da2c12a279ae225f3d4696f76cb3b32a5bec5bfb "[ARM] Clean up ioremap code"
and n2100 booted fine. I can now confirm Lennerts patch makes 
r8169 work without any module parameter work on Thecus n2100.

With ioremap cleanup code and printascii, the kernel boot looks
like following:

Uncompressing Linux............................................................................
<5>Linux version 2.6.20-rc1n2100 (nchip@watergate-2) (gcc version 4.1.0) #8 Sun Dec 17 22:09:06
CPU: XScale-80219 [69052e30] revision 0 (ARMv5TE), cr=0000397f
Machine: Thecus N2100
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 65536
<7>  DMA zone: 512 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 65024 pages, LIFO batch:15
<7>  Normal zone: 0 pages used for memmap
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
CPU0: D cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
Built 1 zonelists.  Total pages: 65024
<5>Kernel command line: console=ttyS0,115200 root=/dev/sda1 mem=256M@0xa0000000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Memory: 256MB = 256MB total
<5>Memory: 256896KB available (2568K code, 185K data, 104K init)
<7>Calibrating delay loop... 593.10 BogoMIPS (lpj=2965504)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>NET: Registered protocol family 16
<6>PCI: bus0: Fast back to back transfers disabled
<5>SCSI subsystem initialized
<7>libata version 2.00 loaded.
<6>usbcore: registered new interface driver usbfs
<6>usbcore: registered new interface driver hub
<6>usbcore: registered new device driver usb
<6>NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
<6>TCP: Hash tables configured (established 8192 bind 4096)
<6>TCP reno registered
<4>NetWinder Floating Point Emulator V0.97 (extended precision)
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<6>JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<2>remap_area_pte: page already exists
<2>kernel BUG at arch/arm/mm/ioremap.c:61!
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 8f5 [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x20/0x2c
LR is at 0x1
pc : [<c0026988>]    lr : [<00000001>]    Not tainted
sp : c0531ee0  ip : 60000093  fp : c0531eec
r10: d0850000  r9 : d0850000  r8 : 80250000
r7 : d0a00000  r6 : c0521000  r5 : d0850c00  r4 : d0850c00
r3 : 00000000  r2 : 00000000  r1 : 000008ac  r0 : 0000002b
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 397F
Table: A0004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc0530250)
Stack: (0xc0531ee0 to 0xc0532000)
1ee0: c0531f38 c0531ef0 c0029ee8 c0026974 d0850c00 00000400 c0007420 000000a3
1f00: c0007420 d0850000 800a0000 800a0000 00000000 c0546400 c0291478 00000000
1f20: 00000000 00000000 00000000 c0531f4c c0531f3c c0029fe0 c0029bf4 c0291470
1f40: c0531f7c c0531f50 c01984dc c0029f8c c0157b54 c0291470 c0546400 c0291478
1f60: 00000000 00000000 00000000 00000000 c0531f98 c0531f80 c01361d0 c0198334
1f80: c0546400 c001e6f8 c0530000 c0531fac c0531f9c c0134f4c c0136140 c001ec84
1fa0: c0531ff4 c0531fb0 c00220c0 c0134f3c 00000000 00000000 c002202c c003f14c
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 c0531ff8 c003f14c c0022038 00000000 00000000
Backtrace:
[<c0026968>] (__bug+0x0/0x2c) from [<c0029ee8>] (__ioremap_pfn+0x300/0x398)
[<c0029be8>] (__ioremap_pfn+0x0/0x398) from [<c0029fe0>] (__ioremap+0x60/0x6c)
[<c0029f80>] (__ioremap+0x0/0x6c) from [<c01984dc>] (quirk_usb_early_handoff+0x1b4/0x380)
 r4 = C0291470
[<c0198328>] (quirk_usb_early_handoff+0x0/0x380) from [<c01361d0>] (pci_fixup_device+0x9c/0xd4)
[<c0136134>] (pci_fixup_device+0x0/0xd4) from [<c0134f4c>] (pci_init+0x1c/0x3c)
 r6 = C0530000  r5 = C001E6F8  r4 = C0546400
[<c0134f30>] (pci_init+0x0/0x3c) from [<c00220c0>] (init+0x94/0x27c)
 r4 = C001EC84
[<c002202c>] (init+0x0/0x27c) from [<c003f14c>] (do_exit+0x0/0x7e4)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: e1a01000 e59f000c eb00596d e3a03000 (e5833000)
 <0>Kernel panic - not syncing: Attempted to kill init!

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=da2c12a279ae225f3d4696f76cb3b32a5bec5bfb
