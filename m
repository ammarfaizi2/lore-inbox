Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271300AbTGQAvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271301AbTGQAvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:51:35 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:10929 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S271300AbTGQAva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:51:30 -0400
Date: Wed, 16 Jul 2003 21:06:22 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test1 Nonexistent Symbols During Config
Message-ID: <20030717010622.GJ1779@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"make menuconfig" emits the following before it starts:

boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:68: trying to assign nonexistent symbol X86_SSE2
arch/i386/defconfig:544: trying to assign nonexistent symbol NET_PCMCIA_RADIO
arch/i386/defconfig:663: trying to assign nonexistent symbol INTEL_RNG

If these symbols have in fact been removed, the patch below removes
them. Not sure how to address the forced test, though.

Kurt
-- 
"Life to you is a bold and dashing responsibility"
		-- a Mary Chung's fortune cookie
$ diff -Naur arch/i386/defconfig.orig arch/i386/defconfig
--- arch/i386/defconfig.orig	2003-07-13 23:35:57.000000000 -0400
+++ arch/i386/defconfig	2003-07-16 00:41:31.000000000 -0400
@@ -65,7 +65,6 @@
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
-CONFIG_X86_SSE2=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_SMP=y
 # CONFIG_PREEMPT is not set
@@ -541,7 +540,6 @@
 # CONFIG_PCMCIA_SMC91C92 is not set
 # CONFIG_PCMCIA_XIRC2PS is not set
 # CONFIG_PCMCIA_AXNET is not set
-CONFIG_NET_PCMCIA_RADIO=y
 CONFIG_PCMCIA_RAYCS=y
 
 #
@@ -660,7 +658,6 @@
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-CONFIG_INTEL_RNG=y
 # CONFIG_AMD_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_RTC is not set
