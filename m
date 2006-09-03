Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWICW2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWICW2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWICW2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:28:30 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:61836 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751084AbWICW23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qGVM8Jc67Gxs6eqDK7MUHfKiz2K05IliJBQghyVET8To0kGj1K9W8mJleTmxrQEmhoEuUY7msK8CkU0Zp+r/Q204EmmDcFBqSm7oCcoS1JZQTvfh6pGfjtOgdr81F+UFD61alVKGnE9+wMZQ9O1d6VT+b+SWZPaD+f6NdrkLG4I=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 02/26] Dynamic kernel command-line - alpha
Date: Mon, 4 Sep 2006 01:17:05 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040115.22856.alon.barlev@gmail.com>
In-Reply-To: <200609040115.22856.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040117.06736.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/alpha/kernel/setup.c linux-2.6.18-rc5-mm1/arch/alpha/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/alpha/kernel/setup.c	2006-09-03 18:56:47.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/alpha/kernel/setup.c	2006-09-03 20:57:36.000000000 +0300
@@ -120,7 +120,7 @@ static void get_sysnames(unsigned long, 
 			 char **, char **);
 static void determine_cpu_caches (unsigned int);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
@@ -541,7 +541,7 @@ setup_arch(char **cmdline_p)
 	} else {
 		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
-	strcpy(saved_command_line, command_line);
+	strcpy(boot_command_line, command_line);
 	*cmdline_p = command_line;
 
 	/* 
@@ -583,7 +583,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {

-- 
VGER BF report: H 0
