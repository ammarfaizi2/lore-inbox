Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284611AbRLETkq>; Wed, 5 Dec 2001 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284603AbRLETkh>; Wed, 5 Dec 2001 14:40:37 -0500
Received: from trillium-hollow.org ([209.180.166.89]:24072 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S280980AbRLETk1>; Wed, 5 Dec 2001 14:40:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, lm@bitmover.com (Larry McVoy),
        "Jeff Merkey" <jmerkey@timpanogas.org>
Subject: Loadable drivers  [was  SMP/cc Cluster description ]
In-Reply-To: Your message of "Wed, 05 Dec 2001 09:09:38 GMT."
             <E16BY3e-0005S9-00@the-village.bc.nu> 
Date: Wed, 05 Dec 2001 11:40:07 -0800
From: erich@uruk.org
Message-Id: <E16Bhtn-0004xf-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > For example, there should be no reason that most drivers or any other
> > random kernel module should know anything about SMP.  Under Linux, it
> > annoys me to no end that I have to ever know (and yes, I count compiling
> > against "SMP" configuration having to know)...  more and more sources of
> > error.
> 
> Unfortunately the progression with processors seems to be going the
> wrong way. Spin locks are getting more not less expensive. That makes
> CONFIG_SMP=n a meaningful optimisation for the 99%+ of people not running
> SMP

I appreciate the costs (having worked in the Intel x86 arch team) and don't
like that part either, but the question at hand is whether you need the SMP
locks in most of the compiled drivers/modules themselves.  That is in part
an artifact of the old architecture before they were loadable.


This really goes into a side-topic, but plainly:

The general driver/random module framework in Linux really needs to get
separated from the core kernel, and made so that it doesn't need to be
recompiled between minor kernel versions.  Perhaps even pulling the
drivers in general apart from each other, just aggregating releases for
convenience.

MS with Windows (and even DOS) went the right direction here.  In fact,
they have been hurting themselves by what lack of driver interoperability
there is even between Windows NT/2K/XP.  Admittedly they didn't have much
of a choice with their closed-source scheme, but it still is a better
solution from a usability and stability point of view in general.


Don't get me wrong, I only run MS Software on 2 of my 8 machines (and
have been trying to remove one of those with Wine/WineX), but I appreciate
a better overall solution when I see one.


I will go so far as to say, for the long term this is necessary for the
survival of Linux, and would help it's health even in the server arena.

For example, we need the ability to easily:
  --  Install random drivers on top of your kernel version and not
	have them disappear when changing kernels unless that is desired.

	This is just a royal pain for most people I've ever dealt with
	who are not kernel hackers, and rightly so.

  --  Install random kernels while retaining the same drivers for
	testing/stability purposes.

	I know that on my Linux servers, it bugs me that it's hard/nigh
	impossible sometimes to change the core kernel and still trust
	the drivers haven't drifted.


Those can usually be done by someone who is willing to/capable of
performing sleazy tricks or detailed hacking, but it's a burden.  It
gets prohibitive often enough to be very frustrating, and I'm more patient
than most I know with random kernel hacking.

Stability/control/compatibility is in general of far more concern to most
than tweaked performance of the core kernel against the drivers.  That
wouldn't be given up either, it just becomes an option.


A lesser solution, but moderately workable in the short-term:

Build a framework for an external "drivers" source/binary tree that can be
(via a single command) rebuilt for a different Linux kernel version.  This
is arguably a Linux distribution thing.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
