Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268160AbUH0IjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbUH0IjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUH0IjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:39:12 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:24690 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S269264AbUH0Ieh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:34:37 -0400
X-Ironport-AV: i="3.84,115,1091422800"; 
   d="scan'208"; a="59667156:sNHT85229514"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: CDROMPLAYTRKIND ioctl causing server hang
Date: Fri, 27 Aug 2004 13:57:07 +0530
Message-ID: <BBE1167D4F12C74681106630ADE282B964A025@blrx2kmbgl303.blr.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CDROMPLAYTRKIND ioctl causing server hang
Thread-Index: AcSMD5sbkN1kLPwDRQ2YbxB+12i5aQ==
From: <Ganesh_Borse@Dell.com>
To: <linux-kernel-owner@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Aug 2004 08:27:08.0041 (UTC) FILETIME=[A432D790:01C48C0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(1)
Doing CDROMPLAYTRKIND ioctl on bus powered USB CD drive:TEAC CD-ROM 210-PU causes server to hang.
CD drive was connected to USB port directly. Known good audio CD was inserted .

OS is Red Hat Linux AS 3.0, kernel 2.4.21-4.ELsmp.

As soon as this ioctl is called on /dev/scd node, kernel printk's the following messages in /var/log/messages file:
	Aug 24 10:42:15 PE2600-7XP2B1S kernel: sr2: CDROM (ioctl) reports ILLEGAL REQUEST.
	Aug 24 10:42:15 PE2600-7XP2B1S kernel: usb-uhci.c: interrupt, status 3, frame# 1495
	Aug 24 10:42:20 PE2600-7XP2B1S kernel: usb-uhci.c: interrupt, status 3, frame# 312
	Aug 24 10:42:50 PE2600-7XP2B1S kernel: usb_control/bulk_msg: timeout
	Aug 24 10:42:50 PE2600-7XP2B1S kernel: usb-uhci.c: interrupt, status 3, frame# 1685
	Aug 24 10:43:11 PE2600-7XP2B1S kernel: usb_control/bulk_msg: timeout
	Aug 24 10:43:11 PE2600-7XP2B1S kernel: usb.c: USB disconnect on device 00:1d.0-2 address 2

After the last line (USB disconnect..) logged in messages file, server hangs. Even the ssh connection from other server hangs. We have to switch off the server manually by pressing power switch.

(2)
I read on some Linux related posts on internet that CDROMPLAYTRKIND ioctl is not supported by SCSI drivers (ide-scsi, usb-scsi, etc.).
I used CDROMPLAYMSF for playing the CD and above problem did not occur. ioctl passed.

(3)
Also, when I connected this USB CD drive to an external hub (self-powered), ioctl failed but the server did not hang. However, the drive got disconnected.

(4)
Is there a known issue in 2.4.21-4 kernel related to CDROMPLAYTRKIND ioctl or usb driver? If yes, what is Bugzilla id for it?

Please guide.

Thanks,
Ganesh
