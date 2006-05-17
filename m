Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWEQAm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWEQAm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWEQAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:42:29 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:19845 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932299AbWEQAm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:42:28 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.17-rc4-git] remove compile warnings when CONFIG_SWAP=n
Date: Tue, 16 May 2006 17:04:44 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cimaENFpLBWeLf4"
Message-Id: <200605161704.44915.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_cimaENFpLBWeLf4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

By making some macros reference their parameters.

--Boundary-00=_cimaENFpLBWeLf4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="swapnoise.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swapnoise.patch"

Get rid of compile-time warnings:

	mm/vmscan.c: In function `remove_mapping':
	mm/vmscan.c:382: warning: unused variable `swap'

It's used, but not without CONFIG_SWAP.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: at91-pre2/include/linux/swap.h
===================================================================
--- at91-pre2.orig/include/linux/swap.h	2006-05-15 10:07:26.000000000 -0700
+++ at91-pre2/include/linux/swap.h	2006-05-15 11:21:50.000000000 -0700
@@ -290,9 +290,9 @@ static inline void disable_swap_token(vo
 	release_pages((pages), (nr), 0);
 
 #define show_swap_cache_info()			/*NOTHING*/
-#define free_swap_and_cache(swp)		/*NOTHING*/
-#define swap_duplicate(swp)			/*NOTHING*/
-#define swap_free(swp)				/*NOTHING*/
+#define free_swap_and_cache(swp)		((void)(swp)/*NOP*/)
+#define swap_duplicate(swp)			((void)(swp)/*NOP*/)
+#define swap_free(swp)				((void)(swp)/*NOP*/)
 #define read_swap_cache_async(swp,vma,addr)	NULL
 #define lookup_swap_cache(swp)			NULL
 #define valid_swaphandles(swp, off)		0

--Boundary-00=_cimaENFpLBWeLf4--
