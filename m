Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbTHVHmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTHVHlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:41:52 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:30989 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263063AbTHVHfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:35:47 -0400
Date: Fri, 22 Aug 2003 04:35:03 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 12/13 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
 [6/7]
Message-Id: <20030822043503.4845bbdf.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 irnet.h |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

--- linux-2.4.22-rc2/net/irda/irnet/irnet.h	2003-06-13 11:51:39.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irnet/irnet.h	2003-08-21 00:08:28.000000000 -0300
@@ -322,29 +322,29 @@
  * compiler will optimise away the if() in all cases.
  */
 /* All error messages (will show up in the normal logs) */
-#define DERROR(dbg, args...) \
-	{if(DEBUG_##dbg) \
-		printk(KERN_INFO "irnet: " __FUNCTION__ "(): " args);}
+#define DERROR(dbg, format, args...) \
+   {if(DEBUG_##dbg) \
+      printk(KERN_INFO "irnet: %s(): " format, __FUNCTION__ , ##args);}
 
 /* Normal debug message (will show up in /var/log/debug) */
-#define DEBUG(dbg, args...) \
-	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: " __FUNCTION__ "(): " args);}
+#define DEBUG(dbg, format, args...) \
+   {if(DEBUG_##dbg) \
+      printk(KERN_DEBUG "irnet: %s(): " format, __FUNCTION__ , ##args);}
 
 /* Entering a function (trace) */
-#define DENTER(dbg, args...) \
-	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: ->" __FUNCTION__ args);}
+#define DENTER(dbg, format, args...) \
+   {if(DEBUG_##dbg) \
+      printk(KERN_DEBUG "irnet: -> %s" format, __FUNCTION__ , ##args);}
 
 /* Entering and exiting a function in one go (trace) */
-#define DPASS(dbg, args...) \
-	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: <>" __FUNCTION__ args);}
+#define DPASS(dbg, format, args...) \
+   {if(DEBUG_##dbg) \
+      printk(KERN_DEBUG "irnet: <>%s" format, __FUNCTION__ , ##args);}
 
 /* Exiting a function (trace) */
-#define DEXIT(dbg, args...) \
-	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: <-" __FUNCTION__ "()" args);}
+#define DEXIT(dbg, format, args...) \
+   {if(DEBUG_##dbg) \
+      printk(KERN_DEBUG "irnet: <-%s()" format, __FUNCTION__ , ##args);}
 
 /* Exit a function with debug */
 #define DRETURN(ret, dbg, args...) \

ciao
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
