Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSEVRwK>; Wed, 22 May 2002 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSEVRwJ>; Wed, 22 May 2002 13:52:09 -0400
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:63439
	"EHLO yxa.extundo.com") by vger.kernel.org with ESMTP
	id <S316614AbSEVRwJ>; Wed, 22 May 2002 13:52:09 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix complete freeze on Dell latitude in nm256_audio.c
From: Simon Josefsson <jas@extundo.com>
Date: Wed, 22 May 2002 19:49:14 +0200
Message-ID: <ilur8k4t6n9.fsf@latte.josefsson.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add this to the 2.4 tree.  Without it, Dell Latitude laptops
completely freeze when loading the module.  Thanks.

--- linux/drivers/sound/nm256_audio.c.orig      Sun Sep 30 21:26:08 2001
+++ linux/drivers/sound/nm256_audio.c   Wed May 22 19:46:48 2002
@@ -896,7 +896,9 @@

     /* Reset the mixer.  'Tis magic!  */
     nm256_writePort8 (card, 2, 0x6c0, 1);
-    nm256_writePort8 (card, 2, 0x6cc, 0x87);
+    /* The following line crashes Dell Latitude laptops and doesn't
+     * seem to do any harm on other machines.
+    nm256_writePort8 (card, 2, 0x6cc, 0x87); */
     nm256_writePort8 (card, 2, 0x6cc, 0x80);
     nm256_writePort8 (card, 2, 0x6cc, 0x0);


