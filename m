Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264375AbUE3Uy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUE3Uy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUE3Uy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:54:57 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:39034 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264375AbUE3Uy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:54:56 -0400
Date: Sun, 30 May 2004 15:54:52 -0500
From: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Udev thinks my cdrom is a char device?
Message-ID: <20040530205450.GA2747@ryanr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't use my CD-ROM drive too often, and in fact I think the last time I
did was 4 April, to make a backup; at the time I was running 2.6.4, patched
with supermount and bootsplash.  Now I run 2.6.5, and I find the following
odd situation in /dev:

# ls -l /dev/hd*
brw-rw-rw-    1 root     root       3,   0 May 13 07:18 /dev/hda
brw-rw-rw-    1 root     root       3,   1 May 13 07:18 /dev/hda1
brw-rw-rw-    1 root     root       3,  64 May 13 07:18 /dev/hdb
brw-rw-rw-    1 root     root       3,  65 May 13 07:18 /dev/hdb1
brw-rw-rw-    1 root     root       3,  66 May 13 07:18 /dev/hdb2
brw-rw-rw-    1 root     root       3,  69 May 13 07:18 /dev/hdb5
brw-rw-rw-    1 root     root       3,  70 May 13 07:18 /dev/hdb6
brw-rw-rw-    1 root     root       3,  71 May 13 07:18 /dev/hdb7
brw-rw-rw-    1 root     root       3,  72 May 13 07:18 /dev/hdb8
crw-rw-rw-    1 root     root      22,   0 May 30 15:41 /dev/hdc

It's probably not just me that hdc (my CD-ROM) should be a block device.  I
use udev to manage /dev but I haven't touched a line of any script in months;
deleting and recreating the device with udev reproduces the problem.  If I
manually create /dev/hdc with `mknod -m 666 /dev/hdc b 22 0` I can read the
disc in the drive.  The directory /sys/block/hdc exists and contains a
device, but for some reason udev makes a char device anyway.

No other block device has this problem (i.e. I have been able to boot my
computer from a hard disk); what's going on here?

-- 
Ryan Reich
ryanr@uchicago.edu
