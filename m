Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267812AbUHJXLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267812AbUHJXLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUHJXLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:11:05 -0400
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267812AbUHJXLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:11:00 -0400
Date: Wed, 11 Aug 2004 01:10:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810231042.GA2287@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net> <20040810100751.GC9034@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net> <20040810175637.GB28113@elf.ucw.cz> <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I still do not see it... swsusp does not care about logical state of
> > device. (Actually manipulating logical state of device might make
> > swsusp less transparent). It cares about device not doing DMA (I also
> > said "no interrupts", but that is not strictly neccessary: we disable
> > interrupts for atomic copy. Device should do no NMIs, through).
> 
> Perhaps it is unncessary to do at a class level, at least at this point.
> I think we all agree that we need some sort of stop/start methods for
> devices, though. In which, we can add to struct bus_type:
> 
> 	int (*dev_stop)(struct device *);
> 	int (*dev_start)(struct device *);
> 
> Sound good?

I fail to see why dev_stop(device) is better than suspend(device,
PM_PLEASE_QUIESCE_OR_WHATEVER). It has one big advantage: drivers that
ignore second argument (most do) will automagically work.

There is no fundamental problem with dev_stop/dev_start, I just fail
to see why they need to be separate from suspend/resume.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
