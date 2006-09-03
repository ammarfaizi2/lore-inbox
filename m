Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWICWJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWICWJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWICWJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:09:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750904AbWICWJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i2ADbRDS4MeblgzMSc30+6sB3cuhBwh+2MDF1FoaLod36+Kwlxuh/m6n9jAiz1UWF52MHfzaDfW3DWjoGhGczV5w40caD+sMVyg9SpvTrr33M5WJ1aHI8CV1bPi7fF8jvOPOyqr5qf3Ey6+RTToh+Ds4r5Q5ZZdYiADKIFyLq5M=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 17/26] Dynamic kernel command-line - ppc
Date: Mon, 4 Sep 2006 01:00:07 +0300
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
References: <200609040050.13410.alon.barlev@gmail.com>
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040100.09621.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/ppc/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/ppc/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/ppc/kernel/setup.c	
2006-09-03 18:55:16.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ppc/kernel/setup.c	2006-09-03 
19:47:58.000000000 +0300
@@ -538,7 +538,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) klimit;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();
diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/lopec.c 
linux-2.6.18-rc5-mm1/arch/ppc/platforms/lopec.c
--- linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/lopec.c	
2006-09-03 18:55:16.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ppc/platforms/lopec.c	
2006-09-03 19:47:58.000000000 +0300
@@ -344,7 +344,7 @@ lopec_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/pplus.c 
linux-2.6.18-rc5-mm1/arch/ppc/platforms/pplus.c
--- linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/pplus.c	
2006-09-03 18:55:16.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ppc/platforms/pplus.c	
2006-09-03 19:47:58.000000000 +0300
@@ -592,7 +592,7 @@ static void __init pplus_setup_arch(void
 		if (bootargs != NULL) {
 			strcpy(cmd_line, bootargs);
 			/* again.. */
-			strcpy(saved_command_line, cmd_line);
+			strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/prep_setup.c 
linux-2.6.18-rc5-mm1/arch/ppc/platforms/prep_setup.c
--- linux-2.6.18-rc5-mm1.org/arch/ppc/platforms/prep_setup.c	
2006-09-03 18:55:16.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/ppc/platforms/prep_setup.c	
2006-09-03 19:47:58.000000000 +0300
@@ -634,7 +634,7 @@ static void __init prep_init_sound(void)
 	/*
 	 * Find a way to push these informations to the cs4232 
driver
 	 * Give it out with printk, when not in cmd_line?
-	 * Append it to  cmd_line and saved_command_line?
+	 * Append it to  cmd_line and boot_command_line?
 	 * Format is cs4232=io,irq,dma,dma2
 	 */
 }
@@ -897,7 +897,7 @@ prep_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
 

-- 
VGER BF report: H 0.237512
