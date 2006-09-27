Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWI0JAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWI0JAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWI0JAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:00:48 -0400
Received: from mx1.ciphirelabs.net ([217.72.114.64]:61068 "EHLO
	mx1.ciphirelabs.net") by vger.kernel.org with ESMTP
	id S1750986AbWI0JAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:00:47 -0400
Message-ID: <451A3D9E.6040709@ciphirelabs.com>
Date: Wed, 27 Sep 2006 11:00:14 +0200
From: Andreas Jellinghaus <aj@ciphirelabs.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 8/16bit usb minor device number problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the minor number of usb devices in /dev/bus/usb trunkated.
where do I look for debugging this problem? kernel? filesystem code?
udev? glibc? something else?

foo:/dev/bus/usb/003# ls -l
total 0
crw-rw-r--  1 root root 189, 0 Sep 26 11:52 001
crw-rw-r--  1 root root 189, 1 Sep 26 11:52 002
foo:/dev/bus/usb/003# cat /sys/class/usb_device/usbdev3.2/dev
189:257
foo:/dev/bus/usb/003#

no wonder my app fails talking to the device, it was
created with the wrong minor device number.

debian package with backport to sarge:
Version: 0.100-1~bpo.1

udev config:
# usbfs-like devices
SUBSYSTEM=="usb_device",        PROGRAM="/bin/sh -c 'K=%k;
K=$${K#usbdev}; printf bus/usb/%%03i/%%03i $${K%%%%.*} $${K#*.}'", \
                                 NAME="%c"

for now I can work around it with "rm -rf /dev/bus", but can
someone help me finding the real solution?

Thanks, Andreas
