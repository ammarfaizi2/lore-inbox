Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVCQAMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVCQAMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVCQAJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:09:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:58757 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262896AbVCQAIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:08:42 -0500
Date: Thu, 17 Mar 2005 01:10:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] gen_init_cpio.c : don't check for NULL before free()
Message-ID: <Pine.LNX.4.62.0503170106450.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in usr/gen_init_cpio.c::cpio_mkfile() a pointer is checked for NULL before 
calling free() on it - this is redundant, free() copes just fine with NULL 
pointers.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/usr/gen_init_cpio.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.11-mm4/usr/gen_init_cpio.c	2005-03-17 01:05:25.000000000 +0100
@@ -349,7 +349,7 @@ static int cpio_mkfile(const char *name,
 	rc = 0;
 	
 error:
-	if (filebuf) free(filebuf);
+	free(filebuf);
 	if (file >= 0) close(file);
 	return rc;
 }



