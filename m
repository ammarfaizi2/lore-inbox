Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUHYOwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUHYOwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUHYOwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:52:32 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:6589 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S267576AbUHYOvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:51:35 -0400
Message-Id: <200408251451.i7PEpQ7K020113@moist.atmos.washington.edu>
Date: Wed, 25 Aug 2004 07:51:26 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: page allocation or what in 2.6.8.1
From: Harry Edmon <harry@atmos.washington.edu>
X-Mailer: Ishmail 2.1.0-20021115-i686-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -15.628 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had another crash on the same system as my message of 23 August:

Unable to handle kernel paging request at virtual address cf0b4e1c

 printing eip:
c0178616
*pde = 0003f067
*pte = 0f0b4000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: af_packet nfs nfsd exportfs lockd sunrpc autofs capability co
mmoncap ipv6 eepro100 uhci_hcd usbcore pciehp shpchp pci_hotplug floppy pcspkr e
vdev e100 mii sd_mod 3w_xxxx scsi_mod ide_cd cdrom rtc reiserfs isofs ext2 ext3 
jbd mbcache ide_generic siimage aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk c
md64x piix rz1000 slc90e66 generic cs5530 cs5520 sc1200 triflex atiixp pdc202xx_
old pdc202xx_new opti621 ns87415 cy82c693 amd74xx sis5513 via82cxxx serverworks 
ide_core raid1 md unix
CPU:    0
EIP:    0060:[<c0178616>]    Not tainted
EFLAGS: 00010202   (2.6.8.1-debug) 
EIP is at iput+0x4e/0x7c
eax: cf0b4df8   ebx: de835eb4   ecx: 00000001   edx: c01785af
esi: c5a03f68   edi: de835eb4   ebp: f7454000   esp: f7455ebc
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 69, threadinfo=f7454000 task=f78b3a60)
Stack: de835ed0 c02d852c f7454000 c0174cce de835eb4 c035ef80 c5a03f68 f7454000 
       c90f4f68 c0175363 c5a03f68 d2614eb4 0000007b 00000080 f7454000 00000000 
       f7ffeb1c c017593d 00000080 c0147b2a 00000080 000000d0 00003e0e c201c7a0 
Call Trace:
 [<c0174cce>] dput+0x11a/0x25b
 [<c0175363>] prune_dcache+0x1bb/0x247
 [<c017593d>] shrink_dcache_memory+0x1f/0x45
 [<c0147b2a>] shrink_slab+0x150/0x1a4
 [<c014927c>] balance_pgdat+0x216/0x261
 [<c0149397>] kswapd+0xd0/0xee
 [<c011cf1e>] autoremove_wake_function+0x0/0x57
 [<c0105fba>] ret_from_fork+0x6/0x14
 [<c011cf1e>] autoremove_wake_function+0x0/0x57
 [<c01492c7>] kswapd+0x0/0xee
 [<c0104271>] kernel_thread_helper+0x5/0xb
Code: 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 1c 24 ff d2 
 <6>note: kswapd0[69] exited with preempt_count 1

Before the crash I see messages like the following:

oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:     1112520kB (1106368kB HighMem)
Active:19525 inactive:9757 dirty:10 writeback:0 unstable:0 free:278130 slab:2076
51 mapped:8904 pagetables:308
DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:32kB present:163
84kB
protections[]: 8 476 732
Normal free:4248kB min:936kB low:1872kB high:2808kB active:25112kB inactive:2502
0kB present:901120kB
protections[]: 0 468 724
HighMem free:1106240kB min:512kB low:1024kB high:1536kB active:53004kB inactive:
14024kB present:1179584kB
protections[]: 0 0 256
DMA: 0*4kB 0*8kB 57*16kB 9*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB
 0*4096kB = 1904kB
Normal: 624*4kB 3*8kB 0*16kB 6*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 0*20
48kB 0*4096kB = 4248kB
HighMem: 2242*4kB 4823*8kB 5072*16kB 4346*32kB 3379*64kB 2189*128kB 896*256kB 19
0*512kB 15*1024kB 0*2048kB 0*4096kB = 1106240kB
Swap cache: add 362198, delete 361774, find 247258/263510, race 0+3
Out of Memory: Killed process 6437 (apache2).

-- 
 Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
 206-543-0547				harry@u.washington.edu
 Dept of Atmospheric Sciences		FAX:	206-543-0308
 University of Washington, Box 351640, Seattle, WA 98195-1640
