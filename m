Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWICWgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWICWgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWICW3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:29:14 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:61836 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751193AbWICW3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:29:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qKr1sSZbGcXd9tEJRfXCKxBcIF7P7d6/5LAXLzfU9X0HEVMnOUtQvgvpNqi0C6iytNMegrGJWiE5mK6jvbWWLmV6zUCP0MAvzkhfrfoJ6+i/yQNP1vXIVQkn6ELlXG4h3XADYpboulvf8wQtkkh+AAC2ff1w57O+KarYf4u59YI=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 06/26] Dynamic kernel command-line - cris
Date: Mon, 4 Sep 2006 01:18:26 +0300
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
Message-Id: <200609040118.28652.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/cris/kernel/setup.c linux-2.6.18-rc5-mm1/arch/cris/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/cris/kernel/setup.c	2006-09-03 18:56:48.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/cris/kernel/setup.c	2006-09-03 20:58:59.000000000 +0300
@@ -29,7 +29,7 @@ struct screen_info screen_info;
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
-char cris_command_line[COMMAND_LINE_SIZE] = { 0, };
+char __initdata cris_command_line[COMMAND_LINE_SIZE] = { 0, };
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
@@ -153,8 +153,8 @@ setup_arch(char **cmdline_p)
 #endif
 
 	/* Save command line for future references. */
-	memcpy(saved_command_line, cris_command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy(boot_command_line, cris_command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	/* give credit for the CRIS port */
 	show_etrax_copyright();

-- 
VGER BF report: H 0
