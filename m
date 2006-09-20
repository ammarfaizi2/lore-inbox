Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWITU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWITU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWITU0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:26:16 -0400
Received: from free-electrons.com ([88.191.23.47]:6855 "EHLO
	sd-2511.dedibox.fr") by vger.kernel.org with ESMTP id S1750750AbWITU0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:26:15 -0400
From: Michael Opdenacker <michael-lists@free-electrons.com>
Organization: Free Electrons
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18] [TRIVIAL] Simplify tosh_get_info() in drivers/char/toshiba.c
Date: Wed, 20 Sep 2006 22:25:39 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202225.40136.michael-lists@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.18 is just a trivial simplification of tosh_get_info() 
in drivers/char/toshiba.c.
It was doing something like: b=a; b+=c; return b-a;
Replaced by: return c;
Also removed an unnecessary local variable.

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

--- linux-2.6.18/drivers/char/toshiba.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-toshiba/drivers/char/toshiba.c	2006-09-20 21:53:31.000000000 
+0200
@@ -299,12 +299,6 @@ static int tosh_ioctl(struct inode *ip, 
 #ifdef CONFIG_PROC_FS
 static int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
 {
-	char *temp;
-	int key;
-
-	temp = buffer;
-	key = tosh_fn_status();
-
 	/* Arguments
 	     0) Linux driver version (this will change if format changes)
 	     1) Machine ID
@@ -314,16 +308,14 @@ static int tosh_get_info(char *buffer, c
 	     5) Fn Key status
 	*/
 
-	temp += sprintf(temp, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
+	return sprintf(buffer, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
 		tosh_id,
 		(tosh_sci & 0xff00)>>8,
 		tosh_sci & 0xff,
 		(tosh_bios & 0xff00)>>8,
 		tosh_bios & 0xff,
 		tosh_date,
-		key);
-
-	return temp-buffer;
+		tosh_fn_status());
 }
 #endif
 

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)
