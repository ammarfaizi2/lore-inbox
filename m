Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWB1U6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWB1U6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWB1U6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:58:04 -0500
Received: from isilmar.linta.de ([213.239.214.66]:25037 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932488AbWB1U6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:58:02 -0500
Date: Tue, 28 Feb 2006 21:57:58 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060228205758.GA16268@isilmar.linta.de>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060228194628.GP4650@waste.org> <20060228200916.GA326@redhat.com> <20060228204720.GD13116@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228204720.GD13116@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 02:47:20PM -0600, Matt Mackall wrote:
> On Tue, Feb 28, 2006 at 03:09:16PM -0500, Dave Jones wrote:
> > On Tue, Feb 28, 2006 at 01:46:29PM -0600, Matt Mackall wrote:
> >  > On Thu, Feb 23, 2006 at 03:41:10PM -0500, Dave Jones wrote:
> >  > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> >  > > 
> >  > >  > > > >  config X86_P4_CLOCKMOD
> >  > >  > > > > 	depends on EMBEDDED
> >  > >  > > > 
> >  > >  > > > This one is an x86_64 only issue, and yes, it's wrong.
> >  > >  > > 
> >  > >  > > That's for P4, not X86_64... And since P4 clock modulation does not provide
> >  > >  > > almost any energy savings it was "hidden" under embedded.
> >  > >  > 
> >  > >  > But the EMBEDDED dependency is only on x86_64:
> >  > >  > 
> >  > >  > arch/i386/kernel/cpu/cpufreq/Kconfig:
> >  > >  > config X86_P4_CLOCKMOD
> >  > >  >         tristate "Intel Pentium 4 clock modulation"
> >  > >  >         select CPU_FREQ_TABLE
> >  > >  >         help
> >  > >  > 
> >  > >  > arch/x86_64/kernel/cpufreq/Kconfig:
> >  > >  > config X86_P4_CLOCKMOD
> >  > >  >         tristate "Intel Pentium 4 clock modulation"
> >  > >  >         depends on EMBEDDED
> >  > >  >         help
> >  > >  > 
> >  > >  > And if the option is mostly useless, what is it good for?
> >  > > 
> >  > > It's sometimes useful in cases where the target CPU doesn't have any better
> >  > > option (Speedstep/Powernow).  The big misconception is that it
> >  > > somehow saves power & increases battery life. Not so.
> >  > > All it does is 'not do work so often'.  The upside of this is
> >  > > that in some situations, we generate less heat this way.
> >  > 
> >  > This is perplexing. Less heat equals less power usage according to the
> >  > laws of thermodynamics.
> > 
> > you end up taking longer to do the same amount of work, so you
> > end up using the same overall power.
> 
> Doesn't make sense.
> 
> Power is energy consumption per unit time. Heat is energy dissipated
> per unit time (both are measured in watts). So if you're saying "we
> use the same amount of power", then conservation of energy implies "we
> generate the same amount of heat." If you're instead saying "we use
> the same amount of energy over a longer span of time", that means "we
> draw less power from the battery" which means "battery lasts longer".

So even if the battery lasts longer, you don't have anything of it, 'cause
the CPU can even compute _less_ in this longer time-span. Remember that
idling doesn't count...

> In short, power usage and heat production are _the same thing_.

Yes and no. The heat production is more levelled if you use throttling, so
the temperature achieved is lesser, which might cause fans not having to
start or air conditioning having less work to do.

	Dominik
