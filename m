Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWICWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWICWLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWICWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:10:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750699AbWICWJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B0GNbED3NT18KPYtms23htjfLxLrmOErVlcFTo2R74T8NIDy2nnlXgOH8jJuj7ueV3Ebh7FDHvZeyVwdJb2X2+cPEr5Z/1wqBO8arr9yc0YwPNq4uv4Y3JsfKfcFbKq7y4tk8gc+uV+qqFQE00bJJPL+Ks2gG2Hapvwbr3wyOIw=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 23/26] Dynamic kernel command-line - um
Date: Mon, 4 Sep 2006 01:02:35 +0300
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
Message-Id: <200609040102.38868.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h 
linux-2.6.18-rc5-mm1/arch/um/include/user_util.h
--- linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h	
2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/um/include/user_util.h	
2006-09-03 23:47:03.000000000 +0300
@@ -38,7 +38,7 @@ extern unsigned long long highmem;
 
 extern char host_info[];
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, 
__bss_start, _end;
 extern unsigned long _unprotected_end;
diff -urNp linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c 
linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c
--- linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c	
2006-09-03 18:56:51.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c	2006-09-03 
19:47:59.000000000 +0300
@@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&panic_exit_notifier);
 	paging_init();
-        strlcpy(saved_command_line, command_line, 
COMMAND_LINE_SIZE);
+        strlcpy(boot_command_line, command_line, 
COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }

-- 
VGER BF report: H 0.000270213
