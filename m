Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVBCLCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVBCLCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVBCLCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:02:14 -0500
Received: from gprs214-42.eurotel.cz ([160.218.214.42]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262447AbVBCK7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:59:03 -0500
Date: Thu, 3 Feb 2005 11:58:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203105846.GA1360@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl> <20050202133153.GD29579@elf.ucw.cz> <200502030108.09508.rjw@sisk.pl> <20050203104126.GC1389@elf.ucw.cz> <20050203105647.GA17526@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203105647.GA17526@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Thu, Feb 03, 2005 at 11:41:26AM +0100, Pavel Machek wrote:
> > Okay, you are right, restoring it unconditionaly would be bad
> > idea. Still it would be nice to tell cpufreq governor "please change
> > the frequency ASAP" so it does not run at 800MHz for half an hour
> > compiling kernels on AC power.
> 
> It already does that... or at least it should. in cpufreq_resume() there is
> a call to schedule_work(&cpu_policy->update); which will cause a call
> cpufreq_update_policy() in due course. And cpufreq_update_policy() calls the
> governor, and it is supposed to adjust the frequency to the user's wish
> then.

Ok, so Rafael's suspend() routine seems like good fix... Please
apply...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
