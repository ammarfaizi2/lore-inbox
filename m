Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWICWak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWICWak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWICW35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:29:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:10453 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751209AbWICW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:29:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qRkpgbZL+3Q2Y+DhLLZ6u+A82p2ofbp8VdvNyXle1iwKxGEQlLBeCPJjX+BAPCPA61zZ9W5NWAPNWdA2I45oYqGEiYruy0JenEeQy+GN7YocMski74YgF/ONRfJpnUELkSELxrY3PploBtHiZ/t4JLB1fLcocdZZZkxg8qU4DK4=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 08/26] Dynamic kernel command-line - h8300
Date: Mon, 4 Sep 2006 01:19:07 +0300
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
Message-Id: <200609040119.08633.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/h8300/kernel/setup.c linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/h8300/kernel/setup.c	2006-09-03 18:55:06.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/h8300/kernel/setup.c	2006-09-03 20:59:41.000000000 +0300
@@ -54,7 +54,7 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
@@ -154,8 +154,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p)) 

-- 
VGER BF report: H 0
