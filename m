Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWCUWBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWCUWBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWCUWBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:01:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751794AbWCUWBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:01:23 -0500
Date: Tue, 21 Mar 2006 17:01:15 -0500
From: Dave Jones <davej@redhat.com>
To: Sasa Ostrouska <sasa.ostrouska@volja.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod not working in 2.6.16
Message-ID: <20060321220115.GA8583@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sasa Ostrouska <sasa.ostrouska@volja.net>,
	linux-kernel@vger.kernel.org
References: <1142974528.3470.4.camel@localhost> <20060321210106.GA25370@redhat.com> <1142978230.3470.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142978230.3470.12.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 10:57:10PM +0100, Sasa Ostrouska wrote:

 > Hi Dave, here it is, this is on a Sony Vaio PCG-GRT816S laptop:
 > CPU0: Temperature above threshold
 > CPU0: Running in modulated clock mode
 > .. ad infinitum ..

*yowch*.  Are you running that CPU fanless or something?

Does the patch below help?

		Dave


Fix the code to disable freqs less than 2GHz in N60 errata.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Dave Jones <davej@redhat.com>

Index: linux-2.6.15/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
===================================================================
--- linux-2.6.15.orig/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
+++ linux-2.6.15/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
@@ -244,7 +244,7 @@ static int cpufreq_p4_cpu_init(struct cp
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else if (has_N60_errata[policy->cpu] && p4clockmod_table[i].frequency < 2000000)
+		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;

-- 
http://www.codemonkey.org.uk
