Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWBWUmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWBWUmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWBWUmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:42:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751345AbWBWUmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:42:37 -0500
Date: Thu, 23 Feb 2006 15:41:10 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060223204110.GE6213@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	cpufreq@lists.linux.org.uk, ak@suse.de
References: <20060214152218.GI10701@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de> <200602212220.05642.dtor_core@ameritech.net> <20060223195937.GA5087@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223195937.GA5087@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:

 > > > >  config X86_P4_CLOCKMOD
 > > > > 	depends on EMBEDDED
 > > > 
 > > > This one is an x86_64 only issue, and yes, it's wrong.
 > > 
 > > That's for P4, not X86_64... And since P4 clock modulation does not provide
 > > almost any energy savings it was "hidden" under embedded.
 > 
 > But the EMBEDDED dependency is only on x86_64:
 > 
 > arch/i386/kernel/cpu/cpufreq/Kconfig:
 > config X86_P4_CLOCKMOD
 >         tristate "Intel Pentium 4 clock modulation"
 >         select CPU_FREQ_TABLE
 >         help
 > 
 > arch/x86_64/kernel/cpufreq/Kconfig:
 > config X86_P4_CLOCKMOD
 >         tristate "Intel Pentium 4 clock modulation"
 >         depends on EMBEDDED
 >         help
 > 
 > And if the option is mostly useless, what is it good for?

It's sometimes useful in cases where the target CPU doesn't have any better
option (Speedstep/Powernow).  The big misconception is that it
somehow saves power & increases battery life. Not so.
All it does is 'not do work so often'.  The upside of this is
that in some situations, we generate less heat this way.

It's really of limited practical use, but occasionally, we find
some users that do find it handy.  (One case I heard was someone
with a server farm that generated lots of heat, but at nighttime,
he could throttle that back, which resulted in a drop in overall
temperature in the serverroom -- no numbers to back it up though,
just anecdotes).  

As to the difference of EMBEDDED.. on 32bit, there's a lot more
systems without speedstep/powernow, so it makes more sense to
make it more widely available.  Nearly all AMD64/EM64T have 
some form of speed-scaling which is more effective than p4-clockmod,
which is why I assume it's set that way.

Andi can probably confirm the thinking on that one, as I think
he added it when x86-64 first started supporting cpufreq.

		Dave

