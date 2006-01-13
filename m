Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWAMKgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWAMKgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161554AbWAMKgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:36:55 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:40083 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161267AbWAMKgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:36:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VWIE8twk08kk85W5ArHhMFTZlwG3xHfgB9WhqRHZmorFT8F7dfKtkDcM4dw1krOAJLh0cWWJ4Kb/vv7tOO4koaPF1ajfqgfipxBSDCINvTZJl0mckkKN0DpGb8vzEOw6SZc1U3FgbqlLHcRZbYOq7oSfVUpFJeL5HipDO1hnF7M=
Message-ID: <8bcbe9bd0601130230l1ab3eab5te5e88e463c5b05c1@mail.gmail.com>
Date: Fri, 13 Jan 2006 18:30:46 +0800
From: jinhong hu <jinhong.hu@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: kernel 2.6.15 scsi problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

host A and host B are connected to the same FC switch with qla2300 HBA card.
And I can see device such as "/dev/sda" through command "fdisk -l" on A.
but if I reboot host B, then the device is removed for some reason.
The messages are:
kernel:  rport-0:0-0: blocked FC remote port time out: removing target and
saving binding
kernel:  rport-1:0-0: blocked FC remote port time out: removing target and
saving binding

My problem is, the device can not come back automaticly unless I reload
the driver module "qla2300". But after I reload module "qla2300" on host A,
the device on host B disappeared.
Now I've updated my kernel to 2.6.15.git6ÅB I select the driver as:
<*> QLogic QLA2XXX Fibre Channel Support
[ ]     Use firmware-loader modules (DEPRECATED)
but After I reboot my host to the new kernel, I can not find the device.
The logs are:
Jan 11 16:53:07 nd10 kernel: QLogic Fibre Channel HBA Driver
Jan 11 16:53:07 nd10 kernel: ACPI: PCI Interrupt 0000:07:01.0[A] -> GSI 96
(level, low) -> IRQ 169
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Found an ISP2312, irq 169,
iobase 0xf8816000
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Configuring PCI space...
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Configure NVRAM
parameters...
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Verifying loaded RISC
code...
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Firmware image unavailable.
Jan 11 16:53:07 nd10 kernel: qla2xxx 0000:07:01.0: Failed to initialize adapter
Jan 11 16:53:07 nd10 kernel: Trying to free free IRQ169
Jan 11 16:53:07 nd10 kernel: ACPI: PCI interrupt for device 0000:07:01.0
disabled
Jan 11 16:53:07 nd10 kernel: ACPI: PCI interrupt for device 0000:07:01.0
disabled
Jan 11 16:53:07 nd10 kernel: ACPI: PCI Interrupt 0000:07:01.1[B] -> GSI 97
(level, low) -> IRQ 177
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Found an ISP2312, irq 177,
iobase 0xf8816000
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Configuring PCI space...
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Configure NVRAM
parameters...
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Verifying loaded RISC
code...
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Firmware image unavailable.
Jan 11 16:53:08 nd10 kernel: qla2xxx 0000:07:01.1: Failed to initialize adapter
Jan 11 16:53:08 nd10 kernel: Trying to free free IRQ177


if I select the driver as:
 <M> QLogic QLA2XXX Fibre Channel Support
 [*]     Use firmware-loader modules (DEPRECATED)
 <M>       Build QLogic ISP2100 firmware-module
 <M>       Build QLogic ISP2200 firmware-module
 <M>       Build QLogic ISP2300 firmware-module
 <M>       Build QLogic ISP2322 firmware-module
 <M>       Build QLogic ISP63xx firmware-module
 <M>       Build QLogic ISP24xx firmware-module

The problem of the comment 5 already exists.
Howerver, if I use the kernel 2.6.11.3, I've not encountered this problem.

What can I do for my system?


------- Additional Comment #8 From Luckey 2006-01-11 01:52 -------
after I type the command "fdisk -l", the logs are:
Jan 11 17:57:47 nd10 kernel:  rport-10:0-0: blocked FC remote port time out:
removing target and saving binding
Jan 11 17:57:48 nd10 kernel:  10:0:0:0: SCSI error: return code = 0x10000
Jan 11 17:57:48 nd10 kernel: end_request: I/O error, dev sda, sector 0
Jan 11 17:57:48 nd10 kernel: Buffer I/O error on device sda, logical block 0
Jan 11 17:57:48 nd10 kernel:  10:0:0:0: rejecting I/O to dead device
Jan 11 17:57:48 nd10 kernel: Buffer I/O error on device sda, logical block 0
Jan 11 17:58:23 nd10 kernel:  rport-11:0-0: blocked FC remote port time out:
removing target and saving binding
Jan 11 17:58:23 nd10 kernel:  11:0:0:0: SCSI error: return code = 0x10000
Jan 11 17:58:23 nd10 kernel: end_request: I/O error, dev sdb, sector 0
Jan 11 17:58:23 nd10 kernel: Buffer I/O error on device sdb, logical block 0
Jan 11 17:58:23 nd10 kernel:  11:0:0:0: rejecting I/O to dead device
Jan 11 17:58:23 nd10 kernel: Buffer I/O error on device sdb, logical block 0
