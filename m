Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268552AbUHLNTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268552AbUHLNTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268556AbUHLNTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:19:33 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1237 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268552AbUHLNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:19:32 -0400
Subject: SG_IO and security
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092313030.21978.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 13:17:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the entire thread seems to have died again unresolved I'd suggest
the following patch should get into 2.6.8 so that anyone with read
access to any block device cannot issue arbitary scsi commands to it
(like writes or firmware erase)

--- drivers/block/scsi_ioctl.c~	2004-08-12 14:14:38.078821640 +0100
+++ drivers/block/scsi_ioctl.c	2004-08-12 14:14:38.079821488 +0100
@@ -115,6 +115,8 @@
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	unsigned char cmd[BLK_MAX_CDB];
 
+	if (!capable(CAP_SYS_RAWIO))
+		return -EPERM;
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)

