Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750769AbWFEIe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWFEIe0 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWFEIe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:34:26 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:24583 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750769AbWFEIeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:34:24 -0400
Message-ID: <4483EC8C.6070507@rainbow-software.org>
Date: Mon, 05 Jun 2006 10:34:20 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: udev not called on USB disconnect
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm trying to do automount/umount for my Canon camera using udev. The 
camera does not support mass storage so I'm using gphotofs+fuse to 
access it.
I created canon.rules file in /etc/udev/rules.d which contains:

BUS=="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="306e", 
ACTION=="add", RUN+="/usr/bin/gphotofs /mnt/camera -o allow_other"
BUS=="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="306e", 
ACTION=="remove", RUN+="/sbin/umount -f /mnt/camera"

(the file contains only two lines).
When I plug in the camera, the first rule is executed and camera mounted 
properly. However, disconnecting it does not do anything, the second 
rule is never executed. I also tried rule as simple as:

BUS=="usb", RUN+="/bin/touch /123"

If I understand udev correctly, that should create /123 file on each USB 
event. It works when connecting the camera but does not do anything on 
disconnect.

USB connect/disconnect is properly detected by kernel (2.6.16):
usb 1-2: new full speed USB device using uhci_hcd and address 22
usb 1-2: configuration #1 chosen from 1 choice
usb 1-2: USB disconnect, address 22

Is this a bug or a feature?

-- 
Ondrej Zary
