Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTH0Fun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTH0Fun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:50:43 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:47242 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263112AbTH0Fum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:50:42 -0400
Date: Wed, 27 Aug 2003 07:13:56 +0200
From: Dominik Brodowski <linux@brodo.de>
To: paul.devriendt@AMD.com
Cc: pavel@suse.cz, richard.brunner@AMD.com, aj@suse.de,
       cpufreq@www.linux.org.uk, davej@redhat.com, mark.langsdorf@AMD.com,
       linux-kernel@vger.kernel.org
Subject: Re: Cpufreq for opteron
Message-ID: <20030827051356.GA4037@brodo.de>
References: <99F2150714F93F448942F9A9F112634C080EF034@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF034@txexmtae.amd.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 07:43:37PM -0500, paul.devriendt@AMD.com wrote:
> > > +	res = find_match(&targ, &min, &max,
> > > +			 pol->policy ==
> > > +			 CPUFREQ_POLICY_POWERSAVE ? SEARCH_DOWN 
> > : SEARCH_UP, 0,
> > > +			 0);
> > 
> > Why do you check for CPUFREQ_POLICY here??? In a ->target 
> > class cpufreq
> > driver[*] you must not worry about the policy, only about min and max
> > frequency.
> > 
> > [*] ->target class cpufreq drivers [cpufreq_driver->target is 
> > used] have
> > specific operating frequencies.
> >     ->setpolicy class cpufreq drivers have operating frequency ranges
> > [currently only available on Transmeta Crusoe processors]
> 
> If the driver has to expand the range to find a matching frequency, it
> has to know whether to expand up or down. That comes from policy.

No. A ->target class cpufreq driver doesn't care about policies. It cares
about what the governor says [and "powersave" and "performance" are just 
special governors]. If a driver has to expand the range to find a matching
frequency, it has to expand _up_. See
drivers/cpufreq/freq_table.c::cpufreq_frequency_table_verify() and
section 1.3 of Documentation/cpu-freq/cpu-drivers.txt:

"You need to make sure that at least one valid frequency (or operating
range) is within policy->min and policy->max. If necessary, increase
policy->max fist, and only if this is no solution, decreas policy->min."

Rationale for this is that cpufreq tries to guarantee at least policy->min
processing power, independent of the chosen policy or governor.

> I'll look into for the next rev.

Section 2 of Documentation/cpu-freq/cpu-drivers.txt explains frequency table
helpers - maybe that helps.
 
	Dominik
