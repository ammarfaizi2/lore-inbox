Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLZWGF>; Thu, 26 Dec 2002 17:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLZWGF>; Thu, 26 Dec 2002 17:06:05 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:50366 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264646AbSLZWFD>; Thu, 26 Dec 2002 17:05:03 -0500
Date: Thu, 26 Dec 2002 23:07:10 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5] cpufreq: minor cleanups
Message-ID: <20021226220710.GA1125@brodo.de>
References: <20021221202509.GA2503@brodo.de> <20021222212559.GA24443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021222212559.GA24443@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 10:25:59PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Get rid of CPUFREQ_ALL_CPUS codepaths not used anymore.
> 
> Get rid of? Seems you are adding it.

Only in cpufreq_set(). If that is called with cpu==CPUFREQ_ALL_CPUS, this
value can't be passed to cpufreq_set_policy any more. So the
cpufreq_set_policy call needs to be iterated over all cpus. The reason for
this is that on some architectures, not all CPUs support the same frequency
ranges.
In all other instances, CPUFREQ_ALL_CPUS is removed by that patch you're
commenting on; will re-send it soon for 2.5.53.

	Dominik

> > -	return cpufreq_set_policy(&policy);
> > +	if (policy.cpu == CPUFREQ_ALL_CPUS)
> > +	{
> > +		unsigned int i;
> > +		unsigned int ret = 0;
> > +		for (i=0; i<NR_CPUS; i++) 
> > +		{
> > +			policy.cpu = i;
> > +			if (cpu_online(i))
> > +				ret |= cpufreq_set_policy(&policy);
> > +		}
> > +		return ret;
> > +	} 
> > +	else
> > +		return cpufreq_set_policy(&policy);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_set);
> >  
