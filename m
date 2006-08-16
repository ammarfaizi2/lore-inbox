Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWHPPdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWHPPdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHPPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:33:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:32677 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751195AbWHPPdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:33:18 -0400
Message-ID: <44E33B46.2010200@sw.ru>
Date: Wed, 16 Aug 2006 19:35:34 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: [RFC][PATCH 1/7] UBC: kconfig
References: <44E33893.6020700@sw.ru>
In-Reply-To: <44E33893.6020700@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel/ub/Kconfig file with UBC options and
includes it into arch Kconfigs

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

---
 arch/i386/Kconfig    |    2 ++
 arch/ia64/Kconfig    |    2 ++
 arch/powerpc/Kconfig |    2 ++
 arch/ppc/Kconfig     |    2 ++
 arch/sparc/Kconfig   |    2 ++
 arch/sparc64/Kconfig |    2 ++
 arch/x86_64/Kconfig  |    2 ++
 kernel/ub/Kconfig    |   25 +++++++++++++++++++++++++
 8 files changed, 39 insertions(+)

--- ./arch/i386/Kconfig.ubkm	2006-07-10 12:39:10.000000000 +0400
+++ ./arch/i386/Kconfig	2006-07-28 14:10:41.000000000 +0400
@@ -1146,6 +1146,8 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source "kernel/ub/Kconfig"
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
--- ./arch/ia64/Kconfig.ubkm	2006-07-10 12:39:10.000000000 +0400
+++ ./arch/ia64/Kconfig	2006-07-28 14:10:56.000000000 +0400
@@ -481,6 +481,8 @@ source "fs/Kconfig"
 
 source "lib/Kconfig"
 
+source "kernel/ub/Kconfig"
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
--- ./arch/powerpc/Kconfig.arkcfg	2006-08-07 14:07:12.000000000 +0400
+++ ./arch/powerpc/Kconfig	2006-08-10 17:55:58.000000000 +0400
@@ -1038,6 +1038,8 @@ source "arch/powerpc/platforms/iseries/K
 
 source "lib/Kconfig"
 
+source "ub/Kconfig"
+
 menu "Instrumentation Support"
         depends on EXPERIMENTAL
 
--- ./arch/ppc/Kconfig.arkcfg	2006-07-10 12:39:10.000000000 +0400
+++ ./arch/ppc/Kconfig	2006-08-10 17:56:13.000000000 +0400
@@ -1414,6 +1414,8 @@ endmenu
 
 source "lib/Kconfig"
 
+source "ub/Kconfig"
+
 source "arch/powerpc/oprofile/Kconfig"
 
 source "arch/ppc/Kconfig.debug"
--- ./arch/sparc/Kconfig.arkcfg	2006-04-21 11:59:32.000000000 +0400
+++ ./arch/sparc/Kconfig	2006-08-10 17:56:24.000000000 +0400
@@ -296,3 +296,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "ub/Kconfig"
--- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
+++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
@@ -432,3 +432,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "lib/Kconfig"
--- ./arch/x86_64/Kconfig.ubkm	2006-07-10 12:39:11.000000000 +0400
+++ ./arch/x86_64/Kconfig	2006-07-28 14:10:49.000000000 +0400
@@ -655,3 +655,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source "kernel/ub/Kconfig"
--- ./kernel/ub/Kconfig.ubkm	2006-07-28 13:07:38.000000000 +0400
+++ ./kernel/ub/Kconfig	2006-07-28 13:09:51.000000000 +0400
@@ -0,0 +1,25 @@
+#
+# User resources part (UBC)
+#
+# Copyright (C) 2006 OpenVZ. SWsoft Inc
+
+menu "User resources"
+
+config USER_RESOURCE
+	bool "Enable user resource accounting"
+	default y
+	help 
+          This patch provides accounting and allows to configure
+          limits for user's consumption of exhaustible system resources.
+          The most important resource controlled by this patch is unswappable 
+          memory (either mlock'ed or used by internal kernel structures and 
+          buffers). The main goal of this patch is to protect processes
+          from running short of important resources because of an accidental
+          misbehavior of processes or malicious activity aiming to ``kill'' 
+          the system. It's worth to mention that resource limits configured 
+          by setrlimit(2) do not give an acceptable level of protection 
+          because they cover only small fraction of resources and work on a 
+          per-process basis.  Per-process accounting doesn't prevent malicious
+          users from spawning a lot of resource-consuming processes.
+
+endmenu
