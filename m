Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUCZA3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263844AbUCZADX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:03:23 -0500
Received: from waste.org ([209.173.204.2]:52121 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263824AbUCYX6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17.524465763@selenic.com>
Message-Id: <18.524465763@selenic.com>
Subject: [PATCH 17/22] /dev/random: minor shrinkage
Date: Thu, 25 Mar 2004 17:57:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  minor shrinkage

#ifdef out unused pool sizes (more than makes up for size of
 nonblocking pool)

mark some functions init


 tiny-mpm/drivers/char/random.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff -puN drivers/char/random.c~shrink-random drivers/char/random.c
--- tiny/drivers/char/random.c~shrink-random	2004-03-20 13:38:37.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:37.000000000 -0600
@@ -297,41 +297,38 @@ static struct poolinfo {
 	int	poolwords;
 	int	tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
+	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
+	{ 128,	103,	76,	51,	25,	1 },
+	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
+	{ 32,	26,	20,	14,	7,	1 },
+#if 0
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
 	{ 2048,	1638,	1231,	819,	411,	1 },
 
 	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
 	{ 1024,	817,	615,	412,	204,	1 },
-#if 0				/* Alternate polynomial */
+
 	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
 	{ 1024,	819,	616,	410,	207,	2 },
-#endif
 
 	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
 	{ 512,	411,	308,	208,	104,	1 },
-#if 0				/* Alternates */
+
 	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
 	{ 512,	409,	307,	206,	102,	2 },
 	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
 	{ 512,	409,	309,	205,	103,	2 },
-#endif
 
 	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
 	{ 256,	205,	155,	101,	52,	1 },
 
-	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
-	{ 128,	103,	76,	51,	25,	1 },
-#if 0	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
 	{ 128,	103,	78,	51,	27,	2 },
-#endif
 
 	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
 	{ 64,	52,	39,	26,	14,	1 },
 
-	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
-	{ 32,	26,	20,	14,	7,	1 },
-
+#endif
 	{ 0,	0,	0,	0,	0,	0 },
 };
 
@@ -489,7 +486,8 @@ struct entropy_store {
 	__u32 pool[0];
 };
 
-static struct entropy_store *create_entropy_store(int size, const char *name)
+static struct entropy_store __init *create_entropy_store(
+	int size, const char *name)
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
@@ -1149,7 +1147,7 @@ EXPORT_SYMBOL(get_random_bytes);
  *
  * NOTE: This is an OS-dependent function.
  */
-static void init_std_data(struct entropy_store *r)
+static void __init init_std_data(struct entropy_store *r)
 {
 	struct timeval 	tv;
 	__u32		words[2];
@@ -1581,7 +1579,7 @@ ctl_table random_table[] = {
 	{ .ctl_name = 0 }
 };
 
-static void sysctl_init_random(struct entropy_store *pool)
+static void __init sysctl_init_random(struct entropy_store *pool)
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;

_
