Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTDUSnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbTDUSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:43:02 -0400
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:5393 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261962AbTDUSli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:41:38 -0400
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <36696BAFD8467644ABA0050BE35890590E062B@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: devlabel: added multipath support
Date: Mon, 21 Apr 2003 13:53:20 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12BAE1A0936513-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devlabel 0.35.21 includes support for multipath devices.

Previously, if attempting to add a symlink to a device which was part of a
multipath set, devlabel would not allow this because multiple devices
returned the same UUID. Now, this can be avoided by adding symlinks with the
--multipath option.

This will instruct devlabel to create multiple symlinks named
YourSymlinkName_multipath# each pointing to a different path that is part of
the multipath set. These symlinks can then be used in /etc/raidtab to create
a working multipath device which will not succumb to any device renaming
problems.

Hence, if /dev/sdd1 and /dev/sde1 were multiple paths to the same device,
they can now be referenced as /dev/foo_multipath0 and /dev/foo_multipath1 so
even if they became /dev/sdb1 and /dev/sdc1 internally, your multipath
device would still get created properly from /etc/raidtab since you used the
symlink names and not the actual device names.

tarball: http://www.lerhaupt.com/devlabel/devlabel-0.35.21.tar.gz
changeblog: http://www.lerhaupt.com/foo/archives/000063.html

---
Devlabel now handles the following device renaming related events:
* An unchanging symlink name which will always get you to the right location

* A method for identifying partitions which have no filesystem on them (eg.
swap) which would not otherwise be mountable by a filesystem label 
* If using raw devices, a consistently named file node to point to your data

* An engine for cluster deployment in shared storage environments 
* An automounter for hotpluggable storage devices which will mount a storage
device's associated symlink when its plugged in 
* A set of consistently named symlinks to be used for a multipath device in
/etc/raidtab 
* A method to ensure correct device ownership and permissions when device
renaming events occur  

Gary Lerhaupt
Linux Development
Dell Computer Corporation

