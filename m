Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVALUyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVALUyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVALUtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:49:43 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:44172 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261437AbVALUqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:46:08 -0500
Date: Wed, 12 Jan 2005 21:45:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Message-ID: <20050112204550.GD1408@elf.ucw.cz>
References: <200501112220.53011.rjw@sisk.pl> <200501112233.01113.rjw@sisk.pl> <20050111215537.GE1802@elf.ucw.cz> <200501121824.05848.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501121824.05848.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Forcing machine to 800MHz before suspend may do the trick, too.
> > > 
> > > How can I do this?
> > 
> > echo "0%44%44%powersave" > /proc/cpufreq if you have that interface
> > enabled. Or simply turn off CONFIG_CPUFREQ in config.
> 
> I turned off CONFIG_CPUFREQ and it helped.  Still, cpufreq is a neat feature 
> and I'd like to keep it in the kernel. :-)

Yes, uh, what you have to do is add suspend/resume routines to
cpufreq. Always force it to lowest frequency in
device_suspend()... and force it to rescan AC/battery status before
going to higher frequency.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
