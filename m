Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVF2WjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVF2WjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVF2WiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:38:15 -0400
Received: from mail.dif.dk ([193.138.115.101]:39865 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262699AbVF2Whh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:37:37 -0400
Date: Thu, 30 Jun 2005 00:43:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: jesper.juhl@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] vfree() cleanup in drivers/net/bsd_comp.c
Message-ID: <Pine.LNX.4.62.0506300029440.2998@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pass NULL pointers to vfree() just fine. There's no bennefit in 
checking first if the pointer is != NULL.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/bsd_comp.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

--- linux-2.6.13-rc1-orig/drivers/net/bsd_comp.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/net/bsd_comp.c	2005-06-30 00:38:32.000000000 +0200
@@ -46,13 +46,13 @@
 
 /*
  * This version is for use with contiguous buffers on Linux-derived systems.
  *
- *  ==FILEVERSION 20000226==
+ *  ==FILEVERSION 20050630==
  *
  *  NOTE TO MAINTAINERS:
  *     If you modify this file at all, please set the number above to the
- *     date of the modification as YYMMDD (year month day).
+ *     date of the modification as YYYYMMDD (year month day).
  *     bsd_comp.c is shipped with a PPP distribution as well as with
  *     the kernel; if everyone increases the FILEVERSION number above,
  *     then scripts can do the right thing when deciding whether to
  *     install a new bsd_comp.c file. Don't change the format of that
@@ -330,25 +330,19 @@ static void bsd_free (void *state)
       {
 /*
  * Release the dictionary
  */
-	if (db->dict)
-	  {
-	    vfree (db->dict);
-	    db->dict = NULL;
-	  }
+	vfree(db->dict);
+	db->dict = NULL;
 /*
  * Release the string buffer
  */
-	if (db->lens)
-	  {
-	    vfree (db->lens);
-	    db->lens = NULL;
-	  }
+	vfree(db->lens);
+	db->lens = NULL;
 /*
  * Finally release the structure itself.
  */
-	kfree (db);
+	kfree(db);
       }
   }
 
 /*



