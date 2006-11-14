Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755455AbWKNTtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbWKNTtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbWKNTtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:49:16 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:6071 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1755455AbWKNTtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:49:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Update udf documentation to reflect current state of read/write support
Reply-To: Phillip Susi <psusi@cfl.rr.com>
Date: Tue, 14 Nov 2006 14:49:14 -0500
Message-Id: <11635337543512-git-send-email-psusi@cfl.rr.com>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes Documentation/filesystems/udf.txt from saying that
read/write mounts on cd media are not supported to instead state the
current level of support.  Specifically that it works fine on dvd+rw
media and can be made to work on cd-rw media via the pktcdvd device.
---
 Documentation/filesystems/udf.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/udf.txt b/Documentation/filesystems/udf.txt
index 511b423..ed4ad3f 100644
--- a/Documentation/filesystems/udf.txt
+++ b/Documentation/filesystems/udf.txt
@@ -7,8 +7,17 @@ If you encounter problems with reading U
 please report them to linux_udf@hpesjro.fc.hp.com, which is the
 developer's list.
 
-Write support requires a block driver which supports writing. The current
-scsi and ide cdrom drivers do not support writing.
+Write support requires a block driver which supports writing.  Currently
+dvd+rw drives and media support true random sector writes, and so a udf
+filesystem on such devices can be directly mounted read/write.  CD-RW
+media however, does not support this.  Instead the media can be formatted
+for packet mode using the utility cdrwtool, then the pktcdvd driver can
+be bound to the underlying cd device to provide the required buffering
+and read-modify-write cycles to allow the filesystem random sector writes
+while providing the hardware with only full packet writes.  While not
+required for dvd+rw media, use of the pktcdvd driver often enhances
+performance due to very poor read-modify-write support supplied internally
+by drive firmware.  
 
 -------------------------------------------------------------------------------
 The following mount options are supported:
-- 
1.4.1

