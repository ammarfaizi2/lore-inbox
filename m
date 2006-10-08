Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWJHCDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWJHCDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWJHCDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:03:41 -0400
Received: from mx2.rowland.org ([192.131.102.7]:29956 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1750742AbWJHCDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:03:40 -0400
Date: Sat, 7 Oct 2006 22:03:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610071703.24599.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006, David Brownell wrote:

> On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:
> 
> > > > I dare say that the commonest scenario involving USB is a laptop with
> > > > an input device attached. Input devices are for practical purposes always
> > > > opened. A simple resume upon open and suspend upon close is useless.

You are distorting what I said.  The "resume upon open and suspend upon
close" scheme was not intended for things like input devices, which are
more or less permanently open.  It was intended for things like
fingerprint readers or printers, which spend most of their time not being
used.

> That is, the standard model is useless?  I think you've made
> a few strange leaps of logic there ... care to fill in those
> gaps and explain just _why_ that standard model is "useless"???
> 
> Recall by the way that the autosuspend stuff kicked off with
> discussions about exactly how to make sure that Linux could
> get the power savings inherent in suspending USB root hubs,
> with remote wakeup enabling use of the mouse on that keyboard.
> (I remember Len Brown talking to me a few years back about how
> that was the "last" 2W per controller easily available to save
> power on Centrino laptops ... now we're almost ready to claim
> that savings.)

The most obvious model for suspending keyboards or mice is an inactivity 
timeout (with the timeout limit set from userspace), but other policies 
certainly could be useful in specific circumstances.

Considering that we have virtually no autosuspend capability now, taking
the first few simple steps will be a big help.  Just getting an
infrastructure in place is a good start, even without a userspace API.  
Later on, when we have a better idea of what we want, bells and whistles
can be added.

Even Oliver has admitted that the implementation issues are very tricky 
and he doesn't know the best approach to take.

Alan Stern

