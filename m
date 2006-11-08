Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161743AbWKHWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161743AbWKHWQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWKHWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:16:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7337 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932797AbWKHWQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:16:49 -0500
Date: Wed, 8 Nov 2006 17:16:21 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH][2.6.19-rc5-mm1] i386: Convert more absolute symbols to section relative
Message-ID: <20061108221621.GB29705@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Convert more absolute symbols to section relative to keep the theme in
  vmlinux.lds.S file and to avoid problem if kernel is relocated.

o Also put a message so that in future people can be aware of it and 
  avoid introducing absolute symbols.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/vmlinux.lds.S |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-reloc-convert-more-abs-syms-to-section-relative arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc5-mm1-reloc/arch/i386/kernel/vmlinux.lds.S~i386-reloc-convert-more-abs-syms-to-section-relative	2006-11-08 16:24:31.000000000 -0500
+++ linux-2.6.19-rc5-mm1-reloc-root/arch/i386/kernel/vmlinux.lds.S	2006-11-08 16:29:51.000000000 -0500
@@ -2,6 +2,12 @@
  * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
  */
 
+/* Don't define absolute symbols until and unless you know that symbol
+ * value is should remain constant even if kernel image is relocated
+ * at run time. Absolute symbols are not relocated. If symbol value should
+ * change if kernel is relocated, make the symbol section relative and
+ * put it inside the section definition.
+ */
 #define LOAD_OFFSET __PAGE_OFFSET
 
 #include <asm-generic/vmlinux.lds.h>
@@ -63,11 +69,11 @@ SECTIONS
 	CONSTRUCTORS
 	} :data
 
-  __start_paravirtprobe = .;
   .paravirtprobe : AT(ADDR(.paravirtprobe) - LOAD_OFFSET) {
+  	__start_paravirtprobe = .;
 	*(.paravirtprobe)
+  	__stop_paravirtprobe = .;
   }
-  __stop_paravirtprobe = .;
 
   . = ALIGN(4096);
   .data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
@@ -163,11 +169,11 @@ SECTIONS
 	*(.altinstr_replacement)
   }
   . = ALIGN(4);
-  __start_parainstructions = .;
   .parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
+  	__start_parainstructions = .;
 	*(.parainstructions)
+  	__stop_parainstructions = .;
   }
-  __stop_parainstructions = .;
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
_
