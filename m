Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWICWJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWICWJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWICWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:08:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750699AbWICWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:08:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lMx9MgWluvO9BxzxLVnvG3hd3hccgzb8YIXvOUKPsnoh1bReAravhPIrRVFVjeSGVdvi3fisIyoL5OVzYdGOgvaDNpuB0tSU2WBxolc2UWv8Yb9XkT8TzJrFi0cKED7iGlsFbg8oSAkUcuBNcBIIBCIkIyZ4Bln8ZCPnihzxUqw=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 13/26] Dynamic kernel command-line - m68knommu
Date: Mon, 4 Sep 2006 00:58:20 +0300
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
Message-Id: <200609040058.23401.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/m68knommu/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/m68knommu/kernel/setup.c	
2006-09-03 18:55:10.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/m68knommu/kernel/setup.c	
2006-09-03 21:00:57.000000000 +0300
@@ -47,7 +47,7 @@ unsigned long memory_end;
 EXPORT_SYMBOL(memory_start);
 EXPORT_SYMBOL(memory_end);
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
@@ -234,8 +234,8 @@ void setup_arch(char **cmdline_p)
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, 
COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, 
COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p))

-- 
VGER BF report: H 0.0160245
