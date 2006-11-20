Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966452AbWKTTSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966452AbWKTTSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966456AbWKTTSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:18:35 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:20117 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S966452AbWKTTSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:18:34 -0500
Date: Mon, 20 Nov 2006 14:18:33 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       <linux1394-devel@lists.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
In-Reply-To: <200611192241.30740.dtor@insightbb.com>
Message-ID: <Pine.LNX.4.44L0.0611201415000.7569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Dmitry Torokhov wrote:

> I was actually looking at the driver core recently and was surprised that
> USB crapped all over it with its locking requirements. I don't think its a
> good idea to enforce one subsystem's lcoking rules onto everyone.

I agree.  The only reason for doing it that way was I couldn't think of 
any other approach.

> Would there be alot of objections if we add bus->[un]lock_device() and
> hide all uglies there? If methods are not set when bus is registered then
> standard dev->sem lock/unlock will be used.

That's a little too simple to work.  You can see from examining the 
existing code in bus.c and dd.c; there are places where the device needs 
to be locked but not the parent, places where the parent needs to be 
locked but not the device, and places where both need to be locked.

A slightly different way to accomplish much the same thing might be to
have a per-bus parent_needs_to_be_locked flag (or method).  It wouldn't be 
quite as elegant, though.

Alan Stern

