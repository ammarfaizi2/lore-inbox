Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWEARRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWEARRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWEARRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:17:10 -0400
Received: from tag.witbe.net ([81.88.96.48]:19100 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932164AbWEARRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:17:09 -0400
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: X not starting... AGPGART error with 2.6.17-rc3, not with 2.6.16-1.2096_FC5
Date: Mon, 1 May 2006 19:17:06 +0200
Organization: Witbe.net
Message-ID: <00c401c66d43$13b67980$2001a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZtQxIrr+7Q5M5YTJyxK+09jngX5g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've installed an FC5 x86_64 on my machine, and everything is fine when
running fedora-supplied kernels : machine boots, X starts, and so on.

But, when switching to 2.6.17-rc3 (or any other official 2.6.16.x kernel),
I've got the following issue :
 - machine boots fine,
 - starting X results in the screen switching video mode (CRT, so I can 'hear'
   it), and then X starts sucking all the CPUs, and nothing comes to screen.
 - I've got the following in /var/log/messages :

May  1 19:09:38 riri kernel: agpgart: Found an AGP 3.0 compliant device at
0000:00:00.0.
May  1 19:09:38 riri kernel: agpgart: Badness. Don't know which AGP mode to
set. [bridge_agpstat:1f000a0a vga_agpstat:ff00021b fell back to:-
bridge_agpstat:1f000208 vga_agpstat:ff00021b]
May  1 19:09:38 riri kernel: agpgart: Bridge couldn't do AGP x4.
May  1 19:09:38 riri kernel: agpgart: Putting AGP V3 device at 0000:00:00.0
into 0x mode
May  1 19:09:38 riri kernel: agpgart: Putting AGP V3 device at 0000:01:00.0
into 0x mode
May  1 19:09:38 riri kernel: [drm] Setting GART location based on old memory
map
May  1 19:09:38 riri kernel: [drm] Loading R300 Microcode
May  1 19:09:38 riri kernel: [drm] writeback test failed

and then X is stone dead, can't be killed even using kill -9, and it can't
be straced...

lspci says :
00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890
South]
00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev 80)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak
378/SATA 378) (rev 02)
00:09.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit
Ethernet Controller (rev 13)
00:0c.0 Network controller: RaLink Ralink RT2500 802.11G Cardbus/mini-PCI (rev
01)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237
AC97 Audio Controller (rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem
Controller (rev 80)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 9550]
01:00.1 Display controller: ATI Technologies Inc RV350 ?? [Radeon 9550]
(Secondary)


I can't find why this happens... This machine was previously running FC4, 
with vanilla kernel, and it was fine... 
But as here the problem comes from changing the kernel stuff, and nothing
else, I'm encline to think it may be kernel related...

Any idea ?

Regards,
Paul

