Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWJEVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWJEVmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJEVmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:16 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:10883 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932255AbWJEVmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=tiutH5MwToPfsRB1DJ4z4kHSTca13I8Z2ajraKImkB8IHudVa2iS+gqYW1dHC0cbjGg6KbfLrPqaEqWUU/z3O26l5peCjvatFWTYnRvZoTbPKLSjgnqV0EW9e7TPHvHgT2TYrm8LFhKjEDJMncWVNn2hRx8ZlJZvDMpwKCFCU+A=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/14] uml: allow using again x86/x86_64 crypto code
Date: Thu, 05 Oct 2006 23:39:06 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213906.17268.44290.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable compilation of x86_64 crypto code;, and add the needed constant to make
the code compile again (that macro was added to i386 asm-offsets between 2.6.17
and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64                        |    2 +-
 arch/um/include/common-offsets.h               |    1 +
 arch/um/include/sysdep-i386/kernel-offsets.h   |    1 +
 arch/um/include/sysdep-x86_64/kernel-offsets.h |    1 +
 4 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 87d6373..d278682 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-core-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/ arch/x86_64/crypto/
 START := 0x60000000
 
 _extra_flags_ = -fno-builtin -m64
diff --git a/arch/um/include/common-offsets.h b/arch/um/include/common-offsets.h
index 356390d..39bb210 100644
--- a/arch/um/include/common-offsets.h
+++ b/arch/um/include/common-offsets.h
@@ -15,3 +15,4 @@ DEFINE_STR(UM_KERN_DEBUG, KERN_DEBUG);
 DEFINE(UM_ELF_CLASS, ELF_CLASS);
 DEFINE(UM_ELFCLASS32, ELFCLASS32);
 DEFINE(UM_ELFCLASS64, ELFCLASS64);
+DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
diff --git a/arch/um/include/sysdep-i386/kernel-offsets.h b/arch/um/include/sysdep-i386/kernel-offsets.h
index 2c13de3..2e58c4c 100644
--- a/arch/um/include/sysdep-i386/kernel-offsets.h
+++ b/arch/um/include/sysdep-i386/kernel-offsets.h
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/mman.h>
 
 #define DEFINE(sym, val) \
diff --git a/arch/um/include/sysdep-x86_64/kernel-offsets.h b/arch/um/include/sysdep-x86_64/kernel-offsets.h
index 91d129f..4cbfbb9 100644
--- a/arch/um/include/sysdep-x86_64/kernel-offsets.h
+++ b/arch/um/include/sysdep-x86_64/kernel-offsets.h
@@ -2,6 +2,7 @@ #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/elf.h>
+#include <linux/crypto.h>
 #include <asm/page.h>
 #include <asm/mman.h>
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
