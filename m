Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVD1QQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVD1QQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVD1QQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:16:28 -0400
Received: from mail.microway.com ([64.80.227.22]:8886 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S262122AbVD1QQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:16:19 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: linux-kernel@vger.kernel.org
Subject: very strange issue with sata,<4G Ram, and ext3
Date: Thu, 28 Apr 2005 12:16:07 -0400
User-Agent: KMail/1.7.2
Message-Id: <200504281216.08026.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 We are having a very strange issue on some 64bit systems.  We have a 32 node 
cluster of EM64T's (supermicro boards).  We are using our node restore 
software to propagate a linux install onto them.  We do a pxe boot to a 
kernel and initrd image.  The initrd has some config info, a basic root 
filesystem, and a restore script.  The kernel is passed init=/restore  (the 
restore script itself).  The script runs dhcp, gets an ip, then nfs mounts 
the master node of the cluster.  The backup image is stored on the master 
node's nfs mount.  The script then applies a backed up partition table and 
then mkfs's the partitions, mounts them, untars a backup tar to the drive, 
and then makes it bootable with grub.

 On these systems, we are getting ext2 errors from the initrd during the 
untarring.  Soon after, we start getting seg faults on random things (looks 
like stuff caused by the still running dhcp client), and then a continuous 
stream of segfaults on the restore script itself (restore[1]).

 The systems being restored are dual em64t's with 2G of ram and 200G sata 
drives.  If we up the memory to 4G, the restores complete without error. If 
we reduce down to 512M, the segfaults start at the mkfs stage instead of the 
untar stage. We've tried different sata drives and controllers without 
change.  Switching to ide drives works.  Switching to reiserfs instead of 
ext3 for the destination drives works too.  We've tried enabling the scsi 
debug stuff as well as the jbd debug stuff for ext3 without getting any more 
info.  We also enabled the kernel debug options too.  We've also tried using 
the deprecated ide based sata drivers instead of the scsi based ones without 
success.  We have tried restoring to Intel's Jarell EM64T systems as well as 
an Arima HDAMA opteron with the same errors.  We've also tried adding swap 
space ASAP in the inird image.  

 This problem is really baffling us and we're not quite sure what to check 
into next.  Any ideas?


-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
