Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVCCRMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVCCRMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCCRKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:10:20 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:16274 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262510AbVCCRIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:08:00 -0500
Date: Thu, 3 Mar 2005 12:07:59 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303170759.GA17742@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303021506.137ce222.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:15:06AM -0800, Andrew Morton wrote:
> If we were to get serious with maintenance of 2.6.x.y streams then that is
> a 100% productisation activity.  It's a very useful activity, and there is
> demand for it.  But it is a very different activity.  And a lot of this
> discussion has been getting these two activities confused.
 
IMHO, Jeff Garzik has made two very useful points in this thread:

1. The number of changesets flowing towards the Linus kernel is accelerating,
   so the kernel developers should be trying to accelerate the merging process,
   not introducing delays.  Having an extended -rc period that stuffs up merging
   just creates back pressure and causes changesets that could be getting
   reviewed, merged, and booted somewhere to instead lie dormant.

2. No matter what one calls it, -rc1, .<odd>, or just 2.6.X these days,
   intelligent consumers know a "dot-zero" release when they see one.
   [I've had experience of several boneheaded corporate policies dictating
    an unpatched kernel.org kernel, but they are uninteresting users.]  The
   class of users that want to use the kernel in production are going to
   wait days to weeks, no matter what.  The trick is in encouraging everyone
   else to overcome inertia and test new releases.

As part of a solution to the "production kernel" problem, Jeff suggested a
2.6.x.y tree that gets pulled to 2.6.x+1.  Neil Brown made a similar point:

   For the kernel, I am the "distribution" for my employer and I choose
   which kernel to use, with which patches.  I really don't want to hunt
   around for all those stablisation patches, or sift through the patches
   in 2.6.X+1-pre to find things to apply to 2.6.X.  I would be really
   happy there was a central place where maintainers can put suitably  
   reviewed "important bug fix"es for recent releases, and from where
   kernel maintainers for any distribution (official or not) could pull
   them.

I'm in the same boat with Neil. Determined to stay reasonably close
to mainline, I started in the 2.6.9-bk series to try to nail down a
stable production kernel. I spent about two months reading lkml and
bk-commits-head, picking through -mm for patches that might be important
for my workloads (e.g., vmtrunc), and spending my days with "quilt",
merging up a new -bk kernel every few days, backing out "dangerous
changes", and retesting. At 2.6.10, I stopped revving up and started
to just merge fixes from 2.6.11-bk.

I'm sure Neil and I are not alone.  I perceive four groups of users for
kernel.org users, with differing requirements:

	1. Developers.  For them, the Linus kernel is a synchronization
	   point for merging, as well as their personal test environment.

	2. "Casual" end-users who like to build their own kernels, and for 
           whom a kernel oops, crash, or driver failure is not a big
	   hassle; they just reboot into their previous kernel.  They are
	   content if a new kernel doesn't corrupt their data.

	3. "Production" end-users, who need a kernel that is going to run
	   stably, usually on many servers, indefinitely [until a bug or
	   desired feature forces an upgrade/reboot].  Rolling out a new
	   kernel is a hassle, and is usually done to fix a serious kernel
	   bug or driver problem.

	4. Vendors, who need a long period of stabilization and testing,
	   as well as a (vendor-internal) mechanism for determining what
	   features, drivers, etc.  to support.

As individuals, many of us live in multiple categories, e.g., I'm a (3) at work,
and a mix of (2) [laptop] and (3) [file server] at home.

Greg KH complained:

   Bug fixes for what?  Kernel api changes that fix bugs?  That's pretty
   big.  Some driver fixes, but not others?  Driver fixes that are in the
   middle of bigger, subsystem reworks as a series of patches?  All of this
   currently happens today in the main tree in a semi-cohesive manner.  To
   try to split it out is a very difficult task.

Opinions will differ, but I think things are a lot more clear-cut than
Greg allows.  I certainly don't expect to download, build, and deploy
a kernel devoid of patches without expecting at least a few problems.  It's
the incredible duplication of effort to sort through thousands of changesets in
order to cull dozens to hundreds, with the result that everyone is running
a subtly different kernel core.  And most of us are far less qualified
than subsystem maintainers to evaluate the risk of individual changesets.

Folks in categories (3) and (4) care very deeply about subtle corruption
[like the recent pty lost bytes], even if rare, as well as easily
triggerable oopses, races, deadlock, livelock, resource leaks, massive
performance regressions, and serious breakage in the (rapidly evolving)
networking stack.  These belong in 2.6.x.y.  API changes do not, unless
they are required to fix one if the above.

Sure, this is going to create situations, such as just occurred, where the
change to 4-level tables meant that some later patches require a bit of
love before they'll apply to the previous 2.6.X release or vice-versa;
but it isn't an everyday occurence.

Driver fixes?  For category (3) users, if one doesn't have the hardware,
or the driver is not broken with the end-user's hardware, one mostly
doesn't care about driver fixes.  Vendors, like Dave Jones, are of course
in a different position, because a vendor kernel is a different animal that
needs to work everywhere, or bug trackers starts filling up quickly.

Dave has been building "unstable" bleeding-edge Fedora kernels from
2.6.x-rcM-bkN, as well as "test" kernels for Fedora updates; they simply
aren't receiving enough testing, and/or the bug reports are going to the wrong
place.  Similarly, Arjan has been building rpms for Alan's kernels; those
kernels are "vanilla" -ac.

Part of the problem here is that most users install e.g., Fedora Core,
and don't enable "testing" in their package manager; judging by the
Fedora lists, many don't even know about it.  [Or don't know or care
that they could limit updates from "testing" or "unstable" to just the
kernel or other packages that allow multiple versions to be installed;
the update would simply fail if a new udev or whatever is required,
prompting admin intervention].  This  contrast with the much
slower-moving Debian, where getting useful work done often requires
running parts of "testing" or even "unstable".

There is a large universe of desktop and laptop users who reboot their
machines every day, and would probably run the most up-to-date kernel
when they boot every morning, confident that they can simply reboot
into the last working kernel if there is a problem.  But it doesn't happen,
because it is not automatic.   In order for this to happen we need
new kernels to be installed automatically and made the default, on
systems where the admin has elected to do so, and a policy for cleaning
up old kernels that are unused (haven't been used for the last N boots
or whatever).

So in short, I'm saying that solutions to the stable kernel problem and
the testing problem are not necessarily solved with a single mechanism.

The testing situation would be improved if a distro install asked the
end-users whether they'd like to participate in kernel testing, explain
the importance of it, and then set up their package manager cron scripts
accordingly (-linus, -mm, -ac, whatever).  I believe the onus here is
on the distros to convince their "hobbyist/enthusiast/sysadmin" users
to help them test before wider release.

Regards,

	Bill Rugolsky
