Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUHOPBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUHOPBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUHOPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:01:23 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37258 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266752AbUHOPAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:00:31 -0400
Date: Sun, 15 Aug 2004 17:00:29 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] remove-last-suser-call drivers/char/rocket.c
Message-ID: <20040815150029.GJ1799@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Attached patch removes the lone remaining suser() call,
suser() has long gone in summer 2002.
applies to 2.6.8.1-kjt1, compile tested

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.8-max/drivers/char/rocket.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/char/rocket.c~remove-last-suser-call drivers/char/rocket.c
--- linux-2.6.8/drivers/char/rocket.c~remove-last-suser-call	2004-08-15 16:54:13.000000000 +0200
+++ linux-2.6.8-max/drivers/char/rocket.c	2004-08-15 16:54:13.000000000 +0200
@@ -1283,11 +1283,7 @@ static int set_config(struct r_port *inf
 	if (copy_from_user(&new_serial, new_info, sizeof (new_serial)))
 		return -EFAULT;
 
-#ifdef CAP_SYS_ADMIN
 	if (!capable(CAP_SYS_ADMIN))
-#else
-	if (!suser())
-#endif
 	{
 		if ((new_serial.flags & ~ROCKET_USR_MASK) != (info->flags & ~ROCKET_USR_MASK))
 			return -EPERM;

_
