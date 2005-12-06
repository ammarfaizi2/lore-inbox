Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVLFLJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVLFLJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVLFLJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:09:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:42420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751360AbVLFLJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:09:28 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 12:09:25 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206110925.GD10574@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe> <20051205164418.GA12725@merlin.emma.line.org> <1133803048.21641.48.camel@mindpipe> <20051205175518.GA21928@merlin.emma.line.org> <873bl76zd3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bl76zd3.fsf@mid.deneb.enyo.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Florian Weimer wrote:

> * Matthias Andree:
> 
> > Basically, no-one should have permission to touch any core parts, except
> > for fixes, until 2.7. Yes, that means going back to older models. Yes,
> > that means that the discussions will start all over. And yes, that means
> > that the cool stuff has to wait. Solution: release more often.
> 
> Would this alone change much?  I think what we really want is that our
> favorite branch (whatever it is) gets critical fixes forever (well,
> maybe one or two years, but this is forever).  This is a bit
> unrealistic because everyone has a slightly different branchpoint.
> Releasing more often doesn't change that, really.

Releasing minor releases more often and enforcing "don't touch unless
you must" policy would create such synchronization point and a branch
where everyone could safely hop between releases.

> In the security area, I think there is enough experience out there to
> collect data which would help each local branch maintainer to install
> the relevant fixes.  But for general development, this seems to be
> infeasible, unless you focus your software architecture on this
> purpose (which is probably a terrible idea to do for kernel
> development).

I don't think focusing the kernel on code quality and security is wrong
though. The actual problem we've seen from postings by Lee and others is
that the burden of test is shifted to the distros and their QA teams so
that effectively everyone is free to break things at will, downstream QA
will fix it anyways.

This however doesn't work, and the problem here is the propagation
delay. At the time the end user sees a problem with his kernel, the
upstream has already abandoned the 2.6.X.Y stable branch the distro was
based on, and upstream is at 2.6.X+2 or even farther ahead. What is
actually needed is to enclose this end user system in the tests run
before further changes in the same area. And as udev etc. need to
change, a simple test if the current kernel works means updating some
user space packages, hotplug, modutils (OK this was 2.5), udev,
whatever, and what's even worse, if that doesn't help or breaks other
things. Going back may not even work through the packaging system
because the old kernel version may not have a "udev <= N" dependency
either...

So before this can work, the actual package maintenance systems such as
yum, yast, dpkg, apt and rpm will need to support what Emacs Lisp calls
excursions. It means, snapshot the packages and revert to the same set
later.

Even if this were solved and excursions were cheap, it would still not
solve the time skew bug report and upstream fixes...

-- 
Matthias Andree
