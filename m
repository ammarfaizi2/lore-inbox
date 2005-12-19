Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVLSDLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVLSDLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 22:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVLSDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 22:11:09 -0500
Received: from mx1.rowland.org ([192.131.102.7]:58635 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932530AbVLSDLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 22:11:09 -0500
Date: Sun, 18 Dec 2005 22:11:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: USB rejecting sleep
In-Reply-To: <1134960706.6162.2.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0512182206520.2301-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Benjamin Herrenschmidt wrote:

> Ok, I did a bit more tests here with a Keyspan adapter on my laptop
> (well known driver for not having the suspend/resume routines).
> 
> The good thing is with the patch, the machine goes to sleep. However,
> the device is not disconnected/reconnected. What happens it that the bus
> gets suspended anyway and the driver stays around (possibly getting
> errors on some URBs).

Yes, that's what is supposed to happen with that patch.

> This is fine, but not optimal, since that means most of the time that
> the device will not work on resume unless disconnected/reconnected. (For
> keyspan, it seems that the HW does support the suspend state, thus it's
> just a matter of closing/re-opening the port, I suppose it would be easy
> enough to fix the driver).
> 
> So this patch is good for it doesn't prevent sleep anymore, but it also
> doesn't do what we decided it should do. I think David is right that we
> should be able to disconnect the device without actually removing the
> device & driver from sysfs, just let that happen at resume time.

Of course the patch doesn't do what we talked about.  It says so right in 
the Changelog comment.

I disagree with the idea of disconnecting the device.  The right thing to 
do is what David wanted all along: unbind the driver.  This would require 
only a small change to the driver core.

It's too late for me to work on this now, but maybe tomorrow I'll have to 
a chance to write something.

Alan Stern

