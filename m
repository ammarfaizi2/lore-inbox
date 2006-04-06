Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDFFLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDFFLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 01:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDFFLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 01:11:07 -0400
Received: from elvis.nosignal.org ([85.234.132.110]:26029 "EHLO
	elvis.nosignal.org") by vger.kernel.org with ESMTP id S1750815AbWDFFLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 01:11:06 -0400
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <DC943FFA-C291-4995-B3B7-DCECF0A6FEA5@nosignal.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Andy Davidson <andy@nosignal.org>
Date: Thu, 6 Apr 2006 06:11:11 +0100
X-Mailer: Apple Mail (2.746.2)
X-SA-Exim-Connect-IP: 194.73.16.246
X-SA-Exim-Mail-From: andy@nosignal.org
Subject: Soft lockup on Opteron cpu (2.6.15.4).
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on elvis.nosignal.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I've just had a nasty oops on an amd64 server.  Sadly I wasn't able  
to capture the entire stack trace, but I did get :
   http://elvis.nosignal.org/~andy/opteron_panic.jpg

Nothing was logged to syslog at the point of the panic, immediately  
before the server fell over there was this logged :

Apr  6 01:03:40 freezer kernel: dpti0: Trying to Abort cmd=61901448
Apr  6 01:03:51 freezer kernel: dpti0: Abort cmd not supported
Apr  6 01:03:51 freezer kernel: dpti0: Trying to reset device
Apr  6 01:03:51 freezer kernel: dpti0: Device reset not supported
Apr  6 01:03:51 freezer kernel: dpti0: Bus reset: SCSI Bus 0: tid: 9
Apr  6 01:03:51 freezer kernel: dpti0: Bus reset success.


I understand why a soft lockup might cause the kernel to oops.  What  
I don't understand is whether the above dpt flap could have caused  
the lockup ?  I've just upgraded to 2.6.16.1.

Anyone seen this before ?  Any more clues ?

cpu is dual AMD Opteron Processor 246.

other hardware :
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI  
(rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC  
(rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE  
(rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0  
(rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X  
Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC  
(rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X  
Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC  
(rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:02:05.0 RAID bus controller: Adaptec (formerly DPT) SmartRAID V  
Controller (rev 01)
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme  
BCM5704 Gigabit Ethernet (rev 03)
0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme  
BCM5704 Gigabit Ethernet (rev 03)
0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111  
USB (rev 0b)
0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111  
USB (rev 0b)
0000:03:05.0 Unknown mass storage controller: Silicon Image, Inc.  
(formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA  
Controller (rev 02)
0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL  
(rev 27)
0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro  
100] (rev 10)


.config at :  http://elvis.nosignal.org/~andy/opteron.config.txt

Using dpt_i2o as had problems with machines of the same hardware  
build (Adaptec SR V) when trying i2o_block on opteron around six  
months ago.



Thanks for reading this mail,
Andy


