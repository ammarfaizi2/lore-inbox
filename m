Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWDZMKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWDZMKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 08:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWDZMKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 08:10:04 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:43746 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932409AbWDZMKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 08:10:02 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060425222642.GA4921@dspnet.fr.eu.org>
References: <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424124556.GA92027@dspnet.fr.eu.org>
	 <1145883251.3116.27.camel@laptopd505.fenrus.org>
	 <20060424140831.GA94722@dspnet.fr.eu.org>
	 <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil>
	 <20060425222642.GA4921@dspnet.fr.eu.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 26 Apr 2006 08:14:31 -0400
Message-Id: <1146053671.28745.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 00:26 +0200, Olivier Galibert wrote:
> On Tue, Apr 25, 2006 at 12:29:26PM -0400, Stephen Smalley wrote:
> > This generally indicates a problem in policy or the application that
> > needs to be fixed.  It doesn't mean that object labeling is itself
> > problematic, anymore than the existing owner and mode information in the
> > inode is inherently problematic.
> 
> Default owner and mode are handled by the kernel because otherwise it
> would indeed be inherently problematic.  Don't expect normal
> applications, editors or xml libraries to change from the normal
> open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666).  SELinux is not, and will
> not, ever, be their problem.

First, default labeling is also handled by the kernel, as with default
owner and mode.  Files will be labeled in accordance with the policy
based on the label of the creating process, the label of a related
object (parent directory, to support inheritance properties when
appropriate), and policy rules.  But this is not always sufficient, any
more than default owner and mode is always sufficient for file creation.

Second, the entire point of SELinux is to get MAC into the mainstream,
and it is enabled by default in Fedora.  Unless that changes, it should
gradually affect a change in the applications to adapt to the presence
of SELinux, just as they have gradually adapted to other changes in the
kernel.  Such change is always painful, but MAC is necessary as a
fundamental building block if we are going to ever have improved
security.  And not all applications have to change; many can just use
the default behaviors.

> > Object labeling achieves both.
> 
> In your dreams.

Um, perhaps you could be more concrete?  Difficult to have a rational
discussion otherwise.  This division of "protecting application
behavior" vs. "protecting files" is arbitrary and meaningless.   

> > I don't think it is religious - it has to do with the kernel's internal
> > model and what makes sense for the kernel to implement.  And the
> > question is not whether policy can/should be path-based; it is whether
> > the kernel mechanism should be path-based.
> 
> "The" kernel mechanism?  The point of LSM is that there wasn't to be
> one official and unique kernel mechanism.  You alternating between
> "this is not acceptable because it is not SELinux" and "this is not
> acceptable because it can be done with SELinux" gets a little tiring.

Sorry if I wasn't clear, as that wasn't my meaning.  In my phrasing
above, "the kernel mechanism" is just referring to the kernel mechanism
of AA.  IOW, "the question is not whether AA policy can/should be
path-based; it is whether the AA kernel mechanism should be path-based".
Clearer?  Or more generally, whether a path-based mechanism belongs in
the kernel.  And this is not just limited to the security space, nor to
SELinux vs. the world.  It is a general question of what fits the
kernel's internal model and what are appropriate kernel mechanisms.  Not
my call to make, but it is reasonable for me to ask the question.  

> > And further, whether even
> > such a path-based kernel mechanism should be done in the manner in which
> > AppArmor does it.  Bad example, I suppose, but consider inotify - does
> > it regenerate pathnames in the kernel, and use those pathnames in its
> > own mechanism?
> 
> The implementation sucks, news at eleven.  At that point SELinux sucks
> too, only differently, and don't even protect what is really
> important[1].  Anyway, LSM is lacking path-based hooks, they should be
> added in a reasonable fashion that indeed do not require regenerating
> the paths or horribly slowing down hotpath code.

Actually, SELinux can protect user data, and strict policy (i.e. the
original example policy) is an example of doing that.  So don't confuse
the mechanism with specific policy configurations, please.

On the latter point, the question is whether such a mechanism is
feasible in Linux at all, and then if so, whether the AA folks are
willing to fundamentally re-architect their implementation in this
manner.  DTE was an attempt to implement implicit typing based on
pathnames in a way that did not require path regeneration.  It was
ported to LSM early on, but as I recall, the SubDomain folks were leery
of the approach.

> 
>   OG.
> 
> [1] User data.  Because / is only a reinstall away.

-- 
Stephen Smalley
National Security Agency

