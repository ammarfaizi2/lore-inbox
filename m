Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUBEMuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbUBEMuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:50:54 -0500
Received: from medusa.csi-inc.com ([204.17.222.19]:4736 "EHLO
	medusa.csi-inc.com") by vger.kernel.org with ESMTP id S264505AbUBEMuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:50:52 -0500
Message-ID: <000701c3ebe6$ac5b35d0$c8de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Hotswap IDE
Date: Thu, 5 Feb 2004 07:50:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use a removable IDE chassis to allow me to mirror my primary drive for offsite storage.
I'd like to hotswap the IDE but can't seem to get the drive to allow DMA access after restarting it.
A reboot is necessary for DMA access.
I'm using idectl from hdparm-5.4 which generates the following hdparm commands:
/sbin/hdparm -U 1 /dev/hda
/sbin/hdparm -R 0x170 0 0 /dev/hda


After doing an "idectl 1 off", "idectl 1 on" hdparm gives an error:
hdparm -d 1 /dev/hdc

/dev/hdc:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Operation not permitted
using_dma    =  0 (off)

And strace shows the following ioctl failing:
ioctl(3, 0x326, 0x1)                    = -1 EPERM (Operation not permitted)

I can set 32-bit I/O and unmask IRQ but not DMA.
During the hdparm add the kernel messages look just like the boot messages:
Feb  5 06:57:12 medusa kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  5 06:57:12 medusa kernel: hdc: max request size: 1024KiB
The re-add messages are missing one of the boot messages though:
Feb  5 06:44:35 medusa kernel: hdc: WDC WD1200BB-00DWA0, ATA DISK drive


I've now been able to repeat this on two different motherboards and have had the problem with linux 2.4.24 and 2.6.2

Anybody have any idea why re-adding an IDE drive in this mannger prevents DMA access?
Is anybody able to sucessfuly do this on their system?

Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL
