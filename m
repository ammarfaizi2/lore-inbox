Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUFJRgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUFJRgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUFJRgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:36:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:43917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262101AbUFJRgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:36:48 -0400
Date: Thu, 10 Jun 2004 10:35:39 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Al Viro <viro@math.psu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610173539.GB508@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <40C89A16.8030301@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C89A16.8030301@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 10:27:50AM -0700, David Brownell wrote:
> Greg KH wrote:
> >On Thu, Jun 10, 2004 at 05:49:03AM +0100, 
> >viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >>272 is interesting - it's in
> >>static void async_completed(struct urb *urb, struct pt_regs *regs)
> >>{
> >>       ...
> >>}
> >>and it brings two questions:
> >>	a) shouldn't ->si_addr be a __user pointer (in all contexts I see
> >>it is one)
> >>	b) WTF is usb doing messing with it directly?
> >>Note that drivers/usb/core/{devio,inode}.c are the only users of that 
> >>animal
> >>outside of arch/*.  Looks fishy...
> >
> >
> >I really don't know.  I think David added that code.  David, any ideas?
> 
> Not me.  I think that's the original code from Thomas Sailer;
> I've never touched the usbfs AIO core.  (Maybe you're thinking
> of some oops-on-disconnect fixups I did, forcing completions
> on all the usbfs-internal async requests.  That's now done in
> usbcore.)

Sorry, I was thinking of your gadgetfs aio work.  My mistake.

greg k-h
