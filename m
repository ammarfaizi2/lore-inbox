Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTBOWsm>; Sat, 15 Feb 2003 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTBOWsm>; Sat, 15 Feb 2003 17:48:42 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:39327 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265351AbTBOWsl>; Sat, 15 Feb 2003 17:48:41 -0500
Date: Sat, 15 Feb 2003 23:57:38 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davej@suse.de, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq: fix compilation of ACPI if !CPU_FREQ [Was: Re: [PATCH UPDATED] cpufreq: move frequency table helpers to extra module]
Message-ID: <20030215225738.GA1363@brodo.de>
References: <20030213111406.GA23909@brodo.de> <Pine.LNX.4.44.0302151252110.21697-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151252110.21697-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 12:53:56PM -0800, Linus Torvalds wrote:
> 
> Dominic,
>  this broke ACPI. 
> 
> 	In file included from drivers/acpi/processor.c:49:
> 	include/acpi/processor.h:78: field `freq_table' has incomplete type
> 
> AGAIN.
> 
> For about the 15th time. 
> 
> You guys need to talk more. A LOT more. Or y ou need to start checking who 
> is actually _using_ the frequency code, and when you make changes to the 
> interfaces you need to _update_ the users, instead of just causing kernel 
> compiles to fail every frigging time you make a change.
> 
> 		Linus

Linus,

here's the compile fix for this breakage which only appears if
CONFIG_ACPI && !(CONFIG_CPU_FREQ_TABLE || CONFIG_CPU_FREQ_TABLE_MODULE)
Unfortunately, I forgot to test-compile this combination. Sorry about
that.

	Dominik

diff -u linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-02-15 23:35:14.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-02-15 23:28:32.000000000 +0100
@@ -299,7 +299,7 @@
 
 #endif /* CONFIG_CPU_FREQ_24_API */
 
-#if defined(CONFIG_CPU_FREQ_TABLE) || defined(CONFIG_CPU_FREQ_TABLE_MODULE)
+
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
@@ -313,6 +313,7 @@
 				    * order */
 };
 
+#if defined(CONFIG_CPU_FREQ_TABLE) || defined(CONFIG_CPU_FREQ_TABLE_MODULE)
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
 
