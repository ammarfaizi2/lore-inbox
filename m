Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265330AbTF1Sqh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 14:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTF1Sqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 14:46:37 -0400
Received: from pal-213-228-128-91.netvisao.pt ([213.228.128.91]:31368 "HELO
	front3.netvisao.pt") by vger.kernel.org with SMTP id S265330AbTF1Sqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 14:46:32 -0400
Date: Sat, 28 Jun 2003 20:00:47 +0100
To: linux-kernel@vger.kernel.org
Subject: Asus CD-S520/A kernel I/O error
Message-ID: <20030628190047.GA629@deneb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Marco Ferra <marcoferra@netvisao.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something's wrong on the kernels ide/atapi interface for cd-rom's.  I
got a Asus CD-S520/A and it seems that I can't sweep from the beginning
to the end of the CD without getting a sense error.  Commands like:

dd if=/dev/scd0 of=/file.iso
dd if=/dev/hdc of=/file.iso

give

---

Jun 28 19:28:33 deneb kernel:  I/O error: dev 0b:00, sector 1159912
Jun 28 19:28:33 deneb kernel:  I/O error: dev 0b:00, sector 1160064

(note)
the sectors do change if I change de medium, but on the same medium the
falty sectores are always the same.  All the cd's are in top conditions
without a scratch and clean.

---

(with and without the scsi emulation) are pointless.  On my former HP
9100c cdr/rw writer and Phillips 40x reader this didn't happen.  What is
also curious is that original brand cd's (like a game or the maxim's cd
data catalog) is red 100% by this Asus cd reader.  I thought is as not
an error with the interface but with cdrecord but after testing a cd
burned with nero (windows os) the same happened.  If I change brands the
same happens too (tested TDK and Sony).

As a final note it seems that when mounted the cd can be accessed
perfectly (or so it seems).

I would write a patch/workaround myself but it seems that I can't
understand this behaviour.

Hoping that this report was useful.. best regards, Marco Ferra.

--- Debian GNU/Linux 3.0r1 ---

My configuration:

Motherboard: ASUS CUV4X

cat /proc/version
Linux version 2.4.18 (root@deneb) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Mon Jun 23 00:27:00 WEST 2003

cat /proc/version
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 701.626
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1399.19

cat /proc/modules
ipt_state                576   2
ipt_mac                  640   0 (unused)
ipt_limit                960   0 (unused)
ipt_LOG                 3072   0 (unused)
ip_conntrack_irc        2400   0 (unused)
ip_conntrack_ftp        3136   0 (unused)
ip_conntrack           12884   3 [ipt_state ip_conntrack_irc
ip_conntrack_ftp]
mga                   102480   1
agpgart                12448   3

(note: scsi emulation is directly on the kernel image)

cat /proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
b400-b43f : Ensoniq ES1371 [AudioPCI-97]
  b400-b43f : es1371
b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  b800-b8ff : 8139too
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-13febfff : System RAM
  00100000-002343e9 : Kernel code
  002343ea-00292b77 : Kernel data
13fec000-13feefff : ACPI Tables
13fef000-13ffefff : reserved
13fff000-13ffffff : ACPI Non-volatile Storage
f8000000-f80000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  f8000000-f80000ff : 8139too
f8800000-f9efffff : PCI Bus #01
  f8800000-f8ffffff : Matrox Graphics, Inc. MGA G400 AGP
  f9000000-f9003fff : Matrox Graphics, Inc. MGA G400 AGP
f9f00000-fbffffff : PCI Bus #01
  fa000000-fbffffff : Matrox Graphics, Inc. MGA G400 AGP
fc000000-fdffffff : VIA Technologies, Inc. VT8605 [ProSavage PM133]
ffff0000-ffffffff : reserved

cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ASUS     Model: CD-S520/A        Rev: 2.0K
  Type:   CD-ROM                           ANSI SCSI revision: 02
