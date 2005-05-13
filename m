Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVEMBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVEMBIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVEMBFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:05:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41739 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262209AbVEMArj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:39 -0400
Date: Fri, 13 May 2005 02:47:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       cpufreq@lists.linux.org.uk
Subject: [-mm patch] drivers/cpufreq/cpufreq_conservative.c: make cpufreq_gov_dbs static
Message-ID: <20050513004737.GV3603@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc3-mm3:
>...
> +cpufreq-CPUFREQ-13-static-cpufreq_gov_dbs.patch
>...

This is my patch to make the needlessly global and EXPORT_SYMBOL'ed 
cpufreq_gov_dbs in cpufreq_ondemand.c static.

> +cpufreq-CPUFREQ-16-conservative-governer.patch
>...

This patch adds a needlessly global and EXPORT_SYMBOL'ed 
cpufreq_gov_dbs in cpufreq_conservative.c .

Patch below...

>  Additions to cpufreq tree
>...

cu
Adrian


<--  snip  -->



This patch makes a needlessly global and EXPORT_SYMBOL'ed struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm1-full/drivers/cpufreq/cpufreq_conservative.c.old	2005-05-13 01:42:33.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/drivers/cpufreq/cpufreq_conservative.c	2005-05-13 01:42:51.000000000 +0200
@@ -583,12 +583,11 @@
 	return 0;
 }
 
-struct cpufreq_governor cpufreq_gov_dbs = {
+static struct cpufreq_governor cpufreq_gov_dbs = {
 	.name		= "conservative",
 	.governor	= cpufreq_governor_dbs,
 	.owner		= THIS_MODULE,
 };
-EXPORT_SYMBOL(cpufreq_gov_dbs);
 
 static int __init cpufreq_gov_dbs_init(void)
 {

