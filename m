Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVLLVtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVLLVtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLLVtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:49:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751310AbVLLVtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:49:21 -0500
Date: Mon, 12 Dec 2005 13:49:04 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: "block" symlink in sysfs for a multifunction device
Message-Id: <20051212134904.225dcc5d.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg,

When I plug a USB card reader with multiply LUNs, the following happens:

[zaitcev@niphredil ~]$ ls -l /sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0
total 0
-r--r--r-- 1 root root 4096 Dec 12 12:47 bAlternateSetting
-r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceClass
-r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceNumber
-r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceProtocol
-r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceSubClass
lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
-r--r--r-- 1 root root 4096 Dec 12 12:46 bNumEndpoints
lrwxrwxrwx 1 root root    0 Dec 12 12:46 bus -> ../../../../../../bus/usb
-r--r--r-- 1 root root 4096 Dec 12 12:47 diag
lrwxrwxrwx 1 root root    0 Dec 12 12:46 driver -> ../../../../../../bus/usb/drivers/ub
-r--r--r-- 1 root root 4096 Dec 12 12:46 modalias
drwxr-xr-x 2 root root    0 Dec 12 12:46 power
[zaitcev@niphredil ~]$ cat /proc/version
Linux version 2.6.14-nip (zaitcev@niphredil) (gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)) #5 Tue Dec 6 23:10:53 PST 2005
[zaitcev@niphredil ~]$

The usb-storage produces this:

[root@niphredil linux-2.6.14-nip]# find /sys -name block
/sys/block
/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:3/block
/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:2/block
/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:1/block
/sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:0/block
/sys/devices/pci0000:00/0000:00:07.1/ide0/0.0/block
[root@niphredil linux-2.6.14-nip]# ls -l /sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:0/block
lrwxrwxrwx 1 root root 0 Dec 12 13:44 /sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0/host0/target0:0:0/0:0:0:0/block -> ../../../../../../../../../block/sda
[root@niphredil linux-2.6.14-nip]#

Each "block" is in its own subdirectory.

Do you have a suggestion about the fastest way to accomplish the same
effect with ub?

Thank you,
-- Pete
