Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVDMCZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVDMCZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVDMCXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:23:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262539AbVDMCRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:17:31 -0400
Date: Wed, 13 Apr 2005 04:17:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/udf/udftime.c: fix off by one error
Message-ID: <20050413021726.GO3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an off by one error found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 27 Mar 2005

--- linux-2.6.12-rc1-mm1-full/fs/udf/udftime.c.old	2005-03-23 01:22:02.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/fs/udf/udftime.c	2005-03-23 01:22:13.000000000 +0100
@@ -103,7 +103,7 @@ udf_stamp_to_time(time_t *dest, long *de
 		offset = 0;
 
 	if ((src.year < EPOCH_YEAR) ||
-		(src.year > EPOCH_YEAR+MAX_YEAR_SECONDS))
+		(src.year >= EPOCH_YEAR+MAX_YEAR_SECONDS))
 	{
 		*dest = -1;
 		*dest_usec = -1;

