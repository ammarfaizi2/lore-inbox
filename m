Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131151AbQK2VDu>; Wed, 29 Nov 2000 16:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131370AbQK2VDk>; Wed, 29 Nov 2000 16:03:40 -0500
Received: from mail01.onetelnet.fr ([213.78.0.138]:22286 "EHLO
        mail01.onetelnet.fr") by vger.kernel.org with ESMTP
        id <S131151AbQK2VDY>; Wed, 29 Nov 2000 16:03:24 -0500
Message-ID: <3A25756A.6A71D792@onetelnet.fr>
Date: Wed, 29 Nov 2000 22:30:18 +0100
From: Fort David <epopo@onetelnet.fr>
Reply-To: epopo@onetelnet.fr
Organization: DLR network
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [BUG]2.4.0test11 and 2.4.0test12-pre3, sound looping for ever
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i've got a strange bug: after some hours of uptime sound starts looping
for ever. I always have this in my
logs: "unexpected IRQ trap at vector 7d". There's no Ooops and i can
only stop sound by killing "esd". Of
course, i can't run it anymore after it has been killed.
2.4.0test10 wasn't exibiting this.

my soundcard uses es1371 module. the box is a BP6 + 2celerons. This bug
is hard to reproduce, it
is really odd and happens randomly.(if it happens again i'll try to
check /proc/interrupt)

/proc/interrupt:
           CPU0       CPU1
  0:      60829      54977    IO-APIC-edge  timer
  1:       1170       1176    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:      35624      35568   IO-APIC-level  usb-uhci, nvidia
 10:     212625     212089   IO-APIC-level  es1371
 11:      30821      30701   IO-APIC-level  ide0, eth0
 12:      13392      13506    IO-APIC-edge  PS/2 Mouse
 14:         33          8    IO-APIC-edge  ide2
NMI:     115731     115731
LOC:     115696     115711
ERR:          5

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-00efffff : System RAM
  00100000-0021d3bf : Kernel code
  0021d3c0-0023239f : Kernel data
00f00000-00ffffff : reserved
01000000-0ffeffff : System RAM
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation GeForce 256
    d0000000-d03fffff : vesafb
d8000000-d9ffffff : PCI Bus #01
  d8000000-d8ffffff : nVidia Corporation GeForce 256
da000000-dbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
dc000000-dc7fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
dd000000-dd003fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
de000000-de7fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e0000000-e000007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

/proc/ioport:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide2
0290-0297 : w83782d
02f8-02ff : serial(auto)
03c0-03df : vesafb
03f6-03f6 : ide2
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
  5000-5007 : piix4-smbus
c000-c01f : Intel Corporation 82371AB PIIX4 USB
  c000-c01f : usb-uhci
c400-c47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  c400-c47f : eth0
c800-c83f : Ensoniq ES1371 [AudioPCI-97]
  c800-c83f : es1371
cc00-cc07 : Triones Technologies, Inc. HPT366
  cc00-cc07 : ide0
d000-d003 : Triones Technologies, Inc. HPT366
  d002-d002 : ide0
d400-d4ff : Triones Technologies, Inc. HPT366
  d400-d407 : ide0
  d410-d4ff : HPT366
d800-d807 : Triones Technologies, Inc. HPT366 (#2)
dc00-dc03 : Triones Technologies, Inc. HPT366 (#2)
e000-e0ff : Triones Technologies, Inc. HPT366 (#2)
  e000-e007 : ide1
  e010-e0ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide2
  f008-f00f : ide3


--
%-------------------------------------------------------------------------%
% FORT David,                                                             %
% 7 avenue de la morvandiere                                   0240726275 %
% 44470 Thouare, France                                epopo@onetelnet.fr %
% ICU:78064991   AIM: enlighted popo             fort@irin.univ-nantes.fr %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/flashed PHP3 coming soon   |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlighted....            |  ^^-^^                        %
% http://ibonneace.{dnsalias.org,hypermart.net}/ when {connected,offline} %
%-------------------------------------------------------------------------%



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
