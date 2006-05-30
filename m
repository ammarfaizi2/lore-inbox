Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWE3U5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWE3U5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWE3U5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:57:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:23475 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932414AbWE3U5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:57:48 -0400
Date: Tue, 30 May 2006 22:58:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: disable OPROFILE if LOCKDEP=y
Message-ID: <20060530205808.GA28323@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: disable OPROFILE if LOCKDEP=y
From: Ingo Molnar <mingo@elte.hu>

NMIs are not working yet under LOCKDEP, so make sure they are
disabled.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/oprofile/Kconfig   |    2 +-
 arch/x86_64/oprofile/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/oprofile/Kconfig
===================================================================
--- linux.orig/arch/i386/oprofile/Kconfig
+++ linux/arch/i386/oprofile/Kconfig
@@ -7,7 +7,7 @@ config PROFILING
 
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING
+	depends on PROFILING && !LOCKDEP
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
Index: linux/arch/x86_64/oprofile/Kconfig
===================================================================
--- linux.orig/arch/x86_64/oprofile/Kconfig
+++ linux/arch/x86_64/oprofile/Kconfig
@@ -7,7 +7,7 @@ config PROFILING
 
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING
+	depends on PROFILING && !LOCKDEP
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
