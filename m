Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUAJWF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265408AbUAJWF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:05:57 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:44299 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S265405AbUAJWFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:05:46 -0500
To: linux-kernel@vger.kernel.org
CC: Roland Kwee <kweelist@xs4all.nl>
Subject: Sony DSC-F505V USB broken in linux-2.6.0
Reply-to: Roland Kwee <kweelist@xs4all.nl>
Message-Id: <E1AfR8E-0000HN-00@toba.home>
From: Roland Kwee <roland@tesla.xs4all.nl>
Date: Sat, 10 Jan 2004 22:58:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem
=======

After upgrading from linux-2.4.21 to 2.6.0,
my camera Sony DSC-F505V doesn't connect anymore.

What I tried myself
===================

I had to change a module name: usb-uhci    (2.4.21) --> uhci-hcd    (2.6.0),
and a hyphen:                  usb-storage (2.4.21) --> usb_storage (2.6.0)

I noticed that the F505 entry in unusual_devs.h changed in 2.6.0.
I fooled around with this a bit without seeing an improvement.

What does work
==============

The usb-storage part seems to work. See /var/log/message:

kernel: scsi0 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Sony      Model: Sony DSC          Rev: 2.10
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel: SCSI device sda: 126848 512-byte hdwr sectors (65 MB)

What is still missing
=====================

What is missing in 2.6.0 is the 2.4.21 log message:

   Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

Accordingly, 'mount' will fail with 'not a valid block device'.

Any help is appreciated. Thanks in advance!
Regards, Roland Kwee    (CC: to kweelist@xs4all.nl is appreciated)

NB:

$ lsmod
sd_mod                 12992  0 
usb_storage            28896  0 
scsi_mod              113636  2 sd_mod,usb_storage
uhci_hcd               40520  0 
usbcore               121940  4 usb_storage,uhci_hcd

