Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbVBCOYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbVBCOYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbVBCOWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:22:43 -0500
Received: from gprs214-99.eurotel.cz ([160.218.214.99]:62133 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263553AbVBCOVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:21:25 -0500
Date: Thu, 3 Feb 2005 15:20:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203142057.GA1402@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl> <20050203105846.GA1360@elf.ucw.cz> <20050203110155.GA17576@isilmar.linta.de> <200502031230.20302.rjw@sisk.pl> <20050203124006.GA18142@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203124006.GA18142@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > On Thu, Feb 03, 2005 at 11:41:26AM +0100, Pavel Machek wrote:
> > > > > > Okay, you are right, restoring it unconditionaly would be bad
> > > > > > idea. Still it would be nice to tell cpufreq governor "please change
> > > > > > the frequency ASAP" so it does not run at 800MHz for half an hour
> > > > > > compiling kernels on AC power.
> > > > > 
> > > > > It already does that... or at least it should. in cpufreq_resume() there is
> > > > > a call to schedule_work(&cpu_policy->update); which will cause a call
> > > > > cpufreq_update_policy() in due course. And cpufreq_update_policy() calls the
> > > > > governor, and it is supposed to adjust the frequency to the user's wish
> > > > > then.
> > > > 
> > > > Ok, so Rafael's suspend() routine seems like good fix...
> > > 
> > > No. I don't see a reason why my desktop P4 should drop to 12.5 frequency
> > > (p4-clockmod) if I ask it to suspend to mem.
> > 
> > So, would it be acceptable to check in _suspend() if the state is S4
> > and drop the frequency in that case or do nothing otherwise?
> 
> No. The point is that this is _very_ system-specific. Some systems resume
> always at full speed, some always at low speed; for S4 the behaviour may be
> completely unpredictable. And in fact I wouldn't want my desktop P4 drop th
> 12.5 % frequency if I ask it to suspend to disk, too. "Ignoring" the warning
> seems to be the best thing to me. The good thing is, after all, that cpufreq
> detected this situation and tries to correct for it.

You may not run k8 notebook on max frequency on battery. Your system
will crash; and you might even damage battery.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
