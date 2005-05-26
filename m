Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVEZH0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEZH0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVEZH0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:26:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:31404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVEZHZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:25:54 -0400
Date: Thu, 26 May 2005 00:24:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org, christoph@lameter.com
Subject: Re: 2.6.12-rc5-mm1
Message-Id: <20050526002459.320abe65.akpm@osdl.org>
In-Reply-To: <195320000.1117091674@[10.10.2.4]>
References: <175590000.1117089446@[10.10.2.4]>
	<20050525234717.261beb48.akpm@osdl.org>
	<191140000.1117091133@[10.10.2.4]>
	<195320000.1117091674@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> source kernel/Kconfig.hz is under:
>  menu "APM (Advanced Power Management) BIOS Support"
>  depends on PM && !X86_VISWS
> 
>  So it's screwed if you don't have PM defined, it seems.

Ah, OK.  Something like this:

--- 25/arch/i386/Kconfig~i386-selectable-frequency-of-the-timer-interrupt-fix	2005-05-26 00:22:55.000000000 -0700
+++ 25-akpm/arch/i386/Kconfig	2005-05-26 00:22:55.000000000 -0700
@@ -1116,8 +1116,6 @@ config APM_REAL_MODE_POWER_OFF
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
-source kernel/Kconfig.hz
-
 endmenu
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
@@ -1275,6 +1273,8 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
+source kernel/Kconfig.hz
+
 #
 # Use the generic interrupt handling code in kernel/irq/:
 #
diff -puN arch/x86_64/Kconfig~i386-selectable-frequency-of-the-timer-interrupt-fix arch/x86_64/Kconfig
--- 25/arch/x86_64/Kconfig~i386-selectable-frequency-of-the-timer-interrupt-fix	2005-05-26 00:22:55.000000000 -0700
+++ 25-akpm/arch/x86_64/Kconfig	2005-05-26 00:22:55.000000000 -0700
@@ -401,8 +401,6 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
-source kernel/Kconfig.hz
-
 endmenu
 
 #
@@ -517,3 +515,5 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+source kernel/Kconfig.hz
_



and this:


--- 25/arch/ia64/Kconfig~ia64-selectable-timer-interrupt-frequency-fix	2005-05-26 00:23:18.000000000 -0700
+++ 25-akpm/arch/ia64/Kconfig	2005-05-26 00:23:39.000000000 -0700
@@ -157,8 +157,6 @@ config IA64_PAGE_SIZE_64KB
 
 endchoice
 
-source kernel/Kconfig.hz
-
 config IA64_BRL_EMU
 	bool
 	depends on ITANIUM
@@ -445,3 +443,5 @@ source "arch/ia64/Kconfig.debug"
 source "security/Kconfig"
 
 source "crypto/Kconfig"
+
+source kernel/Kconfig.hz
_

