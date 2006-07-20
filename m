Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWGTP5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWGTP5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWGTP5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:57:10 -0400
Received: from asia.telenet-ops.be ([195.130.137.74]:14780 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030342AbWGTP5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:57:09 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: rpurdie@rpsys.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ppc32 zImage inflate
Date: Thu, 20 Jul 2006 05:56:03 +0200
Message-ID: <87u05dhquk.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recent zlib update (commit
4f3865fb57a04db7cca068fed1c15badc064a302) broke ppc32 zImage
decompression as it tries to decompress to address zero and the
updated zlib_inflate checks that strm->next_out isn't a null pointer.

This little patch fixes it.

diff -Naur linux-2.6.18-rc2.orig/lib/zlib_inflate/inflate.c linux-2.6.18-rc2/lib/zlib_inflate/inflate.c
--- linux-2.6.18-rc2.orig/lib/zlib_inflate/inflate.c	2006-07-20 10:26:21.000000000 +0200
+++ linux-2.6.18-rc2/lib/zlib_inflate/inflate.c	2006-07-20 17:02:27.000000000 +0200
@@ -347,7 +347,7 @@
     static const unsigned short order[19] = /* permutation of code lengths */
         {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
 
-    if (strm == NULL || strm->state == NULL || strm->next_out == NULL ||
+    if (strm == NULL || strm->state == NULL ||
         (strm->next_in == NULL && strm->avail_in != 0))
         return Z_STREAM_ERROR;

-- 
Bye, Peter Korsgaard
