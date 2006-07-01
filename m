Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWGAWDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWGAWDV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGAWDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:03:21 -0400
Received: from hera.kernel.org ([140.211.167.34]:52105 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750941AbWGAWDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:03:21 -0400
Date: Sat, 1 Jul 2006 18:59:13 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Include __param section in read-only data range
Message-ID: <20060701215913.GA4298@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The param section is an array of "kernel_param" structures, storing only
constant data: pointer to name, permission of the variable pointed to by
(void *)arg and pointers to set/get methods.

Move end_rodata down to include __param section in the read-only range
used by CONFIG_DEBUG_RODATA.

Signed-off-by: Marcelo Tosatti <marcelo@kvack.org>

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9d11550..175b632 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -90,15 +90,15 @@ #define RODATA								\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
 	}								\
-	__end_rodata = .;						\
-	. = ALIGN(4096);						\
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
 		VMLINUX_SYMBOL(__start___param) = .;			\
 		*(__param)						\
 		VMLINUX_SYMBOL(__stop___param) = .;			\
-	}
+	}								\
+	__end_rodata = .;						\
+	. = ALIGN(4096);						
 
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
