Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWAPRNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWAPRNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAPRNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:13:10 -0500
Received: from ik55118.ikexpress.com ([213.246.55.118]:30366 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S1751130AbWAPRNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:13:09 -0500
Message-ID: <43CBD2D7.6090101@free-electrons.com>
Date: Mon, 16 Jan 2006 18:07:35 +0100
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] [TRIVIAL] Simplify tosh_get_info() in drivers/char/toshiba.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.15 is just a trivial simplification of 
tosh_get_info() in drivers/char/toshiba.c.
It was doing something like: b=a; b+=c; return b-a;
Replaced by: return c;
Also removed an unnecessary local variable.

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

diff -pruN linux-2.6.15/drivers/char/toshiba.c linux-2.6.15-toshiba/drivers/char/toshiba.c
--- linux-2.6.15/drivers/char/toshiba.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-toshiba/drivers/char/toshiba.c	2006-01-16 10:26:02.000000000 +0100
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


