Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTBYMff>; Tue, 25 Feb 2003 07:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBYMff>; Tue, 25 Feb 2003 07:35:35 -0500
Received: from gherkin.frus.com ([192.158.254.49]:8582 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267954AbTBYMfe>;
	Tue, 25 Feb 2003 07:35:34 -0500
Subject: [PATCH] 2.5.63 snd_printd 
To: perex@suse.cz
Date: Tue, 25 Feb 2003 06:45:48 -0600 (CST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM741935201-11515-0_
Content-Transfer-Encoding: 7bit
Message-Id: <20030225124548.41B454F0B@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM741935201-11515-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Back in 2.5.60, it seemed that the intent was to do away with
snd_printd() and replace that function with a simple #define in terms
of snd_verbose_printd() or printk() as appropriate.  This patch set
finishes the job by deleting both the snd_printd() function and the
corresponding EXPORT_SYMBOL().  This was needed to fix a compilation
error with CONFIG_SND_DEBUG=y and CONFIG_SND_VERBOSE_PRINTK not set.

Applies to 2.5.60 through 2.5.63 inclusive.  Originally posted 14 Feb.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM741935201-11515-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch63_snd_printd

--- linux/sound/core/misc.c.orig	2003-02-13 15:48:42.000000000 -0600
+++ linux/sound/core/misc.c	2003-02-13 15:50:08.000000000 -0600
@@ -79,25 +79,3 @@
 	printk(tmpbuf);
 }
 #endif
-
-#if defined(CONFIG_SND_DEBUG) && !defined(CONFIG_SND_VERBOSE_PRINTK)
-void snd_printd(const char *format, ...)
-{
-	va_list args;
-	char tmpbuf[512];
-	
-	if (format[0] == '<' && format[1] >= '0' && format[1] <= '9' && format[2] == '>') {
-		char tmp[] = "<0>";
-		tmp[1] = format[1];
-		printk("%sALSA: ", tmp);
-		format += 3;
-	} else {
-		printk(KERN_DEBUG "ALSA: ");
-	}
-	va_start(args, format);
-	vsnprintf(tmpbuf, sizeof(tmpbuf)-1, format, args);
-	va_end(args);
-	tmpbuf[sizeof(tmpbuf)-1] = '\0';
-	printk(tmpbuf);
-}
-#endif
--- linux/sound/core/sound.c.orig	2003-02-13 15:48:42.000000000 -0600
+++ linux/sound/core/sound.c	2003-02-13 15:51:12.000000000 -0600
@@ -522,9 +522,6 @@
 #if defined(CONFIG_SND_DEBUG) && defined(CONFIG_SND_VERBOSE_PRINTK)
 EXPORT_SYMBOL(snd_verbose_printd);
 #endif
-#if defined(CONFIG_SND_DEBUG) && !defined(CONFIG_SND_VERBOSE_PRINTK)
-EXPORT_SYMBOL(snd_printd);
-#endif
   /* wrappers */
 #ifdef CONFIG_SND_DEBUG_MEMORY
 EXPORT_SYMBOL(snd_wrapper_kmalloc);

--ELM741935201-11515-0_--
