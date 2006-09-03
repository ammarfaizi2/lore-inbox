Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWICWHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWICWHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWICWHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:07:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:36363 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750816AbWICWH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:07:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dmBbuhEN+/o+aw2maaURVF0V7C5jy0UBgaOfB9A45rznX09bo93ihFjvonNgnjA+KJxEc4I9tLqJOUbQBahgo9T41Z8g5k+8ZWSZ7RdONwxA4HOfzBraAfCbcmFHVMGZP9PIRBwiv6jTffh6lQYeSy07PXX4ih2/E31b1KYhxYc=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 05/26] Dynamic kernel command-line - avr32
Date: Mon, 4 Sep 2006 00:54:39 +0300
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
Message-Id: <200609040054.43018.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/avr32/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/avr32/kernel/setup.c	
2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/avr32/kernel/setup.c	
2006-09-03 20:58:45.000000000 +0300
@@ -44,7 +44,7 @@ struct avr32_cpuinfo boot_cpu_data = {
 };
 EXPORT_SYMBOL(boot_cpu_data);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * Should be more than enough, but if you have a _really_ 
complex
@@ -94,7 +94,7 @@ static unsigned long __initdata fbmem_si
 
 static void __init parse_cmdline_early(char **cmdline_p)
 {
-	char *to = command_line, *from = saved_command_line;
+	char *to = command_line, *from = boot_command_line;
 	int len = 0;
 	char c = ' ';
 
@@ -226,7 +226,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
 
 static int __init parse_tag_cmdline(struct tag *tag)
 {
-	strlcpy(saved_command_line, tag->u.cmdline.cmdline, 
COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, tag->u.cmdline.cmdline, 
COMMAND_LINE_SIZE);
 	return 0;
 }
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);

-- 
VGER BF report: H 0.156751
