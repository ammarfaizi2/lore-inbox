Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDLOXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUDLOVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:21:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37552 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262914AbUDLOSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:18:33 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 2/9
Date: Mon, 12 Apr 2004 09:18:22 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.22216.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the uptodate flag in sub-bios to see if there was an error.
[Mike Christie]

--- diff/drivers/md/dm.c	2004-04-09 09:40:14.000000000 -0500
+++ source/drivers/md/dm.c	2004-04-09 09:41:53.000000000 -0500
@@ -294,6 +294,9 @@
 	if (bio->bi_size)
 		return 1;
 
+	if (!bio_flagged(bio, BIO_UPTODATE) && !error)
+		error = -EIO;
+
 	if (endio) {
 		r = endio(tio->ti, bio, error, &tio->info);
 		if (r < 0)
