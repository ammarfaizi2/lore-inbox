Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbUATFYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 00:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUATFYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 00:24:42 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:55214 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264559AbUATFYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 00:24:39 -0500
Date: Mon, 19 Jan 2004 21:24:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: nico_206@noos.fr
Subject: [Bug 1914] New: When I change my memory flash card,	I have to reload the usb_storage module to see my new flash card
Message-ID: <3960000.1074576278@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1914

           Summary: When I change my memory flash card, I have to reload the
                    usb_storage module to see my new flash card
    Kernel Version: 2.6.0
            Status: NEW
          Severity: high
             Owner: dwmw2@infradead.org
         Submitter: nico_206@noos.fr


====================
Distribution: gentoo
=====================
Hardware Environment:
---- /proc/scsi/scsi :
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: USB Storage-SMC  Rev: 0090
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic  Model: USB Storage-CFC  Rev: 0090
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic  Model: USB Storage-MMC  Rev: 0090
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic  Model: USB Storage-MSC  Rev: 0090
  Type:   Direct-Access                    ANSI SCSI revision: 02
---- part of /proc/modules
usb_storage 37504 0 - Live 0xe1982000
ohci_hcd 27776 0 - Live 0xe19b0000
---- part of /proc/bus/usb/device :
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:02.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=0aec ProdID=5010 Rev= 1.00
S:  Manufacturer=Generic 
S:  Product=Generic USB Storage Device
S:  SerialNumber=0AEC305000001A002
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

The flash card reader i use is a 7 in 1 noname reader usb that can read
smartmedia, compactflash ...
I use a smartmedia (8, 32 and 128 Mo)
===============================
Software Environment: 
Linux version 2.6.0 (root@attaque) (version gcc 3.2.3 20030422 (Gentoo Linux 1.4
3.2.3-r3, propolice)) #1 Mon Dec 29 10:25:49 CET 2003
===============================
Problem Description: When I plug a flash card, use it, umount the file-system,
then plug another flash card. Then the only way to use the new flash card is to
unload (rmmod) the usb_storage module and reload it (modprobe) and mount the
file-system. If I do not reload kernel module, I see the old file-system.
But when i unload the module usb-storage, the directory /dev/scsi/hostX already
exist and each time i reload the module usb_storage, i have a new directory
/dev/scsi/hostX (first time host1, then host2, then host3 ...)

The most problem is that we have to be root to do theses manipulations : a
simple user can not use a flash card. And i can not use /etc/fstab because i
have a new host each times I plug a new card.

I have tested this bug on all versions of 2.6-test1 to test 11 and there is the
same problem. Iremember when i was on kernel 2.4, it works good :-)) but I do
not remember exactly what kernel version it was (nearly 2.4.18 or 2.4.19)
=======================================
Steps to reproduce: plug a flash card, use it, umount the file-system, then plug
another flash card. Then you do not see the new file-system, but file-system of
the first card.

