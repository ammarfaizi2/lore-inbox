Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCGTM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCGTM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCGTLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:11:45 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:7686 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261255AbVCGTHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:49 -0500
Message-Id: <200503072037.j27Kbnbc003967@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/16] UML - make the ubd driver recognize letters in device names
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ubd_get_config wasn't using the standard device number parser, which caused
it not to recognize letters.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-03-05 12:07:35.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-03-05 12:11:43.000000000 -0500
@@ -746,15 +746,9 @@
 static int ubd_get_config(char *name, char *str, int size, char **error_out)
 {
 	struct ubd *dev;
-	char *end;
 	int n, len = 0;
 
-	n = simple_strtoul(name, &end, 0);
-	if((*end != '\0') || (end == name)){
-		*error_out = "ubd_get_config : didn't parse device number";
-		return(-1);
-	}
-
+	n = parse_unit(&name);
 	if((n >= MAX_DEV) || (n < 0)){
 		*error_out = "ubd_get_config : device number out of range";
 		return(-1);

