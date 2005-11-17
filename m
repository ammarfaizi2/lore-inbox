Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVKQOGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVKQOGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKQOGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:06:11 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31484 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750851AbVKQOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:06:10 -0500
Subject: [patch -rt] add EXPORT_PER_CPU_LOCKED_SYMBOL to asm-x86_64/percpu.h
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 09:05:58 -0500
Message-Id: <1132236358.11652.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I was getting some module dependency problems until I found that the
source of these problems was that there was no
EXPORT_PER_CPU_LOCKED_SYMBOL in the asm-x86_64.

Here's the patch:

-- Steve

Index: linux-2.6.14-rt13/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.14-rt13.orig/include/asm-x86_64/percpu.h	2005-11-15 11:12:37.000000000 -0500
+++ linux-2.6.14-rt13/include/asm-x86_64/percpu.h	2005-11-17 08:53:47.000000000 -0500
@@ -70,5 +70,7 @@
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+#define EXPORT_PER_CPU_LOCKED_SYMBOL(var) EXPORT_SYMBOL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL(per_cpu__##var##_locked)
+#define EXPORT_PER_CPU_LOCKED_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu_lock__##var##_locked); EXPORT_SYMBOL_GPL(per_cpu__##var##_locked)
 
 #endif /* _ASM_X8664_PERCPU_H_ */


