Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVLVOnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVLVOnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVLVOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:43:49 -0500
Received: from web34104.mail.mud.yahoo.com ([66.163.178.102]:25977 "HELO
	web34104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965170AbVLVOnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:43:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Q1XK5vzJtEPF4m2VhYUNvHlP1m6DdCLr6yMKlPrt0BvSGzg905UHMQovT1XmLlKOBUFH4UMLfywkKn+kyd4O8JXcqoWeCf56a4rKgtWP399CSFI/SbLv3kNXJalufr+q4T3D2R7Xn0tzlH6nD2enE7AEn3OI7WLlTVyrFEZtQvw=  ;
Message-ID: <20051222144348.85266.qmail@web34104.mail.mud.yahoo.com>
Date: Thu, 22 Dec 2005 06:43:48 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: scsi errors with dpt-i2o driver
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  We have been experiencing long system pauses (~30 seconds), and think we have tracked it down to
a scsi issue. The syslog just after the pause has:
Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264682
Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264683
Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264684
Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
Dec 22 04:12:06 tux224 kernel: dpti0: Trying to reset device
Dec 22 04:12:06 tux224 kernel: dpti0: Device reset not supported
Dec 22 04:12:06 tux224 kernel: dpti0: Bus reset: SCSI Bus 0: tid: 9
Dec 22 04:12:06 tux224 kernel: dpti0: Bus reset success.

The previous time seen by the system (as reported by sar with a 1-second frequency), was 04:11:29.
These errors seem to happen only every few days, and we have not found a means to reproduce them
on demand.

Are there any suggestions about how to diagnose further?  What about trying the native i2o driver?

Details:
The machine is a dual Opteron rack-mount server.
kernel is 2.6.15-rc6 w/ preempt.
lspci:
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:02:05.0 RAID bus controller: Adaptec (formerly DPT) SmartRAID V Controller (rev 01)
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

The scsi controller is model 2015s.  The disks are Seagate Cheetah Ultra 320 - model ST336607LC.

Other potentially interresting messages from dmesg:
[    1.490153] Loading Adaptec I2O RAID: Version 2.4 Build 5go
[    1.496872] Detecting Adaptec I2O RAID controllers...
[    1.502983] ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 26 (level, low) -> IRQ 169
[    1.512165] Adaptec I2O RAID controller 0 irq=169
[    1.517865]      BAR0 f8880000 - size= 100000
[    1.523127]      BAR1 f8a00000 - size= 1000000
[    3.391459] dpti: If you have a lot of devices this could take a few minutes.
[    3.400032] dpti0: Reading the hardware resource table.
[   13.298799] TID 008  Vendor: ADAPTEC      Device: AIC-7902     Rev: 00000001    
[   13.309206] TID 009  Vendor: ADAPTEC      Device: AIC-7902     Rev: 00000001    
[   13.324229] TID 523  Vendor: ADAPTEC R    Device: RAID-10      Rev: 3B05D       
[   13.337469] scsi0 : Vendor: Adaptec  Model: 2015S            FW:3B05
[   13.345860]   Vendor: ADAPTEC   Model: RAID-10           Rev: 3B05
[   13.355339]   Type:   Direct-Access                      ANSI SCSI revision: 02
[   13.365151] Adaptec aacraid driver (1.1-4 Dec 20 2005 09:00:40)
[   13.372343] megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
[   13.381055] megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
[   13.389406] megasas: 00.00.02.00-rc4 Fri Sep 16 12:37:08 EDT 2005
[   13.396752] 3ware 9000 Storage Controller device driver for Linux v2.26.02.004.
[   13.413525] SCSI device sda: 143372288 512-byte hdwr sectors (73407 MB)
[   13.424515] SCSI device sda: drive cache: write back
[   13.432733] SCSI device sda: 143372288 512-byte hdwr sectors (73407 MB)
[   13.443708] SCSI device sda: drive cache: write back
[   13.449709]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
[   13.505791] sd 0:0:0:0: Attached scsi disk sda


thanks,
-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
