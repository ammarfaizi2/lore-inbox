Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVCPWuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVCPWuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVCPWuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:50:37 -0500
Received: from zork.zork.net ([64.81.246.102]:28814 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262841AbVCPWua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:50:30 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
References: <20050316040654.62881834.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Wed, 16 Mar 2005 22:50:28 +0000
In-Reply-To: <20050316040654.62881834.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 16 Mar 2005 04:06:54 -0800")
Message-ID: <6u8y4n434b.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fails to build here:

  arch/ppc/platforms/built-in.o(.pmac.text+0x6828): In function `flush_disable_caches':
  : undefined reference to `cpufreq_frequency_table_verify'
  arch/ppc/platforms/built-in.o(.pmac.text+0x6868): In function `flush_disable_caches':
  : undefined reference to `cpufreq_frequency_table_target'
  arch/ppc/platforms/built-in.o(.pmac.text+0x68f0): In function `flush_disable_caches':
  : undefined reference to `cpufreq_frequency_table_cpuinfo'
  make: *** [.tmp_vmlinux1] Error 1


This patch makes it work again; there are duplicate CPU_FREQ_TABLE
definitions in some arch Kconfigs.  Possibly not the Right Thing(tm).

[briny(~/build/linux/S11-mm4)] find arch/ -name Kconfig | xargs grep '^config CPU_FREQ_TABLE'
arch/sparc64/Kconfig:config CPU_FREQ_TABLE
arch/sh/Kconfig:config CPU_FREQ_TABLE
arch/ppc/Kconfig:config CPU_FREQ_TABLE
arch/x86_64/kernel/cpufreq/Kconfig:config CPU_FREQ_TABLE


--- S11-mm4/drivers/cpufreq/Kconfig~	2005-03-16 22:12:52.000000000 +0000
+++ S11-mm4/drivers/cpufreq/Kconfig	2005-03-16 22:37:59.000000000 +0000
@@ -15,9 +15,6 @@
 
 if CPU_FREQ
 
-config CPU_FREQ_TABLE
-       def_tristate m
-
 config CPU_FREQ_DEBUG
 	bool "Enable CPUfreq debugging"
 	help

-- 
Dag vijandelijk luchtschip de huismeester is dood
