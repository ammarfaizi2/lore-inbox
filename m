Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWJFHVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWJFHVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWJFHVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:21:14 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:57519 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1161081AbWJFHVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:21:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Fri, 6 Oct 2006 09:21:51 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0610051732190.7346-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610051732190.7346-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060921.52186.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 23:45 schrieb Alan Stern:
> On Thu, 5 Oct 2006, Oliver Neukum wrote:
> 
> > I have a few observations, but no solution either:
> > - if root tells a device to suspend, it shall do so
> 
> Probably everyone will agree on that.

But should it stay suspended until explictely resumed? Do we have
consensus on that?

> > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> 
> Except for the fact that remote wakeup kicks in only when a device is 
> suspended.

Yes.
 
> > - there should be a common API for all devices
> 
> It would be nice, wouldn't it?  But we _already_ have several vastly
> different power-management APIs.  Consider for example DPMI and IDE 
> spindown.

No reason to make matters worse.
 
> > - there's no direct connection between power save and open()
> 
> Why shouldn't a device always be put into a power-saving mode whenever it 
> isn't open?  Agreed, you might want to reduce its power usage at times 
> even when it is open...

That and you are putting the latency/power choice into kernel space.
I've seen GPS recievers that need 30 seconds to get a fix. Autosuspend
needs to be in kernel space. But that doesn't mean that it is sufficient
as a mechanism nor that it doesn't need parameters supplied from
user space.

> > The question when a device is in use is far from trivial.
> 
> Yes.  It has to be decided by each individual driver.  For simple 
> character-oriented devices, "open" is a good first start.

Yes. However, simple character devices are the first candidates for
libusb so kernel space is left with the hard cases.

	Regards
		Oliver
