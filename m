Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRIPKLg>; Sun, 16 Sep 2001 06:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRIPKL3>; Sun, 16 Sep 2001 06:11:29 -0400
Received: from [195.211.46.202] ([195.211.46.202]:30065 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S270387AbRIPKLT>;
	Sun, 16 Sep 2001 06:11:19 -0400
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Sun, 16 Sep 2001 12:09:40 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB Mailinglist <linux-usb-devel@lists.sourceforge.net>
Cc: <vojtech@suse.cz>
Subject: [BUG] hiddev.c 2.4.10-pre9
Message-ID: <Pine.LNX.4.33.0109161202490.30202-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML, USB-ML, Vojtech!

The initialization order of hid.o and hiddev.o is wrong:

drivers/usb/hiddev.c:573 hiddev_connect() is called by
drivers/usb/hid-core.c:1225 hid_probe() before
drivers/usb/hiddev.c:665 hiddev_init() is called.

This results in hiddev_devfs_handle being NULL for each hid-device handled
by hiddev, so that all device-nodes are created as /dev/hiddev%d instead
of /dev/usb/hid/hiddev%d.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

