Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbVBCXPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVBCXPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVBCXPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:15:34 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:4825 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261389AbVBCXO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:14:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Date: Fri, 4 Feb 2005 00:15:22 +0100
User-Agent: KMail/1.7.1
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <200502031420.37560.rjw@sisk.pl> <20050203142203.GB1402@elf.ucw.cz>
In-Reply-To: <20050203142203.GB1402@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040015.22457.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 3 of February 2005 15:22, Pavel Machek wrote:
> Hi!
> 
> > > > So, would it be acceptable to check in _suspend() if the state is S4
> > > > and drop the frequency in that case or do nothing otherwise?
> > > 
> > > No. The point is that this is _very_ system-specific. Some systems resume
> > > always at full speed, some always at low speed; for S4 the behaviour may be
> > > completely unpredictable. And in fact I wouldn't want my desktop P4 drop th
> > > 12.5 % frequency if I ask it to suspend to disk, too. "Ignoring" the warning
> > > seems to be the best thing to me. The good thing is, after all, that cpufreq
> > > detected this situation and tries to correct for it.
> > 
> > Well, the warning is not a big problem, as far as I'm concerned.  The problem is
> > that the box often reboots when it's woken up on batteries and this certainly
> > is related to cpufreq (ie it does not happen if cpufreq is not compiled in).
> > 
> > Pavel has suggested that it may happen when the frequency of
> > the CPU is too high on resume, so I'm trying to verify if this is the case.  If so,
> > which I'm not entirely convinced about yet, I'll be going to provide a fix
> > for it, but I wouldn't like to do anything that's not acceptable from the
> > start.
> 
> Well, try to force your machine to 2GHz while it is on battery. If it
> crashes, you have verified it is indeed the problem. [Insert standard
> disclaimer about exploding batteries here.]

Instead of trying to blow up the battery I used the patch that forces the CPU
to 800 MHz and it apparently survives resuming on batteries - at least 3
times out of 3 attempts (I'll try some times more tomorrow).

It seems to boot at 1800 MHz, though, every time, according to
cpufreq_resume().


> > I'm currently thinking that the proper approach may be to add a ->suspend()
> > routine to struct cpufreq_driver and call the driver-specific ->suspend()
> > (if one is defined) from cpufreq_suspend().  Then, it'll be possible to do
> > whatever-is-necessary on a per-driver basis.  Just a thought. :-)
> 
> Yes, that seems like right solution.

Then I'll try to do something along this line.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
