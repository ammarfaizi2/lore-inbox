Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTAFWZM>; Mon, 6 Jan 2003 17:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAFWZL>; Mon, 6 Jan 2003 17:25:11 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:13798 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267183AbTAFWZJ>; Mon, 6 Jan 2003 17:25:09 -0500
Date: Mon, 6 Jan 2003 23:34:43 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq: make gcc-2.91.66 happy (Was: Re: [PATCH 2.5.54] cpufreq: update timer notifier)
Message-ID: <20030106223443.GA1912@brodo.de>
References: <20030106135521.GC1307@brodo.de> <3E19F667.30043A97@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E19F667.30043A97@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the cpufreq #defines so that gcc-2.91.66 should
work happily with cpufreq.

On Mon, Jan 06, 2003 at 01:34:31PM -0800, Andrew Morton wrote:
> Dominik Brodowski wrote:
> > 
> > +#else
> > +#define adjust_jiffies(...)
> > +#endif
> 
> This will fail to compile on gcc-2.91.66.  It's OK on 2.95.3.
> 
> sparc64 requires a compiler of similar vintage (2.92.11), so
> I am trying to keep 2.91.66-on-x86 limping along so that breakage
> can be detected more easily.
> 
> Please use
> 
> 	#define adjust_jiffies(x...) do {} while (0)
> 
> here.   Or an empty inline, which tends to be nicer, because you
> still get argument type checking.

diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-06 23:27:59.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-06 23:29:49.000000000 +0100
@@ -734,8 +734,8 @@
 }
 
 #else
-#define cpufreq_sysctl_init()
-#define cpufreq_sysctl_exit()
+#define cpufreq_sysctl_init() do {} while(0)
+#define cpufreq_sysctl_exit() do {} while(0)
 #endif /* CONFIG_SYSCTL */
 #endif /* CONFIG_CPU_FREQ_24_API */
 
@@ -946,7 +946,7 @@
 		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
 }
 #else
-#define adjust_jiffies(...)
+#define adjust_jiffies(x...) do {} while (0)
 #endif
 
 
@@ -1131,6 +1131,6 @@
 }
 EXPORT_SYMBOL_GPL(cpufreq_restore);
 #else
-#define cpufreq_restore()
+#define cpufreq_restore() do {} while (0)
 #endif /* CONFIG_PM */
 
