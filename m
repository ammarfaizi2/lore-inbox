Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424325AbWLBSUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424325AbWLBSUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424330AbWLBSUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:20:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40138 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1424325AbWLBSUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:20:02 -0500
Date: Sat, 2 Dec 2006 18:19:57 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202181957.GK3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165082803.24604.54.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 07:06:43PM +0100, Thomas Gleixner wrote:
> On Sat, 2006-12-02 at 09:02 -0700, Matthew Wilcox wrote:
> > On Sat, Dec 02, 2006 at 03:45:12PM +0100, Thomas Gleixner wrote:
> > > What's the cruft ? 
> > > 
> > > struct bla = container_of(timer, struct bla, timer); ???
> > 
> > That's it, right there.  Any idea how much we've bloated the kernel with
> > sysfs, just by insisting that the struct device not be the first item in
> > the struct?  There's any number of 2- and 3- line functions calling each
> > other, each adding and subtracting constants from the pointers passed to
> > them.  This was a huge mistake, IMO.
> 
> What a nonsense.
> 
> 	foo->timer.data = foo;
> 
> is complete redundant information.
> 
> This is going to make a lot of data structures smaller, when the
> timer_list is embedded in the structure itself and for the lot, which
> ignores the timer callback argument anyway.

container_of => still lousy type safety.  All over the sodding place.
