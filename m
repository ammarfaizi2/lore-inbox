Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHaX3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHaX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWHaX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:29:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:9118 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932409AbWHaX3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:29:24 -0400
X-Authenticated: #704063
Subject: [Patch] Uninitialized variable in drivers/scsi/ncr53c8xx.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: matthew@wil.cx
Content-Type: text/plain
Date: Fri, 01 Sep 2006 01:29:12 +0200
Message-Id: <1157066952.13948.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (id #880).
We use simple_strtoul() earlier to initialize pe,
if the function fails, it also does not initialize it.
Therefore we should initialize it ourselves, so the check
in the OPT_TAGS case "if (pe && *pe == '/')" makes sense, and
actually makes the command line parsing more robust.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc5/drivers/scsi/ncr53c8xx.c.orig	2006-09-01 01:25:09.000000000 +0200
+++ linux-2.6.18-rc5/drivers/scsi/ncr53c8xx.c	2006-09-01 01:25:26.000000000 +0200
@@ -692,7 +692,7 @@ static int __init sym53c8xx__setup(char 
 	int xi = 0;
 
 	while (cur != NULL && (pc = strchr(cur, ':')) != NULL) {
-		char *pe;
+		char *pe = NULL;
 
 		val = 0;
 		pv = pc;


