Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWICWai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWICWai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWICWaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:30:01 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:23952 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWICW3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uSChv92H9eOr4ntStjhwThu7yB3p/wxy05+rvrXDmMYKgNUsb75LlGRTNUsm7u3nVaI0x7wi4Wez/+Vv7kJb4MsiRbaasZazcCTnxWF+2d9Bqfub032df/xFnYTLaiGXq5Kmop8zMTgGHbkS+D9PZF26ZcE/nMfIlSwTYbEW+kY=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 11/26] Dynamic kernel command-line - m32r
Date: Mon, 4 Sep 2006 01:20:19 +0300
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
Message-Id: <200609040120.21054.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/m32r/kernel/setup.c linux-2.6.18-rc5-mm1/arch/m32r/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/m32r/kernel/setup.c	2006-09-03 18:55:09.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/m32r/kernel/setup.c	2006-09-03 21:00:37.000000000 +0300
@@ -64,7 +64,7 @@ struct screen_info screen_info = {
 
 extern int root_mountflags;
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static struct resource data_resource = {
 	.name   = "Kernel data",
@@ -95,8 +95,8 @@ static __inline__ void parse_mem_cmdline
 	int usermem = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)CONFIG_MEMORY_START+PAGE_OFFSET;
 	memory_end = memory_start+(unsigned long)CONFIG_MEMORY_SIZE;

-- 
VGER BF report: H 0
