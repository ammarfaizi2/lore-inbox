Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280709AbRKODWr>; Wed, 14 Nov 2001 22:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280609AbRKODWh>; Wed, 14 Nov 2001 22:22:37 -0500
Received: from a23096.upc-a.chello.nl ([62.163.23.96]:49541 "EHLO ds9.galaxy")
	by vger.kernel.org with ESMTP id <S280606AbRKODWf>;
	Wed, 14 Nov 2001 22:22:35 -0500
Date: Thu, 15 Nov 2001 04:22:33 +0100 (CET)
From: Jos Nouwen <josn@josn.myip.org>
To: <linux-kernel@vger.kernel.org>
Subject: rootfs on USB storage device
Message-ID: <Pine.LNX.4.31.0111150349090.24081-100000@ds9.galaxy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I own a USB Pen Drive, which is perfectly working under Linux, I
wanted to put a linux rescue system on it. But for some reason it wont
work.

I linked in everything neccesary to boot from it: CONFIG_USB,
CONFIG_USB_DEVICEFS, CONFIG_USB_UHCI, CONFIG_USB_STORAGE, CONFIG_SCSI,
CONFIG_BLK_DEV_SD, CONFIG_EXT2_FS. I'm using kernel 2.4.15-pre4.

The problem is that the pendrive gets detected AFTER the kernel tries to
mount the root fs. Checking init/main.c and entering some debug lines
learns that the USB device gets detected when, in function init(), the
console gets opened: 'open("/dev/console", O_RDWR, 0)'. Immediately after
that, the 'init' program will be exec-ed. At the time of the 'open()'
call, the kernel printk()'s "hub.c: USB new device connect on bus1/1,
assigned device number 2", which is obviously the pendrive. It is
correctly registered, and a SCSI disk is emulated. But too late..

Does anybody have a clue as to what the USB bus has to do with
/dev/console?

Thanks for any help,
Jos Nouwen.

