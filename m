Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424376AbWLBSsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424376AbWLBSsY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424370AbWLBSsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:48:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47549 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1424349AbWLBSsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:48:23 -0500
Date: Sat, 2 Dec 2006 18:48:21 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202184821.GM3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202184035.GL3078@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 06:40:35PM +0000, Al Viro wrote:
> On Sat, Dec 02, 2006 at 07:27:56PM +0100, Thomas Gleixner wrote:
> > On Sat, 2006-12-02 at 18:19 +0000, Al Viro wrote:
> > > > This is going to make a lot of data structures smaller, when the
> > > > timer_list is embedded in the structure itself and for the lot, which
> > > > ignores the timer callback argument anyway.
> > > 
> > > container_of => still lousy type safety.  All over the sodding place.
> > 
> > Not less than timer->data, where timer data is void *
> 
> RTFPosting.  It might be void *, but it's set via SETUP_TIMER which
> does type checks before casting to void *.
> 
> IOW, I don't want _any_ typecasts/container_of necessary in the code.
> 
> Sane variant is
> 
> void foo_timer(struct net_device *dev)
> {
> 	...
> }
> 
> 	struct foo_dev *p = netdev_priv(dev);
> 	SETUP_TIMER(&p->timer, foo_timer, dev);
> 
> etc.
> 
> With warning generated if foo_timer(dev) would not be type safe.  Without
> typecasts.  Without container_of().  Without any bleeding cruft at all.

BTW, the same goes for tasklets and for work_struct.  Separate series,
obviously...
