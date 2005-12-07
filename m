Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVLGWq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVLGWq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbVLGWq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:46:58 -0500
Received: from rtr.ca ([64.26.128.89]:41145 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750861AbVLGWq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:46:58 -0500
Message-ID: <43976661.1030004@rtr.ca>
Date: Wed, 07 Dec 2005 17:46:57 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH] Fix incorrect pointer in megaraid.c MODE_SENSE emulation
Content-Type: multipart/mixed;
 boundary="------------000708050106030802060008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708050106030802060008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The SCSI megaraid drive goes to great effort to kmap
the scatterlist buffer (if used), but then uses the
wrong pointer when copying to it afterward.

Signed-off-by:  Mark Lord <lkml@rtr.ca>

--------------000708050106030802060008
Content-Type: text/x-patch;
 name="megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="megaraid.patch"

--- linux-2.6.15-rc5/drivers/scsi/megaraid.c.orig	2005-12-04 00:10:42.000000000 -0500
+++ linux/drivers/scsi/megaraid.c	2005-12-07 17:41:30.000000000 -0500
@@ -664,7 +664,7 @@
 					sg->offset;
 			} else
 				buf = cmd->request_buffer;
-			memset(cmd->request_buffer, 0, cmd->cmnd[4]);
+			memset(buf, 0, cmd->cmnd[4]);
 			if (cmd->use_sg) {
 				struct scatterlist *sg;
 

--------------000708050106030802060008--
