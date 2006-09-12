Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWILIME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWILIME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWILIME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:12:04 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:63618 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S965002AbWILIA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:00:29 -0400
Message-ID: <450668F0.6060805@uni-hd.de>
Date: Tue, 12 Sep 2006 09:59:44 +0200
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: Kernel 2.6.17.x in free_uid ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after several crashes with Kernel 2.6.17.11, we switched back to
2.6.16.28 which runs now for 2 weeks w/o problems.

IMHO there seems to be a bug in 2.6.17 series of the kernel.

Any ideas how to narrow the problem down ?

Here is my problem description:

since our kernel-update from 2.6.16 (which was runnig 100d w/o any
probs) to 2.6.17.11 we had  two crashes on our squid and samba server.
the kernel gets only to this output than freezes totally ...

Aug 31 13:05:08 serv4 kernel: BUG: unable to handle kernel paging
request at virtual address 00100104
Aug 31 13:05:08 serv4 kernel:  printing eip:
Aug 31 13:05:08 serv4 kernel: c0127b19


in System.map I have these corresponding addresses

c0127a50 T find_user
c0127ad0 T free_uid
c0127b60 T alloc_uid
c0127ca0 T switch_uid
c0127cd0 t sig_ignored

System-data:

uname -a
Linux serv4 2.6.17.11 #1 SMP Sun Aug 27 13:39:34 CEST 2006 i686 i686
i386 GNU/Linux
####
lspci
0000:00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory
Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP
Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corporation 82875P/E7210 Processor to PCI
to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R)
IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]
0000:02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit
Ethernet Controller (LOM)
0000:03:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
0000:03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378
(FastTrak 378/SATA 378) (rev 02)
0000:03:0a.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
###
cat /proc/cpuinfo
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 5
cpu MHz         : 2806.922
cache size      : 512 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5613.24

###
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: Arena EX Model:                  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: FUJITSU  Model: MAP3735NP        Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: FUJITSU  Model: MAP3735NP        Rev: 0108
  Type:   Direct-Access                    ANSI SCSI revision: 03

###
Filesystem: ext3

tia,
martin


