Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUFJFBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUFJFBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFJFBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:01:00 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:4004 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266114AbUFJFA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:00:58 -0400
Subject: Re: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040610041529.GD12308@parcelfarce.linux.theplanet.co.uk>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
	<20040610012441.GY12308@parcelfarce.linux.theplanet.co.uk>
	<1086839438.14179.340.camel@dooby.cs.berkeley.edu> 
	<20040610041529.GD12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 22:00:56 -0700
Message-Id: <1086843656.32057.390.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 21:15, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Jun 09, 2004 at 08:50:33PM -0700, Robert T. Johnson wrote:
> > static int pty_write(struct tty_struct * tty, int from_user,
> > 		       const unsigned char __user   *ubuf, 
> >                        const unsigned char __kernel *kbuf,
> >                        int count)
> 
> So I suspect that it in the long run the proper fix will be to sanitize
> the locking and move all copy_from_user() to the (only) caller.

I agree this is the ideal fix.  I can see advantages and disadvantages
to all the approaches.  I'm not familiar with the locking issues, so I
can't comment on that.

> > I fear that completely separating ioctl and kernel data structures would
> > result in lots of redundant structure definitions, which will lead to
> > code maintainence problems and their own host of bugs.  Would it be
> > better to just design a bug finding tool that's capable of keeping track
> > of different structure instances separately?
> 
> I doubt it.  Most of the ioctl data structures do not survive past the
> decoding; fb layer is ugly that way, but that's a local problem and it
> can be fixed.
> 
> Keep in mind that anything containing userland pointers needs to be explicitly
> dealt with on 32/64 platforms - otherwise 32bit code won't be able to issue
> that ioctl anyway.
> 
> 	Besides, kernel data structures should not be tied by ABI stability
> requirements - and ioctl arguments have to.  Which leads to far worse bug
> potential than explict decoding.

These are design issues outside the scope of what I'm doing, but they
are important.  I'll try to keep these considerations in mind as I
continue to improve cqual.  Thanks for the helpful feedback.

Best,
Rob


