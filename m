Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWFYQCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWFYQCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWFYQCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:02:34 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:7866 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S1751118AbWFYQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:02:33 -0400
Message-ID: <449EB345.7080207@free-electrons.com>
Date: Sun, 25 Jun 2006 18:01:09 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] [TRIVIAL] Simplify tosh_get_info() in drivers/char/toshiba.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.17 is just a trivial simplification of 
tosh_get_info() in drivers/char/toshiba.c.
It was doing something like: b=a; b+=c; return b-a;
Replaced by: return c;
Also removed an unnecessary local variable.

Also available on 
http://free-electrons.com/pub/patches/linux/20060625/patch-2.6.17-toshiba

Signed-off-by: Michael Opdenacker <michael@free-electrons.com>

--- linux-2.6.17/drivers/char/toshiba.c    2006-06-18 03:49:35.000000000 
+0200
+++ linux-2.6.17-toshiba/drivers/char/toshiba.c    2006-06-25 
17:49:56.000000000 +0200
@@ -299,12 +299,6 @@ static int tosh_ioctl(struct inode *ip,
 #ifdef CONFIG_PROC_FS
 static int tosh_get_info(char *buffer, char **start, off_t fpos, int 
length)
 {
-    char *temp;
-    int key;
-
-    temp = buffer;
-    key = tosh_fn_status();
-
     /* Arguments
          0) Linux driver version (this will change if format changes)
          1) Machine ID
@@ -314,16 +308,14 @@ static int tosh_get_info(char *buffer, c
          5) Fn Key status
     */
 
-    temp += sprintf(temp, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
+    return sprintf(buffer, "1.1 0x%04x %d.%d %d.%d 0x%04x 0x%02x\n",
         tosh_id,
         (tosh_sci & 0xff00)>>8,
         tosh_sci & 0xff,
         (tosh_bios & 0xff00)>>8,
         tosh_bios & 0xff,
         tosh_date,
-        key);
-
-    return temp-buffer;
+        tosh_fn_status());
 }
 #endif
 

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training


