Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWIERhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWIERhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWIERho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:37:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:29669 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932202AbWIERhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:37:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SnBl/qZQ9bJDY9yBRmevxqveAYV4tvGZl0wWd745OZS4v1qX9+YH9m6uLOUEhr6Mk7uZMcdnGsgC65C/kf1dRYaK6KkhuMVwWZ+RMzhrfKTp1J2aGgKG5PugLIN9DPQW+laPLq5y83WsVFVAYdwVjNI09GRK6VVgFUgYaQA0zAU=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 23/26] Dynamic kernel command-line - um
Date: Tue, 5 Sep 2006 20:35:50 +0300
User-Agent: KMail/1.9.4
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, paulus@samba.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040115.22856.alon.barlev@gmail.com> <200609040123.43788.alon.barlev@gmail.com> <20060905102411.0767059a.rdunlap@xenotime.net>
In-Reply-To: <20060905102411.0767059a.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609052035.51229.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 20:24, Randy.Dunlap wrote:
> Please use tabs instead of spaces for indentation.

It was in the original file, didn't notice...

Here it is again...

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h linux-2.6.18-rc5-mm1/arch/um/include/user_util.h
--- linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h	2006-06-18 04:49:35.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/um/include/user_util.h	2006-09-03 23:47:03.000000000 +0300
@@ -38,7 +38,7 @@ extern unsigned long long highmem;
 
 extern char host_info[];
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
 extern unsigned long _unprotected_end;
diff -urNp linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c
--- linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c	2006-09-03 18:56:51.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c	2006-09-03 19:47:59.000000000 +0300
@@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&panic_exit_notifier);
 	paging_init();
-        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
