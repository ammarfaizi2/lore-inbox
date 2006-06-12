Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWFLWZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWFLWZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWFLWZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:25:38 -0400
Received: from mail.suse.de ([195.135.220.2]:40385 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932119AbWFLWZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:25:37 -0400
Date: Mon, 12 Jun 2006 15:23:04 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
Message-ID: <20060612222304.GA21459@suse.de>
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <20060612220321.GA19792@suse.de> <448DE6EA.8020708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DE6EA.8020708@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 06:12:58PM -0400, Mark Lord wrote:
> Greg KH wrote:
> >On Mon, Jun 12, 2006 at 05:54:21PM -0400, Mark Lord wrote:
> >>Okay, with these two patches from -mm, the USB no longer dies
> >>when I plug in my hub/dock device:
> >>
> >>gregkh-usb-improved-tt-scheduling-for-ehci.patch
> >>gregkh-usb-usb-rmmod-pl2303-after-28.patch
> >>
> >>So let's get these pushed upstream sooner than later, please!
> >
> >It will happen after 2.6.17 is out, as they are in the queue to do so.
> 
> 2.6.18 will do, I suppose.
> 
> But has the *real* bug been fixed with these patches,
> or merely "avoided" ?

The tt-scheduling patch should have fixed the "real" bug.

> Eg. If usb_submit_urb() ever fails again (low on memory, etc..)
> inside  pl2303_open(), will we be back with the same bug?
> 
> What's the *real* actual bug here?

There are two of them.

The fact that the urb submission in the pl2303 driver fails, and is now
handled properly is fixed in the pl2303 patch.

The fact that we can (hopefully) handle scheduling TT in the EHCI driver
fixes the real problem with plugging slow or full speed devices into a
USB 2.0 hub (not root hub).  That's fixed by the tt patch.

So we should have finally covered both of them now.

thanks,

greg k-h
