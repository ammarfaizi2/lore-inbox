Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbTLHQms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTLHQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:40:15 -0500
Received: from ida.rowland.org ([192.131.102.52]:11524 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265478AbTLHQbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:31:36 -0500
Date: Mon, 8 Dec 2003 11:31:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312081715.15359.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Duncan Sands wrote:

> On Monday 08 December 2003 17:03, David Brownell wrote:
> > Duncan Sands wrote:
> > > Hi Vince, I'm not sure, but it looks like a bug in the USB core.
> > > I was kind of expecting this :)  My patch causes devio.c to hold
> > > a reference to the usb_device maybe long after the device has
> > > been disconnected.  This is supposed to be OK, but from your
> >
> > ... no, that's not supposed to be OK.  Returning from disconnect()
> > means that a device driver is no longer referencing the interface
> > the driver bound to, or ep0.
> 
> Well, I thought Greg wanted it to be OK :)  Anyway, I don't use
> the device after disconnect except to take the semaphore
> (dev->serialize), check for disconnection (dev->state), and
> of course to execute a usb_put_dev.  Surely this usage should
> be OK?

As long as your disconnect routine doesn't do usb_put_dev, so that it
maintains its reference, I don't see a problem.  But why do you want to
check dev->state later on?  Once your disconnect routine has returned, you
should be totally through with the device.  You should no longer care
whether it's attached or not.

And of course, remember that there are valid reasons for your disconnect 
routine to be called even when the device remains attached.  (rmmod is a 
good example.)

Alan Stern

