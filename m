Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275006AbRIYN4g>; Tue, 25 Sep 2001 09:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275004AbRIYN4T>; Tue, 25 Sep 2001 09:56:19 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:38107 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S275007AbRIYN4C>; Tue, 25 Sep 2001 09:56:02 -0400
Date: Tue, 25 Sep 2001 14:56:28 +0100 (BST)
From: <matt@thebachchoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: autofs oops 2.4.9-ac10-jfs, 2.4.9-ac15
Message-ID: <Pine.LNX.4.33.0109251446390.13536-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This, on a Debian woody box, everything modular, autofs4 module (probably
autofs.o too), 1000MHz Athlon, (nb doesn't occur from same kernel tree on
our SMP PIII with VIA Apollo Pro133x), the following chipset:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0f.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 0c)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1)

The oops (from my 2.4.9-ac10 tree with extra ext3 & jfs patches, both in
modules not loaded at the time):

Sep 25 14:10:00 nonet kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000254
Sep 25 14:10:00 nonet kernel: c01b5be7
Sep 25 14:10:00 nonet kernel: *pde = 00000000
Sep 25 14:10:00 nonet kernel: Oops: 0000
Sep 25 14:10:00 nonet kernel: CPU:    0
Sep 25 14:10:00 nonet kernel: EIP:    0010:[fast_copy_page+55/240]
Sep 25 14:10:00 nonet kernel: EFLAGS: 00010246
Sep 25 14:10:00 nonet kernel: eax: 0000003a   ebx: 00000254   ecx: ce62a000   edx: ce6c2000
Sep 25 14:10:00 nonet kernel: esi: ce62a000   edi: 0e65d065   ebp: cfef88a4   esp: ce6c3e8c
Sep 25 14:10:00 nonet kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 14:10:00 nonet kernel: Process S20autofs (pid: 352, stackpage=ce6c3000)
Sep 25 14:10:00 nonet kernel: Stack: c13d2338 c13d30c4 c01204ab ce62a000 00000254 00000000 00000000 00000000
Sep 25 14:10:00 nonet kernel:        00000000 080b5890 ffffffff 00000001 cfef88a4 c0120b5d cfef88a4 ce66cecc
Sep 25 14:10:00 nonet kernel:        080b5890 ce6c02d4 0e65d065 00000000 ce654000 ce654000 ce6d8000 ce655f7c
Sep 25 14:10:00 nonet kernel: Call Trace: [do_wp_page+475/592] [handle_mm_fault+157/208] [schedule+642/976] [do_page_fault+374/1152] [pipe_wait+136/176]
Sep 25 14:10:00 nonet kernel: Code: 0f 6f 03 0f e7 06 0f 6f 4b 08 0f e7 4e 08 0f 6f 53 10 0f e7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 6f 03                  movq   (%ebx),%mm0
Code;  00000003 Before first symbol
   3:   0f e7 06                  movntq %mm0,(%esi)
Code;  00000006 Before first symbol
   6:   0f 6f 4b 08               movq   0x8(%ebx),%mm1
Code;  0000000a Before first symbol
   a:   0f e7 4e 08               movntq %mm1,0x8(%esi)
Code;  0000000e Before first symbol
   e:   0f 6f 53 10               movq   0x10(%ebx),%mm2
Code;  00000012 Before first symbol
  12:   0f e7 00                  movntq %mm0,(%eax)


Any more info on request, but things are rather busy. Haven't yet tried
noapic/nodma, would this info be useful?

Matt

