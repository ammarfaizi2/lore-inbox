Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTI2EmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTI2EmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 00:42:15 -0400
Received: from defout.telus.net ([199.185.220.240]:54186 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S262799AbTI2EmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 00:42:13 -0400
Subject: 2.6.0-test6 Firewire....Device 'fw-host0' does not have a
	release() function, it is broken and must be fixed.
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064810532.6448.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Sep 2003 22:42:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. I got the message when trying to rmmod ohci1394 (both ohci1394 and
ieee1394 show up with lsmod).  I was trying to unload/reload ohci1394
as  /proc/partitions didn't show sdb or sdc devices.

To confirm the hardware is there and ok:
2.4.21-pre6 shows /proc/partitions as:
major minor  #blocks  name
 
   8     0    1048575 sda
   8    16  134217727 sdb
   8    17  134215011 sdb1
   8    32  134217727 sdc
   8    33  134215011 sdc1
   3     0   20010312 hda
   3     1      30208 hda1
   3     2    1050840 hda2
   3     3   18922680 hda3
   3    64   80043264 hdb
   3    65   80035798 hdb1
(so the hardware is there).......

The complete error message I get when I try to rmmod ohci1394 is:
[root@localhost root]# /sbin/rmmod ohci1394
Device 'fw-host0' does not have a release() function, it is broken and
must be fixed.
Badness in device_release at drivers/base/core.c:85
Call Trace:
 [<c01bef34>] kobject_cleanup+0x73/0x75
 [<f890b264>] highlevel_remove_host+0x5b/0x72 [ieee1394]
 [<c0181cc6>] dput+0x23/0x61a
 [<f88ca635>] ohci1394_pci_remove+0x3e/0x225 [ohci1394]
 [<c01c702e>] pci_device_remove+0x3b/0x3d
 [<c01f1f06>] device_release_driver+0x62/0x64
 [<c01f1f2a>] driver_detach+0x22/0x31
 [<c01f213b>] bus_remove_driver+0x3b/0x70
 [<c01f253e>] driver_unregister+0x14/0x28
 [<c01c71f8>] pci_unregister_driver+0x17/0x25
 [<f88cad0a>] ohci1394_cleanup+0x12/0x16 [ohci1394]
 [<c013b6fc>] sys_delete_module+0x11e/0x15c
 [<c0156d21>] sys_munmap+0x43/0x61
 [<c0109e3d>] sysenter_past_esp+0x52/0x71
----------------------------------------------------------
I built 2.6.0-test6 with gcc 3.2.2.  I am using module-init-tools-0.9.14
to load/unload kernel objects.  The base system is redhat9.0 upgraded
with yum.

The firewire controller is:
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43) on I/O port:
ec00-ec7f : VIA Technologies, Inc. IEEE 1394 Host Controller

If more information is needed, please mail me back directly as I am not
on the list.  I will try to reply within a few hours.
Cheers,
Bob

-- 
Bob Gill <gillb4@telusplanet.net>

