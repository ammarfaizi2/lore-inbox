Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVBCVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVBCVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVBCVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:49:24 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:5078 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263180AbVBCVpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:45:46 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Date: Thu, 3 Feb 2005 22:46:12 +0100
User-Agent: KMail/1.7.1
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <20050203124006.GA18142@isilmar.linta.de> <20050203142057.GA1402@elf.ucw.cz>
In-Reply-To: <20050203142057.GA1402@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032246.13057.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 3 of February 2005 15:20, Pavel Machek wrote:
> Hi!
> 
> > > > > > On Thu, Feb 03, 2005 at 11:41:26AM +0100, Pavel Machek wrote:
> > > > > > > Okay, you are right, restoring it unconditionaly would be bad
> > > > > > > idea. Still it would be nice to tell cpufreq governor "please change
> > > > > > > the frequency ASAP" so it does not run at 800MHz for half an hour
> > > > > > > compiling kernels on AC power.
> > > > > > 
> > > > > > It already does that... or at least it should. in cpufreq_resume() there is
> > > > > > a call to schedule_work(&cpu_policy->update); which will cause a call
> > > > > > cpufreq_update_policy() in due course. And cpufreq_update_policy() calls the
> > > > > > governor, and it is supposed to adjust the frequency to the user's wish
> > > > > > then.
> > > > > 
> > > > > Ok, so Rafael's suspend() routine seems like good fix...
> > > > 
> > > > No. I don't see a reason why my desktop P4 should drop to 12.5 frequency
> > > > (p4-clockmod) if I ask it to suspend to mem.
> > > 
> > > So, would it be acceptable to check in _suspend() if the state is S4
> > > and drop the frequency in that case or do nothing otherwise?
> > 
> > No. The point is that this is _very_ system-specific. Some systems resume
> > always at full speed, some always at low speed; for S4 the behaviour may be
> > completely unpredictable. And in fact I wouldn't want my desktop P4 drop th
> > 12.5 % frequency if I ask it to suspend to disk, too. "Ignoring" the warning
> > seems to be the best thing to me. The good thing is, after all, that cpufreq
> > detected this situation and tries to correct for it.
> 
> You may not run k8 notebook on max frequency on battery. Your system
> will crash; and you might even damage battery.

When I don't compile in cpufreq, it seems to run at 1,8 GHz (the max)
all the time, on AC power as well as on battery.  Along with what you're
saying it leads to the conclusion that in fact I have to compile in cpufreq
or I can damage the battery otherwise.  Is that right?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
