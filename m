Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCaTI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCaTI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVCaTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:08:25 -0500
Received: from digitalimplant.org ([64.62.235.95]:60062 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261639AbVCaTIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:08:18 -0500
Date: Thu, 31 Mar 2005 11:08:10 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: David Brownell <david-b@pacbell.net>
cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <200503311046.55805.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.50.0503311054330.7249-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503311054410.1510-100000@ida.rowland.org>
 <200503311018.02135.david-b@pacbell.net> <Pine.LNX.4.50.0503311021040.7249-100000@monsoon.he.net>
 <200503311046.55805.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, David Brownell wrote:

> On Thursday 31 March 2005 10:26 am, Patrick Mochel wrote:

> > Conversely, we only want to automatically suspend the device, or allow the
> > device to be explicitly put to sleep, if the device is not being used.
>
> And be able to suspend itself, even if it's open, if it's idle enough and
> can wake itself up automatically.

Certainly that's dependent on the type of device. It'll be relatively easy
to begin with devices at an open()/close() level, and consider any device
that's open() to be active and ineligible for suspend. This will allow us
to setup the infrastructure and get some decent savings from definitely
inactive devices.

We then move to a more fine-grained activity-detection and reaction
mechanism, like being idle after N seconds of inactivity. But, that will
be completely dependent on the type of device and the driver.

In fact with a usage counter, a driver that wants to be more intelligent
about how much it's being used can simply use that (decrement it and
automatically suspend) when it's inactive for a while.

Right?


	Pat
