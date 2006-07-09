Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWGIUkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWGIUkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWGIUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:40:10 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:29937 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1161132AbWGIUkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:40:09 -0400
Date: Sun, 9 Jul 2006 22:40:06 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Theodore Tso <tytso@mit.edu>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: [OT] 'volatile' in userspace
Message-ID: <20060709204006.GA5242@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709195114.GB17128@thunk.org>
Organization: M38c
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 03:51:14PM -0400, Theodore Tso wrote:
> On Sun, Jul 09, 2006 at 12:16:15PM -0700, David Schwartz wrote:
> > > Volatile is useful for non device driver work, for example VJ-style
> > > channels.  A portable volatile can help to code such things in a
> > > compiler-neutral and platform-neutral way.  Linux doesn't care about
> > > compiler neutrality, being coded in GNU C, and about platform
> > > neutrality, having a per-arch abstraction layer, but other programs may
> > > wish to run on multiple compilers and multiple platforms without
> > > per-platform glue layers.
> > 
> > 	There is a portable volatile, it's called 'pthread_mutex_lock'. It allows
> > you to code such things in a compiler-neutral and platform-neutral way. You
> > don't have to worry about what the compiler might do, what the hardware
> > might do, what atomic operations the CPU supports, or anything like that.
> > The atomicity issues I've mentioned in my other posts make any attempt at
> > creating a 'portable volatile' for shared memory more or less doomed from
> > the start.
> 
> The other thing to add here is that if you're outside of the kernel,
> you *don't* want to be implementing your own spinlock if for no other
> reason than it's a performance disaster.  The scheduler doesn't know
> that you are spinning waiting for a lock, so you will be scheduled and
> burning cpu time (and energy, and heat budget) while waiting for the
> the lock.  I once spent over a week on-site at a customer complaining
> about Linux performance problems, and it turned out the reason why was
> because they thought they were being "smart" by implementing their own
> spinlock in userspace.  Bad bad bad.
> 
> So if a userspace progam ever uses volatile, it's almost certainly a
> bug, one way or another.

Without 'volatile' and disabling optimizations altogether, how do we
prevent gcc from optimizing away pointers? As can be seen on
http://wiki.rubygarden.org/Ruby/page/show/GCAndExtensions (at
'Compiler over-optimisations and "volatile"'), volatile is used to
prevent a specific type of optimization. This is because of the
garbage collector, which scans the stack and registers to find
referenced objects. So you don't want local variables containing
references to objects optimized away.

While it is again a side-effect of volatile which is being (mis)used,
it is sometimes the only (easy & known) way to achieve this intented
effect...

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
