Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRK2SoZ>; Thu, 29 Nov 2001 13:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283384AbRK2SoP>; Thu, 29 Nov 2001 13:44:15 -0500
Received: from sword.damocles.com ([209.100.46.1]:31915 "EHLO
	sword.damocles.com") by vger.kernel.org with ESMTP
	id <S278932AbRK2SoH>; Thu, 29 Nov 2001 13:44:07 -0500
From: Jeff Randall <randall@sword.damocles.com>
Message-Id: <200111291844.fATIi4T09155@sword.damocles.com>
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
To: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 29 Nov 2001 12:44:04 -0600 (CST)
Cc: balbir_soni@yahoo.com (Balbir Singh), linux-kernel@vger.kernel.org
In-Reply-To: <20011129181227.I6214@flint.arm.linux.org.uk> from "Russell King" at Nov 29, 2001 06:12:27 PM
Reply-To: randall@uph.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Nov 29, 2001 at 12:03:07PM -0600, Jeff Randall wrote:
> > All of the other UNIX variants I've dealth with behave that way.
> > However, you cannot just make that change without having some means
> > of identifying that behavior change because all of the linux
> > serial drivers have been written to assume that their close()
> > will be called even after their open() has failed.
> 
> It's not only serial drivers, its everything that is a tty driver.
> I believe that auditing and fixing that lot in 2.4 just isn't going
> to happen - it's supposed to be a stable kernel after all.
>
> > I'm not opposed to such a change in behavior, but at least be
> > sure that it's somehow identifiable (kernel version, a define
> > set in a header, etc) so that the 3rd party drivers have a means
> > to identify the change.
> 
> eg, #if KERNEL_VERSION >= LINUX_VERSION(2,5,0)

Exactly.  This is not a minor behavior change that can be isolated to
a few drivers.  It's a fundamental change in behavior that is widespread
(I mentioned serial drivers specifically as that's what I was concerned
with but you are correct that it affects everything that uses the tty layer).

It's probably a good change to make at some point in the future, but it
needs to happen in a well defined and clearly identifiable way.  It would
probably be best for it to happen in the 2.5 tree.



> > Redhat 7.1 included that behavior change in the kernel they shipped
> > and it caused no end of problems for those of us that were doing
> > serial drivers since there was no way to easily identify that the
> > patch had been included.
> 
> The change which adds the MOD_DEC_USE_COUNT stuff is bogus, and it
> shouldn't have been made.  (I'm assuming this is what you're talking
> about).

Yes.  Redhat's default kernel in 7.1 (2.4.2-2 as it identifies itself)
will not call the close() routines if the open() routines return an
error.  The real problem isn't that the behavior changed, but that there's
no easy way to tell that they had changed it.


-- 
randall+lkml@uph.com
