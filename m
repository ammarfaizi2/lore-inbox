Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUDLO0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUDLOVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:21:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:47510 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262924AbUDLOTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:19:18 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 7/9
Date: Mon, 12 Apr 2004 09:19:07 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120919.07648.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the comment regarding the "next" field in struct dm_target_spec. The
"next" field has different behavior if you're performing a DM_TABLE_STATUS
command than it does if you're performing a DM_TABLE_LOAD command.

See populate_table() and retrieve_status() in drivers/md/dm-ioctl.c for more
details on how this field is used.

--- diff/include/linux/dm-ioctl.h	2004-04-09 09:41:45.000000000 -0500
+++ source/include/linux/dm-ioctl.h	2004-04-09 09:42:36.000000000 -0500
@@ -129,8 +129,14 @@
 	int32_t status;		/* used when reading from kernel only */
 
 	/*
-	 * Offset in bytes (from the start of this struct) to
-	 * next target_spec.
+	 * Location of the next dm_target_spec.
+	 * - When specifying targets on a DM_TABLE_LOAD command, this value is
+	 *   the number of bytes from the start of the "current" dm_target_spec
+	 *   to the start of the "next" dm_target_spec.
+	 * - When retrieving targets on a DM_TABLE_STATUS command, this value
+	 *   is the number of bytes from the start of the first dm_target_spec
+	 *   (that follows the dm_ioctl struct) to the start of the "next"
+	 *   dm_target_spec.
 	 */
 	uint32_t next;
 
