Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWFUOk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWFUOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWFUOk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:40:28 -0400
Received: from mail.gmx.de ([213.165.64.21]:43409 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932068AbWFUOk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:40:27 -0400
X-Authenticated: #704063
Subject: [Patch] Array overrun in drivers/net/wireless/wavelan.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: jt@hpl.hp.com
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:40:24 +0200
Message-Id: <1150900824.20915.11.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this is another array overrun spotted by coverity (#id 507)
we should check the index against array size before using it.
Not sure why the driver doesnt use ARRAY_SIZE instead of its
own macro.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/wireless/wavelan.c.orig	2006-06-21 16:35:19.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/wireless/wavelan.c	2006-06-21 16:36:50.000000000 +0200
@@ -1695,8 +1695,8 @@ static int wv_frequency_list(unsigned lo
 		/* Look in the table if the frequency is allowed */
 		if (table[9 - (freq / 16)] & (1 << (freq % 16))) {
 			/* Compute approximate channel number */
-			while ((((channel_bands[c] >> 1) - 24) < freq) &&
-			       (c < NELS(channel_bands)))
+			while ((c < NELS(channel_bands)) &&
+				(((channel_bands[c] >> 1) - 24) < freq)) 
 				c++;
 			list[i].i = c;	/* Set the list index */
 


