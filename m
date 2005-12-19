Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVLSOpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVLSOpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVLSOpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:45:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42163 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932091AbVLSOpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:45:17 -0500
Date: Mon, 19 Dec 2005 09:45:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
In-Reply-To: <1134962678.6162.4.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0512190942270.4946-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Benjamin Herrenschmidt wrote:

> On Sun, 2005-12-18 at 22:11 -0500, Alan Stern wrote:
> 
> > I disagree with the idea of disconnecting the device.  The right thing to 
> > do is what David wanted all along: unbind the driver.  This would require 
> > only a small change to the driver core.
> > 
> > It's too late for me to work on this now, but maybe tomorrow I'll have to 
> > a chance to write something.
> 
> Why not also disconnect the device ? That will guarantee that when
> coming back from sleep, the driver will re-discover a fresh new device
> that has properly been reset no ? Instead of a device potentially
> crashed because it didn't handle the suspend/resume transition
> properly...

I don't want to disconnect the device because there may be other drivers 
bound to other interfaces that are working just fine.  There's no need to 
mess them up.  Unbinding the misbehaving driver should be okay; it's no 
worse than doing rmmod before the suspend.

Alan Stern

