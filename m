Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbUCPBwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCPBt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:49:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:47581 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263417AbUCPBqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:46:55 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1079393514.2043.10.camel@calvin.wpcb.org.au>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
	 <20040313123620.GA3352@openzaurus.ucw.cz>
	 <1079223482.1960.113.camel@gaston>  <20040314003717.GI549@elf.ucw.cz>
	 <1079381114.5349.62.camel@calvin.wpcb.org.au>
	 <1079395292.2302.191.camel@gaston>
	 <1079393514.2043.10.camel@calvin.wpcb.org.au>
Content-Type: text/plain
Message-Id: <1079401255.1967.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 12:40:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 10:31, Nigel Cunningham wrote:
> Hi.
> 
> On Tue, 2004-03-16 at 13:01, Benjamin Herrenschmidt wrote:
> > > - Freezer hooks (I can easily get suspend2 working with the old freezer
> > > until people are convinced it's not up to the task). This accounts for
> > > the vast majority of those file changes.
> > 
> > It would be nice if you did that as a first step indeed. I'm personally
> > not convinced of the usefullness of having a freezer at all ;)
> 
> Without a freezer, how would you ensure that other processes don't mess
> up your memory state while you're saving/reloading the image?

Hrm, you are not protecting about "asynchronous" (interrupt based)
activity anyway... I'm not sure how the IO sceduler may kill us
and whatever doing things based on a timer that doesn't have a
device-driver underneath getting the PM callbacks.

As far as suspend-to-disk is concerned, I agree we need a state
snapshot, then we need to be able to play with drivers to save that
state without having userland get in the way, so yup, we need a
freezer. I think we don't need it for suspend-to-ram though.

> > Some of the "guard" code you added to the filesystem is scary too..
> 
> It's really just paranoia, particularly for where swapfiles are in use.
> While developing the swapfile support, I had a couple of occasions where
> I messed up my superblock because of a bug. I'm very confident now that
> the suspend code itself is stable and mature, but since the device
> drivers aren't there, I'd rather not remove the safety nets just yet.

Ok.

Ben.


