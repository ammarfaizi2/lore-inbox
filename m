Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVCCUnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVCCUnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCCUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:39:56 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:24726 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262394AbVCCUiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:38:09 -0500
Date: Thu, 3 Mar 2005 15:38:08 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303203808.GA10408@ti64.telemetry-investments.com>
Reply-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <20050303170759.GA17742@ti64.telemetry-investments.com> <20050303193358.GA29371@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303193358.GA29371@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:33:58PM -0500, Dave Jones wrote:
> If you accelerate the merging process, you're lowering the review process.
> The only answer to get regressions fixed up as quickly as possible
> (because prevention is nigh on impossible at the current rate, so
>  any faster is just absurd), would be more regular releases, so that
> they got spotted quicker.

Right.  My point, and I think Jeff's, was that being extra careful for
the 'even' releases and waiting around N days to see whether someone will
finally test the -rc and see that it is broken impedes the whole process.
Getting more people to test is not necessarily a function of the wait
duration.

>  > Dave has been building "unstable" bleeding-edge Fedora kernels from
>  > 2.6.x-rcM-bkN, as well as "test" kernels for Fedora updates;
> 
> Actually only rawhide (FC4-to-be) has been getting -rc-bk patches.

When Arjan started testing 2.6, he set up a repo, and FC1 users at
the time could just pull rpms from that repo.  I and many others did it.
Currently I'm rolling my own, so I haven't been consistently testing
your Fedora kernels, rawhide or update, but I occasionally do the "grab
the SRPM from Rawhide and rebuild it on FC3"-thing for my laptop.  I
think that we should institutionalize that.

> The FC2/FC3 updates have been release versions only, with -ac patches.
> (and also some additional patches backing out bits of the -ac)

I've watched you periodically announce "hey, I'm doing an update for
FC3/FC2, please test" on the mail list, and a handful of people go test.
If we could convince many of the the less risk-averse but lazy users to
grab kernels automatically from updates/3/testing/ or updates/3/unstable/
as part of "yum update", and have a way to manage the plethora of (even
daily) kernel updates by removing old unused kernels, then we'd only
have to convince them *once* to set up their YUM repos, and then get them
to poweroff or reboot [or use a Xen domain] occasionally. :-)

> This is part of the problem with rebasing the existing releases to
> new kernels. It's shoving a largely untested codebase into a release
> that was never tested in that combination. It's expected that some
> stuff will break, but the volume of breakage is increasing as time goes on.
> Even if _I_ stopped rebasing the Fedora kernel, some of our users
> will still want to build and run the latest kernel.org kernel on their
> FC2 boxes. We shouldn't be expecting them to have to rebuild half of
> their userspace just because we've been sloppy and broke interfaces.
 
Yes, this is miserable, and exacerbated by the inability of almost all
distros to deal with multiple installed versions of packages, or easily
roll back changes, which crimps my argument w.r.t. wider testing, since
the typical user willing to test while otherwise doing useful work wants to
be able to roll back easily if there is a serious problem.

The LVM packaging situation between 2.4 and 2.6 illustrated the problem
well; one couldn't boot back into 2.4 unless LVM1 and LVM2 userland
could coexist; I spent time rolling packages back then to do just that.
In any case, kernel helper packages (udev, device-mapper, iptables, etc.)
need to be added to a "kernel+related" package repo.

Users could be encouraged to do more testing if they are provided
with a simple mechanism to snapshot, update, test, and then either
keep the changes or roll back.  I do this in UML with the COW tools.
Currently LVM2 has writable snapshots, but no easy way (at system boot)
to reintegrate the changes into the base from a snapshot, or "fallback"
to a snapshot.  Still, using Xen/UML/QEMU, it is not difficult to take
advantage of copy-on-write to update the kernel and other packages, then
boot the image to start a shell or web/ftp/mail/... daemon(s).  At least
that would exercise the non-hardware-related, (and for now, non-SMP)
parts of the kernel.

	Bill Rugolsky
