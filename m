Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWGTRHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWGTRHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGTRHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:07:39 -0400
Received: from tim.rpsys.net ([194.106.48.114]:63684 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750724AbWGTRHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:07:38 -0400
Subject: Fix ppc32 zImage inflate
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Claus Gindhart <claus.gindhart@kontron.com>,
       Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 20 Jul 2006 18:07:22 +0100
Message-Id: <1153415243.5649.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32's zImage inflates to address 0 which the recent zlib update took
as an error condition. Remove the check and note the problem so anyone
updating zlib in future won't fall into the same trap.

Reported-by: Peter Korsgaard <jacmet@sunsite.dk>
Reported-by: Claus Gindhart <claus.gindhart@kontron.com>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/lib/zlib_inflate/inflate.c
===================================================================
--- git.orig/lib/zlib_inflate/inflate.c	2006-07-15 09:11:07.000000000 +0100
+++ git/lib/zlib_inflate/inflate.c	2006-07-20 17:58:58.000000000 +0100
@@ -347,7 +347,10 @@
     static const unsigned short order[19] = /* permutation of code lengths */
         {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
 
-    if (strm == NULL || strm->state == NULL || strm->next_out == NULL ||
+    /* Do not check for strm->next_out == NULL here as ppc zImage
+       inflates to strm->next_out = 0 */
+
+    if (strm == NULL || strm->state == NULL ||
         (strm->next_in == NULL && strm->avail_in != 0))
         return Z_STREAM_ERROR;
 


