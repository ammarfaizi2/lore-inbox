Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUI0V4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUI0V4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUI0V4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:56:16 -0400
Received: from wang.choosehosting.com ([212.42.1.230]:54759 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S267323AbUI0V4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:56:07 -0400
From: Thomas Stewart <thomas@stewarts.org.uk>
To: linux-kernel@vger.kernel.org
Subject: udev remove event not sent untill the device is closed
Date: Mon, 27 Sep 2004 22:52:36 +0100
User-Agent: KMail/1.6.2
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409272252.36016.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-09-27 22:56:06
X-Spam-Score: 0.4
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running 2.6.8.1 with udev-031. I have a usb2serial converter which has a 
udev rule to give it a persistent name in my dev tree. I want to run a script 
when the converter is attached, and another when the converter is removed.

I tried both the /etc/hotplug.d and /etc/dev.d methods to do this (I like the 
dev.d method better as I can use my persistent device name). Unfortunately I 
ran into problems.

I'm catching the tty event as it sets $DEVPATH to something useful 
(e.g. /devices/sys/class/tty/ttyUSB0). And then running a different script 
depending on $ACTION.

I made a short script to do this, and put it in /etc/dev.d/default/ttyUSB.dev:
#!/bin/sh
test "$1" != "tty" && exit
test "$ACTION" == "add"    && /usr/local/bin/on
test "$ACTION" == "remove" && /usr/local/bin/off

(I removed the various error checking that actually makes sure the tty event 
in question was actually the serial converter, and not some other device.)

This works fine, I can add and remove the converter to my hearts content and 
both scripts run accordingly.

However, if I attach the device, open it with say a "cat /dev/ttyUSB0" and 
then remove the device. No tty events get sent untill I kill the cat.

I want to be able to run the script when I remove the converter. (I actually 
want the remove script to kill the process that has the device open.)

I found it hard to use the usb events because when they run, $DEVPATH no 
longer exists. Which means I have no idea which converter was removed.

(Can replies be CC'ed to me as I'm not subscribed. Thanks)

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
