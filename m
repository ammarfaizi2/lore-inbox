Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSCMXrs>; Wed, 13 Mar 2002 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311439AbSCMXr2>; Wed, 13 Mar 2002 18:47:28 -0500
Received: from netfinity.ntsg.umt.edu ([150.131.105.95]:53172 "EHLO
	netfinity.ntsg.umt.edu") by vger.kernel.org with ESMTP
	id <S292829AbSCMXr0>; Wed, 13 Mar 2002 18:47:26 -0500
Message-Id: <200203132347.g2DNlOj01110@netfinity.ntsg.umt.edu>
Content-Type: text/plain; charset=US-ASCII
From: Andrew Neuschwander <andrew@ntsg.umt.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Adaptec 3120S interferes with BusLogic bt-956c controller/driver in 2.4.18
Date: Wed, 13 Mar 2002 16:47:24 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Installing an adaptec scsi raid 3210s causes the BusLogic driver to 
timeout while talking to a device.

I am booting 2.4.18 from a drive on a buslogic controller. I installed an 
asr-3210s controller to attach some fast disks to for work space. Before I 
installed the 3210s I rebuild 2.4.18 with the dpt_i2o driver and without any 
of the generic i2o stuff. I disabled boot on the 3210s.

The system boots from the drive on the buslogic card, grub loads the kernel, 
but when the kernel loads the buslogic driver, it times out waiting for 
target 0 (from which it just booted). It then resets the scsi bus and times 
out again waiting for the drive. It will do this for hours. If I remove the 
ASR-3210S, the BusLogic driver works fine (doesn't timeout on target #0). In 
neither case do I ever load the dpt_i2o driver. This line appears in the 
output once after the controller initializes and before it goes into the 
timeout/reset sequence.

scsi0: Aborting CCB #1 to Target 0

Does anyone have any insight into why this occurs and how to work around it?

My system is: 
RedHat 7.2 with stock 2.4.18
Tyan MPX (2466s) MoBo
pci slot #1 (64bit/66Mhz): e1000
pci slot #2 (64bit/66Mhz): ASR-321S
	No Disks (Yet. will be 4 x 36GB X15 drives) 
pci slot #4 (32bit/33Mhz): BusLogic BT-956C
	Single External Disk.

Would you kindly cc me since I am not subscribed. Or I can just read the 
archives. I'm not too picky.

Thanks in advance
-Andrew
-- 
Andrew A. Neuschwander - andrew@ntsg.umt.edu
UNIX/Linux Systems, NASA Science Compute Facility
NTSG, School of Forestry, The University of Montana
http://www.ntsg.umt.edu - (406) 243 - 6310
