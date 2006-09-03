Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWICW3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWICW3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWICW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:29:09 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:61836 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751175AbWICW2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:28:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uLgO8RnwI4jma9OSLAMJryt881dScNycVvMTSqXL+nk4BwWjOhlKpYXIlXdrAfF2w+2xKhSnW0VWAOVQqsWCyAhdP2PEjdGwY8PwimY7n8SReL4G3qGk+9ouU1q3Q2l2I83pxrjvcgyCkBpmUrHULonNYDe/zmZAghaESV0RA3Y=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 04/26] Dynamic kernel command-line - arm26
Date: Mon, 4 Sep 2006 01:17:50 +0300
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
Message-Id: <200609040117.53161.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/arm26/kernel/setup.c linux-2.6.18-rc5-mm1/arch/arm26/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/arm26/kernel/setup.c	2006-09-03 18:56:47.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/arm26/kernel/setup.c	2006-09-03 20:58:31.000000000 +0300
@@ -80,7 +80,7 @@ unsigned long phys_initrd_size __initdat
 static struct meminfo meminfo __initdata = { 0, };
 static struct proc_info_item proc_info;
 static const char *machine_name;
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 
@@ -492,8 +492,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data   = (unsigned long) &_edata;
 	init_mm.brk	   = (unsigned long) &_end;
 
-	memcpy(saved_command_line, from, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, from, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	parse_cmdline(&meminfo, cmdline_p, from);
 	bootmem_init(&meminfo);
 	paging_init(&meminfo);

-- 
VGER BF report: H 0
