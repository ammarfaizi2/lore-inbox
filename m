Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRIMQrJ>; Thu, 13 Sep 2001 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIMQrB>; Thu, 13 Sep 2001 12:47:01 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:16389 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271834AbRIMQqu>; Thu, 13 Sep 2001 12:46:50 -0400
Date: Thu, 13 Sep 2001 18:38:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Subject: [x86-64 patch 6/11] ISDN strcpy removed
Message-ID: <20010913183802.A2602@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The ISDN code contains an extra definition of strcpy which isn't needed
and collides with the kernel library one. This patch removes it.

diff -urN linux-x86_64/drivers/isdn/sc/debug.c linux/drivers/isdn/sc/debug.c
--- linux-x86_64/drivers/isdn/sc/debug.c	Thu Apr 19 22:01:36 2001
+++ linux/drivers/isdn/sc/debug.c	Thu Sep 13 10:52:56 2001
@@ -26,8 +26,7 @@
  *     +1 (416) 297-6433 Facsimile
  */
 #include <linux/kernel.h>
-
-inline char *strcpy(char *, const char *);
+#include <linux/string.h>
 
 int dbg_level = 0;
 static char dbg_funcname[255];
@@ -45,19 +44,6 @@
 	strcpy(dbg_funcname, func);
 	if(dbg_level)
 		printk("--> Entering function %s\n", dbg_funcname);
-}
-
-inline char *strcpy(char *dest, const char *src)
-{
-	char *i = dest;
-	char *j = (char *) src;
-
-	while(*j) {
-		*i = *j;
-		i++; j++;
-	}
-	*(++i) = 0;
-	return dest;
 }
 
 inline void pullphone(char *dn, char *str)

-- 
Vojtech Pavlik
SuSE Labs
