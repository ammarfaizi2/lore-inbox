Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUCPKJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbUCPKJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:09:39 -0500
Received: from gprs214-17.eurotel.cz ([160.218.214.17]:59267 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263869AbUCPKJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:09:37 -0500
Date: Tue, 16 Mar 2004 11:09:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with swsusp vs. pmdisk
Message-ID: <20040316100925.GA2177@elf.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz> <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston> <20040313123620.GA3352@openzaurus.ucw.cz> <1079223482.1960.113.camel@gaston> <20040314003717.GI549@elf.ucw.cz> <1079381114.5349.62.camel@calvin.wpcb.org.au> <1079395292.2302.191.camel@gaston> <1079393514.2043.10.camel@calvin.wpcb.org.au> <1079401255.1967.217.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079401255.1967.217.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > - Freezer hooks (I can easily get suspend2 working with the old freezer
> > > > until people are convinced it's not up to the task). This accounts for
> > > > the vast majority of those file changes.
> > > 
> > > It would be nice if you did that as a first step indeed. I'm personally
> > > not convinced of the usefullness of having a freezer at all ;)
> > 
> > Without a freezer, how would you ensure that other processes don't mess
> > up your memory state while you're saving/reloading the image?
> 
> Hrm, you are not protecting about "asynchronous" (interrupt based)
> activity anyway... I'm not sure how the IO sceduler may kill us
> and whatever doing things based on a timer that doesn't have a
> device-driver underneath getting the PM callbacks.
> 
> As far as suspend-to-disk is concerned, I agree we need a state
> snapshot, then we need to be able to play with drivers to save that
> state without having userland get in the way, so yup, we need a
> freezer. I think we don't need it for suspend-to-ram though.

You are right, freezer should not be needed for s-to-ram. I wanted to
keep it consistent with s-to-disk, and maybe make locking a bit easier
for drivers.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
