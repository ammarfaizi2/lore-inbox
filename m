Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWICW3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWICW3x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWICW3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:29:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:10453 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWICW33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:29:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pEZjwav+qKe29P/vS4bUvWT7mPlLsscZ/xXndqYwI7dejAimYam1tjwjE5uVjQaL+J9xdzCeNHv6gKfuNriPyOb00IVxgfi8GgB2HHC0TOBlpUBjp9ManLi+N7bFuru7uUOKdSxDQZWgy3/yYOObouzsGy26vcaAjoACckwsXK0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 09/26] Dynamic kernel command-line - i386
Date: Mon, 4 Sep 2006 01:19:24 +0300
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
Message-Id: <200609040119.26111.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/i386/kernel/head.S linux-2.6.18-rc5-mm1/arch/i386/kernel/head.S
--- linux-2.6.18-rc5-mm1.org/arch/i386/kernel/head.S	2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/i386/kernel/head.S	2006-09-03 19:47:58.000000000 +0300
@@ -97,7 +97,7 @@ ENTRY(startup_32)
 	movzwl OLD_CL_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
-	movl $(saved_command_line - __PAGE_OFFSET),%edi
+	movl $(boot_command_line - __PAGE_OFFSET),%edi
 	movl $(COMMAND_LINE_SIZE/4),%ecx
 	rep
 	movsl
diff -urNp linux-2.6.18-rc5-mm1.org/arch/i386/kernel/setup.c linux-2.6.18-rc5-mm1/arch/i386/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/i386/kernel/setup.c	2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/i386/kernel/setup.c	2006-09-03 20:54:39.000000000 +0300
@@ -145,7 +145,7 @@ unsigned long saved_videomode;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
@@ -1396,7 +1396,7 @@ void __init setup_arch(char **cmdline_p)
 		print_memory_map("user");
 	}
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	max_low_pfn = setup_memory();

-- 
VGER BF report: H 0
