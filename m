Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVFWORQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVFWORQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVFWORQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:17:16 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:18899 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S262544AbVFWORL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:17:11 -0400
Message-ID: <23192954.1119536228604.JavaMail.root@web10.mail.adelphia.net>
Date: Thu, 23 Jun 2005 10:17:08 -0400
From: <cspalletta@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: /proc/mounts broken
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Sensitivity: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do a google on '/dev2/root2' and you will see that /proc/mounts on Debian reports false information for the root filesystem device, and this is a longstanding problem. The result is that on systems with this problem /etc/mtab is correct but /proc/mounts is not.

This appears to be more a kernel problem than a distribution problem - how is it even _possible_ for some userspace process to get /proc/mounts to publish erroneous information?  Why are there no consistency checks in /proc/mounts?

$ cat /proc/mounts
rootfs / rootfs rw 0 0
/dev2/root2 / ext3 rw 0 0
proc /proc proc rw,nodiratime 0 0
sysfs /sys sysfs rw 0 0
devpts /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
/dev/hda1 /boot ext2 rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0

$ ls -l /dev2 /dev2/root2
ls: /dev2: No such file or directory
ls: /dev2/root2: No such file or directory

$ mount -l
/dev/hda2 on / type ext3 (rw,errors=remount-ro) [debian-sarge-roo]
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda1 on /boot type ext2 (rw) [/boot]
usbfs on /proc/bus/usb type usbfs (rw)

$ uname -a
Linux nectarsys 2.6.10-1-k7 #1 Fri Mar 11 03:13:32 EST 2005 i686 GNU/Linux


