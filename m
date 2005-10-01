Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVJAGxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVJAGxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVJAGxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:53:20 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:1670 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750750AbVJAGxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:53:20 -0400
Date: Fri, 30 Sep 2005 23:53:22 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [drivers/cdrom] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001065322.GD25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
--- a/drivers/cdrom/mcdx.c
+++ b/drivers/cdrom/mcdx.c
@@ -1085,7 +1085,7 @@ static int __init mcdx_init_drive(int dr
 
 	xtrace(INIT, "kmalloc space for stuffpt's\n");
 	xtrace(MALLOC, "init() malloc %d bytes\n", size);
-	if (!(stuffp = kmalloc(size, GFP_KERNEL))) {
+	if (!(stuffp = kzalloc(size, GFP_KERNEL))) {
 		xwarn("init() malloc failed\n");
 		return 1;
 	}
@@ -1101,8 +1101,6 @@ static int __init mcdx_init_drive(int dr
 	       sizeof(*stuffp), stuffp);
 
 	/* set default values */
-	memset(stuffp, 0, sizeof(*stuffp));
-
 	stuffp->present = 0;	/* this should be 0 already */
 	stuffp->toc = NULL;	/* this should be NULL already */
 
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
