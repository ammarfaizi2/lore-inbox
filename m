Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131891AbRCMVp5>; Tue, 13 Mar 2001 16:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131875AbRCMVpt>; Tue, 13 Mar 2001 16:45:49 -0500
Received: from [195.211.46.202] ([195.211.46.202]:18528 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S131860AbRCMVpm>;
	Tue, 13 Mar 2001 16:45:42 -0500
Date: Tue, 13 Mar 2001 10:21:25 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 8139too
Message-ID: <Pine.LNX.4.33.0103130943020.24009-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

i686 2.4.2 UP+kdb+lm_sensors+pcmcia
after APM laptop suspend to disk
8139too is build-in, not pcmcia
I often get hangups after suspend-to-disk if I'm connected to a hub/switch.
This is the first oops I've actually seen and copied it by hand:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000

Entering kdb (current=0xc31e8000, pid 10509) Oops: Oops
due to oops @ 0xc902a470
eax = 0x00000000 ebx = 0xc2249220 ecx = 0xc9077554 edx = 0x00000014
esi = 0x04000001 eds = 0x00000009 esp = 0xc31e9de8 eip = 0xc902a470
ebp = 0xc64c6400 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010282
eds = 0x00000018 ces = 0x00000018 origeax = 0xffffffff &eregs = 0xc31e9db4
kbd> bt
    EBP       EIP         Function(args)
0xc64c6400 0xc902a470 [8139too]rtl8139_interrupt+0x1c (0x9, 0xc64c6400, 0xc31e9e50)
                               8139too .text 0xc9028060 0xc902a454 0xc902a5bc
           0xc010a46f handle_IRQ_event+0x2f (0x9, 0xc31e9e50, 0xc7b727c0)
                               kernel .text 0xc0100000 0xc010a440 0xc010a498
0xc31e9e48 0xc010a5ce do_IRQ+0x6e (0xc104f3e4, 0xc7f324e4, 0xab, 0xc026fa20, 0xc7f69e40)
                               kernel .text 0xc0100000 0xc010a560 0xc010a610
           0xc0108e44 ret_from_iret
                               kernel .text 0xc0100000 0xc0108e44 0xc0108e64
Interrupt registers:
eax = 0xc7fa5d0c ebx = 0xc104f3e4 ecx = 0xc7f324e4 edx = 0x000000ab
esi = 0xc026fa20 edi = 0xc7f69e40 esp = 0xc31e9e84 eip = 0xc012852c
ebp = 0x000000ab xss = 0x00000018 xcs = 0x00000010 eflags = 0200000246
xds = 0xc4260018 xes = 0xc31e0018 origeax = 0xffffff09 %regs = 0xc31e9e50
           0xc012852c agp_page_up (0xc104f3e4)
                               kernel .text 0xc0100000 0xc012852c 0xc0128558
           0xc0123598 __find_get_page+0x28 (0xc7f324e4, 0xab, 0xc7fa5d0c)
                               kernel .text 0xc7f324e4 0xc0123570 0xc01235d8
           0xc0124423 filemap_nopage+0xab (0xc026fa20, 0x400e7000, 0x)
                               kernel .text 0xc0100000 0xc0124378 0xc0124778
           0xc01215a8 do_no_page+0x50 (0xc7f69e40, 0xc026fa20, 0x400e7dc0, 0x0, 0xc360639c)
                               kernel .text 0xc0100000 0xc0121558 0xc0121608
more>
           0xc0121700 handle_mm_fault+0xf8 (0xc7f69e40, 0xc026fa20, 0x400e7dc0, 0x, 0xc31e8000)
                               kernel .text (0xc0100000 0xc0121608 0xc012176c
           0xc0112587 do_page_fault+0x143 (0xc31e9fc4, 0x4, 0x4015af64, 0xbffffa2c, 0xbfffffa5c)
                               kernel .text 0xc0100000 0xc0112444 0xc0112850
           0xc0108eb8 error_code+0x34
                               kernel .text 0xc0100000 0xc0108e84 0xc0108ec0
Interrupt registers:
eax = 0x0000002a ebx = 0x4015af64 ecx = 0xbffffa2c edx = 0xbffffa5c
esi = 0x400165e4 edi = 0x00000008 esp = 0xbffffa78 eip = 0x400e7dc0
ebp = 0xbffffa94 xss = 0x0000002b xcs = 0x00000023 efalgs = 0x00010246
xds = 0xbfff002b xes = 0x0000002b origeax = 0xffffffff &regs = 0xc31e9fc4
kbd> lsmod
Module                  Size  modstruct      Used by
af_packet              12323  0xc9030000      2  (autoclean)
8139too                16601  0xc9028000      1  (autoclean)
autofs                 12700  0xc9091000      1  (autoclean)
ds                      8263  0xc907e000      2
i82365                 26839  0xc9072000      2
pcmcia_core            49205  0xc9064000      0  [ ds i82365 ]
adm1021                 6286  0xc9025000      0  (unused)
sensors                 7855  0xc9022000      0  [ adm1021 ]
i2c-piix4               4601  0xc901f000      0  (unused)
i2c-core               16818  0xc9019000      0  [ adm1021 sensors i2c-piix4 ]
apm                    10916  0xc9015000      2
binfmt_misc             4251  0xc9012000      0

-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

