Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWBOIa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWBOIa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWBOIa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:30:58 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:35790 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751034AbWBOIa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:30:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=ubepE7l4r1Lb1MlQd0itdgDa/WiIbuGe4M55BXMUIDhIA9c05bzZA5rADse+yDo2alvUWP4Ggm2xhq5j20E8TKDtB8PnR++uSVOeO6Np/aLNW9RmGmZ2GlQBC4zk4DT9PMQpt9q2EJdvtnDhdldnoEzmPMnLStpLNWKXo9DFixA=
Message-ID: <43F2E680.80504@gmail.com>
Date: Wed, 15 Feb 2006 09:29:52 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
References: <ff1cadb20602141305o5fa0acebn@mail.gmail.com> <20060214193341.30695606.rdunlap@xenotime.net>
In-Reply-To: <20060214193341.30695606.rdunlap@xenotime.net>
Content-Type: multipart/mixed;
 boundary="------------020904030908090208060400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904030908090208060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap ha scritto:
> The patch does not apply cleanly to 2.6.16-rc3 -- because tabs
> have been converted to spaces, either by your email client or
> by using copy-n-paste to create the email.

Here is what happens when you use Outlook ;)



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- linux-2.6.16-rc3/drivers/char/lp.c.orig	2006-01-08 
16:48:14.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/lp.c	2006-02-14 13:43:41.000000000 +0100
@@ -686,9 +686,13 @@ static struct file_operations lp_fops =
  #define CONSOLE_LP 0

  /* If the printer is out of paper, we can either lose the messages or
- * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
- * non-zero to get the latter behaviour. */
-#define CONSOLE_LP_STRICT 1
+ * stall until the printer is happy again. If CONSOLE_LP_STRICT is
+ * non-zero, we get the latter behaviour. */
+#ifdef CONFIG_LP_CONSOLE_STRICT
+# define CONSOLE_LP_STRICT 1
+#else
+# define CONSOLE_LP_STRICT 0
+#endif

  /* The console must be locked when we get here. */

@@ -697,7 +701,7 @@ static void lp_console_write (struct con
  {
  	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
  	struct parport *port = dev->port;
-	ssize_t written;
+	ssize_t written = 0;

  	if (parport_claim (dev))
  		/* Nothing we can do. */
--- linux-2.6.16-rc3/drivers/char/Kconfig.orig	2006-02-14 
00:14:08.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/Kconfig	2006-02-14 13:47:33.000000000 
+0100
@@ -512,14 +512,21 @@ config LP_CONSOLE
  	  doing that; to actually get it to happen you need to pass the
  	  option "console=lp0" to the kernel at boot time.

-	  If the printer is out of paper (or off, or unplugged, or too
-	  busy..), the kernel will stall until the printer is ready again.
-	  By defining CONSOLE_LP_STRICT to 0 (at your own risk) you
-	  can make the kernel continue when this happens,
-	  but it'll lose the kernel messages.
-
  	  If unsure, say N.

+config LP_CONSOLE_STRICT
+	bool "Wait for a ready printer"
+	depends on LP_CONSOLE
+	default y
+	---help---
+	  With this option enabled, if the printer is out of paper (or off,
+	  or unplugged, or too busy..) the kernel will stall until the printer
+	  is ready again. By turning this option off (at your own risk), you
+	  can make the kernel continue when this happens, but it will lose
+	  some kernel messages.
+	
+	  If unsure, say Y
+
  config PPDEV
  	tristate "Support for user-space parallel port device drivers"
  	depends on PARPORT



I attach a copy of this patch to this email in order to avoid these 
problems (at least I hope so)

Regards,

-- 
Luca

--------------020904030908090208060400
Content-Type: text/plain;
 name="lp_console_strict.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lp_console_strict.patch.txt"

--- linux-2.6.16-rc3/drivers/char/lp.c.orig	2006-01-08 16:48:14.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/lp.c	2006-02-14 13:43:41.000000000 +0100
@@ -686,9 +686,13 @@ static struct file_operations lp_fops = 
 #define CONSOLE_LP 0
 
 /* If the printer is out of paper, we can either lose the messages or
- * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
- * non-zero to get the latter behaviour. */
-#define CONSOLE_LP_STRICT 1
+ * stall until the printer is happy again. If CONSOLE_LP_STRICT is
+ * non-zero, we get the latter behaviour. */
+#ifdef CONFIG_LP_CONSOLE_STRICT
+# define CONSOLE_LP_STRICT 1
+#else
+# define CONSOLE_LP_STRICT 0
+#endif
 
 /* The console must be locked when we get here. */
 
@@ -697,7 +701,7 @@ static void lp_console_write (struct con
 {
 	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
 	struct parport *port = dev->port;
-	ssize_t written;
+	ssize_t written = 0;
 
 	if (parport_claim (dev))
 		/* Nothing we can do. */
--- linux-2.6.16-rc3/drivers/char/Kconfig.orig	2006-02-14 00:14:08.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/Kconfig	2006-02-14 13:47:33.000000000 +0100
@@ -512,14 +512,21 @@ config LP_CONSOLE
 	  doing that; to actually get it to happen you need to pass the
 	  option "console=lp0" to the kernel at boot time.
 
-	  If the printer is out of paper (or off, or unplugged, or too
-	  busy..), the kernel will stall until the printer is ready again.
-	  By defining CONSOLE_LP_STRICT to 0 (at your own risk) you
-	  can make the kernel continue when this happens,
-	  but it'll lose the kernel messages.
-
 	  If unsure, say N.
 
+config LP_CONSOLE_STRICT
+	bool "Wait for a ready printer"
+	depends on LP_CONSOLE
+	default y
+	---help---
+	  With this option enabled, if the printer is out of paper (or off,
+	  or unplugged, or too busy..) the kernel will stall until the printer
+	  is ready again. By turning this option off (at your own risk), you
+	  can make the kernel continue when this happens, but it will lose
+	  some kernel messages.
+	  
+	  If unsure, say Y
+
 config PPDEV
 	tristate "Support for user-space parallel port device drivers"
 	depends on PARPORT

--------------020904030908090208060400--
