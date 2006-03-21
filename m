Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWCUWFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWCUWFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWCUWFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:05:45 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:18366
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S1751801AbWCUWFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:05:44 -0500
Subject: Re: p4-clockmod not working in 2.6.16
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321220115.GA8583@redhat.com>
References: <1142974528.3470.4.camel@localhost>
	 <20060321210106.GA25370@redhat.com> <1142978230.3470.12.camel@localhost>
	 <20060321220115.GA8583@redhat.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 23:08:59 +0100
Message-Id: <1142978939.3470.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 17:01 -0500, Dave Jones wrote:
> On Tue, Mar 21, 2006 at 10:57:10PM +0100, Sasa Ostrouska wrote:
> 
>  > Hi Dave, here it is, this is on a Sony Vaio PCG-GRT816S laptop:
>  > CPU0: Temperature above threshold
>  > CPU0: Running in modulated clock mode
>  > .. ad infinitum ..
> 
> *yowch*.  Are you running that CPU fanless or something?
> 

No, but laptop is on the table :( I get many times this messages, also 
I'm compilling at the moment. But in any case also with normal use the 
fan is very active.

> Does the patch below help?
> 
> 		Dave
> 
> 
> Fix the code to disable freqs less than 2GHz in N60 errata.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> Index: linux-2.6.15/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> ===================================================================
> --- linux-2.6.15.orig/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> +++ linux-2.6.15/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> @@ -244,7 +244,7 @@ static int cpufreq_p4_cpu_init(struct cp
>  	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
>  		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
>  			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
> -		else if (has_N60_errata[policy->cpu] && p4clockmod_table[i].frequency < 2000000)
> +		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)
>  			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
>  		else
>  			p4clockmod_table[i].frequency = (stock_freq * i)/8;
> 

Let me try the patch and I will report.
Many thanks and best regards
Sasa Ostrouska


