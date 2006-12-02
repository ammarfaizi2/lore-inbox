Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162922AbWLBLIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162922AbWLBLIR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbWLBK7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:63718 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759486AbWLBK7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IZgGQxJnh0fzMoUKKk3NBMcvWtPIbMCXrssxhKc9fpI3oWgKmDQfRbMhEusO1s+jTTELM8gDWPiNRgMUPXRblVTn42cdx++X1v4PxelkE8t+EhK1qtmSIHWNXVFamlOWzPXs7uE2d9LCj3IGTWiN09a1iNLOFjyVeRwNYqcVW+Y=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/26] Dynamic kernel command-line - um
Date: Sat, 2 Dec 2006 12:56:38 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021256.39595.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/um/include/user_util.h linux-2.6.19/arch/um/include/user_util.h
--- linux-2.6.19.org/arch/um/include/user_util.h	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/um/include/user_util.h	2006-12-02 11:31:33.000000000 +0200
@@ -38,7 +38,7 @@ extern unsigned long long highmem;
 
 extern char host_info[];
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
 extern unsigned long _unprotected_end;
diff -urNp linux-2.6.19.org/arch/um/kernel/um_arch.c linux-2.6.19/arch/um/kernel/um_arch.c
--- linux-2.6.19.org/arch/um/kernel/um_arch.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/um/kernel/um_arch.c	2006-12-02 11:31:33.000000000 +0200
@@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&panic_exit_notifier);
 	paging_init();
-        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
