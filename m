Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWB1V0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWB1V0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWB1V0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:26:41 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:63148
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932645AbWB1V0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:26:40 -0500
Date: Tue, 28 Feb 2006 15:26:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060228212632.GE13116@waste.org>
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com> <20060228194628.GP4650@waste.org> <20060228200916.GA326@redhat.com> <20060228204720.GD13116@waste.org> <20060228205758.GA16268@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228205758.GA16268@isilmar.linta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 09:57:58PM +0100, Dominik Brodowski wrote:
> On Tue, Feb 28, 2006 at 02:47:20PM -0600, Matt Mackall wrote:
> > On Tue, Feb 28, 2006 at 03:09:16PM -0500, Dave Jones wrote:
> > > On Tue, Feb 28, 2006 at 01:46:29PM -0600, Matt Mackall wrote:
> > >  > On Thu, Feb 23, 2006 at 03:41:10PM -0500, Dave Jones wrote:
> > >  > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> > >  > > 
> > >  > >  > > > >  config X86_P4_CLOCKMOD
> > >  > >  > > > > 	depends on EMBEDDED
> > >  > >  > > > 
> > >  > >  > > > This one is an x86_64 only issue, and yes, it's wrong.
> > >  > >  > > 
> > >  > >  > > That's for P4, not X86_64... And since P4 clock modulation does not provide
> > >  > >  > > almost any energy savings it was "hidden" under embedded.
> > >  > >  > 
> > >  > >  > But the EMBEDDED dependency is only on x86_64:
> > >  > >  > 
> > >  > >  > arch/i386/kernel/cpu/cpufreq/Kconfig:
> > >  > >  > config X86_P4_CLOCKMOD
> > >  > >  >         tristate "Intel Pentium 4 clock modulation"
> > >  > >  >         select CPU_FREQ_TABLE
> > >  > >  >         help
> > >  > >  > 
> > >  > >  > arch/x86_64/kernel/cpufreq/Kconfig:
> > >  > >  > config X86_P4_CLOCKMOD
> > >  > >  >         tristate "Intel Pentium 4 clock modulation"
> > >  > >  >         depends on EMBEDDED
> > >  > >  >         help
> > >  > >  > 
> > >  > >  > And if the option is mostly useless, what is it good for?
> > >  > > 
> > >  > > It's sometimes useful in cases where the target CPU doesn't have any better
> > >  > > option (Speedstep/Powernow).  The big misconception is that it
> > >  > > somehow saves power & increases battery life. Not so.
> > >  > > All it does is 'not do work so often'.  The upside of this is
> > >  > > that in some situations, we generate less heat this way.
> > >  > 
> > >  > This is perplexing. Less heat equals less power usage according to the
> > >  > laws of thermodynamics.
> > > 
> > > you end up taking longer to do the same amount of work, so you
> > > end up using the same overall power.
> > 
> > Doesn't make sense.
> > 
> > Power is energy consumption per unit time. Heat is energy dissipated
> > per unit time (both are measured in watts). So if you're saying "we
> > use the same amount of power", then conservation of energy implies "we
> > generate the same amount of heat." If you're instead saying "we use
> > the same amount of energy over a longer span of time", that means "we
> > draw less power from the battery" which means "battery lasts longer".
> 
> So even if the battery lasts longer, you don't have anything of it, 'cause
> the CPU can even compute _less_ in this longer time-span. Remember that
> idling doesn't count...

Which is different from other power-saving modes how? If it means I
can read my email longer on the plane, it's a power-saving mode.
 
> > In short, power usage and heat production are _the same thing_.
> 
> Yes and no. The heat production is more levelled if you use throttling, so
> the temperature achieved is lesser, which might cause fans not having to
> start or air conditioning having less work to do.

The time scale for heat propagation is enough slower than throttling
that I'd expect this difference to amount to approximately nil. It
takes many seconds for heat to propagate from a core to a thermal
sensor inside a laptop, and the intervening material (silicon,
ceramic, plastic, aluminum, air) acts as a low-pass filter so usage
spikes on sub-second scales are simply not visible. In other words,
the temperature will be the same for the same energy consumption
averaged over the time it takes for the heat to propagate.

And the time for a usage spike to be visible to a server room air
conditioner is probably closer to a ten minute time frame.

-- 
Mathematics is the supreme nostalgia of our time.
