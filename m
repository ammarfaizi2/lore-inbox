Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCaSrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCaSrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCaSrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:47:07 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:5517 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261609AbVCaSq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:46:59 -0500
From: David Brownell <david-b@pacbell.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: klists and struct device semaphores
Date: Thu, 31 Mar 2005 10:46:55 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org> <200503311018.02135.david-b@pacbell.net> <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311046.55805.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 10:26 am, Patrick Mochel wrote:
> 
> On Thu, 31 Mar 2005, David Brownell wrote:
> 
> > On Thursday 31 March 2005 9:59 am, Patrick Mochel wrote:
> > > On Thu, 31 Mar 2005, Alan Stern wrote:
> > > > On Wed, 30 Mar 2005, Patrick Mochel wrote:
> > >
> > > > > In fact, we probably want to add a counter to every device for all "open
> > > > > connections" so the device doesn't try to automatically sleep while a
> > > > > device node is open. Once it reaches 0, we can have it enter a
> > > > > pre-configured state, which should save us a bit of power for very little
> > > > > pain.
> > > >
> > > > By "open connections", do you mean something more than unsuspended
> > > > children?
> > >
> > > Yes, I mean anything that requires the device be awake and functional.
> >
> > So for example a device that's suspended and enabled for wakeup could be
> > "open" ... which fights against your "doesn't try to sleep" policy.
> 
> I don't understand what you mean. Even if a device is suspended, be it
> automatically after some amount of inactivity or as directed explicitly by
> a user, we want to be able to open the device and have it work.
> 
> Conversely, we only want to automatically suspend the device, or allow the
> device to be explicitly put to sleep, if the device is not being used.

And be able to suspend itself, even if it's open, if it's idle enough and
can wake itself up automatically.

I'm pointing out that device sleep/suspend states are orthogonal to being
"open".  So I don't see what this counter would do...

- Dave
