Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWBZUkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWBZUkn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBZUkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:40:43 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:23437 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751080AbWBZUkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:40:42 -0500
Date: Sun, 26 Feb 2006 21:39:41 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Message-ID: <20060226203941.GA5783@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <200602250527.03493.ak@suse.de> <20060225125326.GJ3674@stusta.de> <20060225132820.GA13413@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225132820.GA13413@isilmar.linta.de>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.241.246
Subject: Re: Status of X86_P4_CLOCKMOD?
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at, Dominik Brodowski wrote:
> On Sat, Feb 25, 2006 at 01:53:26PM +0100, Adrian Bunk wrote:
> > > > Doesn't less heat imply less power consumption?
> > > 
> > > Not in this case no.
> > >...
> > 
> > Sorry for the dumb question, but how could this work physically?
> > 
> > If a computer produces less heat with the same power consumption, what 
> > happens with the other energy?
> 
> No. Let's do the math (again), and (again) for the actual values of an Intel
> Pentium(R) M Processor, 1400 MHz @ 1.484 V, even though the same rules of
> physics, logic and mathematics apply to _all_ processors.

Do you have the numbers for a Pentium(R) 4 HT? (I couldn't find
anything substantial with google.) Especially C2 vs. C2 + throttling?
Because the way I remember having read somewhere, the idle
(C2) power consumption of the P4 is significantly higher
than with the Pentium(R) M.

> Power consumption in idle state C2 (Stop-Grant state)	 7.3 W
> Power consumption when "skipping instructions"
> 	because of throttling (Stop-Grant state)	 7.3 W
> 
> Power consumption when doing work			22.0 W
> 
> 
> This means that if the processor idle percentage is _larger_ than (1 -
> throttling rate), throttling has no effect at all.

On a Pentium(R) M, but how about P4? The two have very different
architectures, don't they?

> Now, let's assume there is some work for the CPU to do which keeps it busy
> for one second @ 1.4 GHz. How much energy is needed to get this work done?
> 
> 0% throttling:		22 Ws	(1s)
> 25% throttling:		24 Ws	(1.3s)
> 50% throttling:		29 Ws	(2s)
> 75% throttling:		44 Ws	(4s)
> 
> 
> Now let's also assume there is nothing else to do during a span of four
> seconds: then, independent of the throttling setting, the CPU power
> consumption is 44 Ws for these four seconds.
> 
> 
> However: for the 75% throttling state, the CPU only produces 11 W of heat
> _all the time_ -- this means, the fan or air conditioning must only consider
> 11 W. For 0%, the CPU may produce 44 W of heat in a second -- and to cool
> that sufficiently, the fan _may_ need to run faster, which consumes more
> energy than is saved by only having to cool 7.3 W (instead of 11W) the other
> three seconds.

This is all fine, but why would anyone use throttling when the
CPU has work to do (except for thermal emergency throttling)?

> So: P4-clockmod style throttling only makes sense if either
> 
> a) the idle handler does not enter the Stop-Grant state (C2) efficiently, or
> 
> b) the load varies significantly over time in a manner which has effect on
>    the fan, and where the latency induced by throttling doesn't matter.

Maybe my previous mails were not clear enough: The goal is to
reduce idle power consumption (and by that fan noise). The PC
is running but is idle, e.g just listening for possible incoming
jabber messages or whatever.

When I experimented with P4-clockmod some time ago, I observed
that the fan noise was reduced when I left the box run idle
with clockmod set to maximum throttling. I thought this was
a good thing.

Anyway, 2.6.16-rc4 p4-clockmod driver doesn't work with my CPU
anymore (booted with cpufreq.debug=7):

CPU: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
Checking 'hlt' instruction... OK.
...
cpufreq-core: trying to register driver p4-clockmod
cpufreq-core: adding CPU 0
p4-clockmod: has errata -- disabling frequencies lower than 2ghz
speedstep-lib: x86: f, model: 2
speedstep-lib: ebx value is 9, x86_mask is 9
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xd12000d 0x0
speedstep-lib: P4 - FSB 200000 kHz; Multiplier 13; Speed 2600000 kHz
freq-table: setting show_table for cpu 0 to b04be620
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1 is invalid, skipping
freq-table: table entry 2 is invalid, skipping
freq-table: table entry 3 is invalid, skipping
freq-table: table entry 4 is invalid, skipping
freq-table: table entry 5 is invalid, skipping
freq-table: table entry 6 is invalid, skipping
freq-table: table entry 7 is invalid, skipping
freq-table: table entry 8 is invalid, skipping
cpufreq-core: initialization failed
cpufreq-core: no CPU initialized for driver p4-clockmod
cpufreq-core: unregistering CPU 0


Johannes
