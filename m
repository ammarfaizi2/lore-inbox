Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWBBUKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWBBUKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWBBUKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:10:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932204AbWBBUKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:10:37 -0500
Date: Thu, 2 Feb 2006 15:10:08 -0500
From: Dave Jones <davej@redhat.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202201008.GD11831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Loftis <mloftis@wgops.com>,
	David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:25:24AM -0700, Michael Loftis wrote:

 > >o You want security fixes and only minor other fixes (done magically
 > >  by someone else as you're not willing to pay for it, nor are you
 > >  willing to help yourself), for at least 6 months, but you ignore
 > >  the existance of the 2.6.x.y kernel series, which does exactly
 > >  that -- check
 > 
 > There's noone out there that does that, I'd LOVE to be able to pay for it 
 > and not have to do it myself.  RedHat kernels don't work on most of our 
 > gear

Specifics?  The patches we carry in Fedora aren't very system-specific,
so any failure to boot there would likely be a problem on mainline.
The "but it works on $otherdistro" response that seems to be so popular
these days is time after time proven due to be because $otherdistro is
shipping an older kernel, and hasn't hit that particular bug yet.

 > , and RH, up to and including fedora core, and centos have some 'great' 
 > issues, like the listener processes for Apache and MySQL using up *ALL* of 
 > the system CPU when *NOTHING* is happening.

How did you determine this is a kernel bug?  Did you file a bugzilla report on this?

 > We've tried to track it down, 
 > it's gotten to where we just don't care and we just don't deploy RedHat 
 > anymore.  SuSE's kernels suffer the same problem of too many patches I 
 > mentioned before for totally unrelated, non-security things.

You can't complain about 'too many patches' in a distro kernel these days.
Any distro that ships a stock vanilla kernel is a distro that has
known oopsable drivers, features that don't work as expected, 
won't boot on certain hardware, and other general flakyness.

In the current FC4 2.6.15.2 based update..

- 47 bug fix patches. Shipping without these isn't an option.
- 24 'deviation' patches, where we add some not-yet-upstream feature
  or rh-specific feature. (Xen, Execshield, signed modules, restricted /dev/mem etc)
  [note, not 1 diff per feature, some features are multiple patches]
- 21 debugging patches. (Enabling extra output in certain bad situations etc)
- 3 convenient 'make the buildsys life easier' patches
- the remainder are other 'nice to haves' backported from 2.6.16rc

At the absolute minimum, we'd need to carry those 47 bugfixes.
Some of these get pushed to -stable, some aren't considered enough
of a problem, so they'll sit there until I rebase to a .16

We have this mentality in certain circles of "I don't want any
changes in my distro kernel, oh, except for ones that I want".
The problem is when >1 person wants patches to make their systems
run, the result is a pretty large collection of patches.

If you want a kernel with a limited set of patches, the only answer
is 'build your own', but don't complain about vendors doing the
only thing that they can do that they've been doing for the last
10-15 years -- Trying to make a single kernel image work on
as many platforms as possible with the smallest amount of pain.
(And 'new' development model hasn't changed a damn thing in this regard,
 it's always been a challenge).

		Dave

