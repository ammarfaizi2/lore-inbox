Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266945AbRGKXpR>; Wed, 11 Jul 2001 19:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266951AbRGKXpH>; Wed, 11 Jul 2001 19:45:07 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:760 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266945AbRGKXot>; Wed, 11 Jul 2001 19:44:49 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112344.f6BNijh2010363@webber.adilger.int>
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <002201c10a59$e5ef0ae0$7fcdae3f@laptop> "from C. Slater at Jul 11,
 2001 06:36:15 pm"
To: "C. Slater" <cslater@wcnet.org>
Date: Wed, 11 Jul 2001 17:44:45 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Slater writes:
> Does it come up often? Well, I have a sourceforge project setup and am
> currently only waiting on finalizing how it's going to be done. So we have
> about proved the first possibility wrong, and if you ever hear anything else
> about this in a while, we will have proved the second wrong too. Soo, while
> we are at it, ill say, that if anyone wants to help with it, email me. We
> especialy need people that either have ideas on how to do this or have a
> good knowledge of the kernel, mainly memory, processes, and initilization.

Not to be overly negative, I don't intend this email as an insult, but rather
as a "shed a little light" on the discussion email.  I would be _happy_ if
you actually succeed in your project, but your comments come out as follows:

a) we want this "sounds real good" feature
b) we don't know how we will do it, beyond some hand waving ideas
c) we want kernel experts who know what they are doing to help us
d) kernel experts who have replied so far (negatively) don't know what
   they are talking about, so please butt out
e) you have "started coding" by setting up a sourceforge project

Note that you are talking about a VERY difficult problem, which is
not available on 99.9% of systems out there.  Maybe on a few highly
specialized *nixes which were designed for this (Sequent or such),
and probably have extra hardware support to help along.  I'm _pretty_
sure that Solaris and AIX and HP/UX do NOT do this, and don't you think
they would want to if it were easy?  It would be easier than under
Linux from the perspective that their kernels change far less often,
and have relatively static interfaces.

The best proposal I've heard so far was to use MOSIX to do live job
migration between machines, and then upgrade the kernel like normal.
In the end, it is the jobs that are running on the kernel, and not
the kernel or the individual machine that are the most important.  One
person pointed out that there is a single point of failure in the
MOSIX "stub" machine, which doesn't help you in the end (how do you
update the kernel there?).  If you can figure a way to enhance MOSIX
to allow migrating the MOSIX "stub" processes to another machine, you
will have solved your problem in a much easier way, IMHO.

Note also that you need to look at the _specific_ reason why you want to
do live kernel upgrades, besides it "sounds real good".  If you have such
tight uptime deadlines that you can't take 5 minutes of downtime to boot
a new kernel, then you are probably using a load balancing cluster anyways
in case of hardware failure, so live kernel updates are not needed here.

Note that all real-world high-availability systems I ever worked on
still allowed for SCHEDULED maintenance downtime, but highly frowned
upon UNSCHEDULED downtime.  Even IBM's S/390 99.999% uptime numbers
exclude downtime for SCHEDULED outages, which are simply a fact of life.



Please prove everyone wrong by developing a way to do this, or even
showing a proof-of-concept (i.e. a user-space framework for translating
every kernel data structures from one kernel version to another, that
works across, say, a large fraction of the 2.2 kernel, or maybe from
2.4.0-test until 2.4.current).  It doesn't have to be in-kernel (yet).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
