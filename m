Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbUKTMXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbUKTMXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUKTMXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:23:13 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:14344 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262983AbUKTMQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:16:26 -0500
Date: Sat, 20 Nov 2004 13:16:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.28 (2/5)
Message-Id: <20041120131623.3a723334.khali@linux-fr.org>
In-Reply-To: <20041120125423.42527051.khali@linux-fr.org>
References: <20041120125423.42527051.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original report and discussion:
http://archives.andrew.net.au/lm-sensors/msg28053.html

Bottom line:
The real parser in i2c-proc is partly broken, but in a way it will go
unnoticed in most cases (thus unspotted so far). Still worth fixing
IMHO.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.4.28-pre4/drivers/i2c/i2c-proc.c.orig	2004-10-16 12:44:30.000000000 +0200
+++ linux-2.4.28-pre4/drivers/i2c/i2c-proc.c	2004-10-16 12:46:38.000000000 +0200
@@ -540,7 +540,7 @@
 		/* Skip everything until we hit whitespace */
 		while (bufsize && 
 		       !((ret=get_user(nextchar, (char *) buffer))) &&
-		       isspace((int) nextchar)) {
+		       !isspace((int) nextchar)) {
 			bufsize--;
 			((char *) buffer)++;
 		}


-- 
Jean Delvare
http://khali.linux-fr.org/
