Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTKITJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTKITJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:09:33 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:47889 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262777AbTKITJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:09:30 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: file2alias - incorrect? aliases for USB
Date: Sun, 9 Nov 2003 21:55:19 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311092155.19924.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

file2aliases puts in alias device ID high and low numbers directly from match 
specifications. E.g. for this match table entry:

usb-storage          0x000f      0x04e6   0x0006    0x0100       0x0205 ...

it generates alias

alias usb:v04E6p0006dl0100dh0205dc*dsc*dp*ic*isc*ip* usb_storage

unfortunately real device attribute does not include high and low - rather it 
has single device ID (as part of PRODUCT) that should be contained in these 
bounds:

        length += snprintf (scratch, buffer_size - length, "PRODUCT=%x/%x/%x",
                            usb_dev->descriptor.idVendor,
                            usb_dev->descriptor.idProduct,
                            usb_dev->descriptor.bcdDevice);

or bcdDevice file in sysfs.

This makes those aliases rather useless for the purpose of matching reported 
device. It may take the same route as PCI and reject all device ID table 
entries that have High != Low but there are quite a few of them available.

I am rather confused because I do not see how this condition (low <= bcdDevice 
<= high) can be expressed using simple glob pattern (unless we are going to 
take glob library from Zsh :)

thank you

-andrey


