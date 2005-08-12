Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVHLNsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVHLNsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVHLNso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:48:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60604 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751181AbVHLNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:48:44 -0400
Date: Fri, 12 Aug 2005 09:48:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
In-Reply-To: <d120d50005081113294dbb4961@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0508120942180.4754-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Dmitry Torokhov wrote:

> Hmm, so what do I do in the following scenario - I have a serio port
> (AUX) that has a synaptics touchpad bound to it which is driven by
> psmouse driver. psmouse driver registers a child port (synaptics
> pass-through) during probe call. The child port is also driven by
> psmouse module - but it looks like it will deadlock when binding.

Dmitry's point is well founded.  Greg, I want to retract that klist patch 
(as536).  I'll send in a revised version before long.

It looks like the best approach will simply be to eliminate the driver's
list of bound devices altogether.  That should make Christoph happy -- no
klist, no list, no nothing!  :-)  The list hardly ever gets used, mainly
when the driver is unloaded.  We can already get the same effect by
iterating over the bus's list of devices and skipping everything not bound
to the driver.

This will eliminate a whole set of races and make the code more 
transparent (I hope).

Alan Stern

