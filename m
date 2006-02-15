Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946009AbWBOQ1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946009AbWBOQ1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946011AbWBOQ1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:27:18 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:39897
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1946009AbWBOQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:27:17 -0500
Date: Wed, 15 Feb 2006 08:27:20 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
Message-ID: <20060215162720.GA1503@kroah.com>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 11:07:32AM -0500, Alan Stern wrote:
> On Tue, 14 Feb 2006, James Bottomley wrote:
> 
> > On Mon, 2006-02-13 at 12:38 -0800, Greg KH wrote:
> > > > - Nasty warnings from scsi about kobject-layer things being called
> > > from
> > > >   irq context.  James has a push-it-to-process-context patch which
> > > sadly
> > > >   assumes kmalloc() is immortal, but no other fix seems to have
> > > offered
> > > >   itself.
> > > 
> > > This has been the case for a long time.  I don't really think there is
> > > a
> > > rush to get this fixed, but I really like James's proposed patch.
> > > It's
> > > up to him if he feels it is ready for 2.6.16 or not.
> > 
> > Well, I can't solve the problem that it requires memory allocation from
> > IRQ context to operate.  Based on that, it's an unsafe interface.  I'm
> > going to put it inside SCSI for 2.6.16, since it's better than what we
> > have now, but I don't think we can export it globally.
> 
> Could we perhaps make this safer and more general?
> 
> For instance, add to struct device a "pending puts" counter and a list
> header (both protected by a global spinlock), and have a kernel thread
> periodically check the list, doing put_device wherever needed.  How does
> that sound?

Sounds like a garbage collector :)

Nah, I don't think it's a good idea.  James's patch should work just
fine.

thanks,

greg k-h
