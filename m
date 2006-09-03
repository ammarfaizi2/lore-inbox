Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWICWb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWICWb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWICWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:31:21 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:23952 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751193AbWICWa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:30:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jSCiPdzeg9OJyXjwqUpAFG43Lh5dNrqFEqt7+66ackJrCOxKhnYOLWeanQO81puturOrxHfr3NabiWFauUPn11bQuLE8zp/M8pRxCp/OrQnwETF8Hr+I6pZNnIBJleqCcfzekzKuc7ZyrA6EuYDuAZk9+6N8SAJ7Q8Z+SjD1iCg=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 19/26] Dynamic kernel command-line - sh
Date: Mon, 4 Sep 2006 01:22:36 +0300
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
Message-Id: <200609040122.36888.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/sh/kernel/setup.c linux-2.6.18-rc5-mm1/arch/sh/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/sh/kernel/setup.c	2006-09-03 18:56:51.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/sh/kernel/setup.c	2006-09-03 21:02:18.000000000 +0300
@@ -88,7 +88,7 @@ static struct sh_machine_vector* __init 
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f },
@@ -125,8 +125,8 @@ static inline void parse_cmdline (char *
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)PAGE_OFFSET+__MEMORY_START;
 	memory_end = memory_start + __MEMORY_SIZE;

-- 
VGER BF report: H 0
