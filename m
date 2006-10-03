Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWJCOPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWJCOPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 10:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJCOPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 10:15:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750881AbWJCOPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 10:15:05 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: Theodore Tso <tytso@mit.edu>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org,
       ipw3945-devel@lists.sourceforge.net
In-Reply-To: <20061003133845.GG2930@thunk.org>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
	 <1159822831.11771.5.camel@localhost.localdomain>
	 <20061002212604.GA6520@thunk.org>
	 <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
	 <1159877574.2879.11.camel@localhost.localdomain>
	 <20061003124902.GB23912@tuxdriver.com>  <20061003133845.GG2930@thunk.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 10:12:59 -0400
Message-Id: <1159884779.2855.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 09:38 -0400, Theodore Tso wrote:
> On Tue, Oct 03, 2006 at 08:49:07AM -0400, John W. Linville wrote:
> > As Dan points-out, it will be a while before distros (other than
> > Fedora rawhide and equivalents) have 2.6.19 kernels for general
> > users.  For now, those experiencing this issue should be comfortable
> > experiencing some breakage...?
> > 
> > So, is the window between now and the release of 2.6.19 big enough
> > to give the distros time to get wireless-tools and wpa_supplicant
> > into their update streams?  Or do we need to go through the pain of
> > reverting/delaying WE-21?
> 
> There is a fundamental question hiding here, which is whether or not
> it is acceptable to break users who are running some large set of
> mainline distro's, such as RHEL 4, SLES/SLED 10, Ubuntu Dapper,
> et. al, but who want to upgrade to a newer 2.6 kernel?
> 
> Many users have moved to Ubuntu Dapper, or RHEL 4, or SLES/SLED 10
> because they don't want to deal with a constantly changing/breaking
> GNOME/X world, where packages are constantly being updated and
> possibly breaking their desktop.  Some of these users are in fact
> kernel developers, who want to live and test on the bleeding edge, but
> who don't want to deal with an unstable Desktop/X world, since that's

I'm certain these people already experience breakage when using new bits
that haven't been settled into their desktop/distro of choice.  It
wasn't so long ago (2.6.10 - 2.6.13) that installing a new kernel would
break the expectations of udev, HAL, and libsysfs while sysfs directory
structure was getting laid out for stuff like power management, wireless
devices, etc.  If you're a core system developer, you've got to expect
breakage somewhere.

> not where their expertise lies.  Other users are ones which have to
> use a mainstream distribution for one reason or another (maybe they
> have software that only works on RHEL 4), but are interested in
> testing bleeding edge kernels because they want to help contribute to
> testing and quality assurance.  Is it acceptable to break them with
> ABI changes?
> 
> If the answer that it is acceptable to break the "slower moving"
> distro's, how much time do we need to allow to elapse before the

I'd point out here that one is not breaking the _distro_, as long as we
assume that distros are internally consistent (which one of the major
points of a distro!).  What's getting broken is people who
install/replace distro-provided software with their own bits.  In the
first case, the distro people are responsible to making sure that
breakage does not occur, and that distro users are not affected.  In the
second case, that responsibility falls to the user who
installed/replaced the distro-provided software, precisely because that
software is no longer distro provided.

We've _got_ to accept that somebody installing their own stuff has
_some_ responsibility to ensure compatibility of the random code they
install.  In a perfect world, distros never make a mistake.  But usually
a distro has a much broader and deeper set of expertise than any one
person, and is at least peripherally aware of changes coming down the
pike.  One single person cannot hope to assume the responsibilities of
many maintainers working by division of labor.

Obviously we don't try to break stuff unintentionally, or when the pain
would be too severe, because we know better than most what's going on
and it's Just Not Nice.  But ultimately, whoever is installing the
software bears the consequences of his/her actions, precisely because
they pulled the trigger.

> "faster moving" distro's have accepted the necessary userspace bits?
> Is it 30 days?  60 days? 90 days?  Or do we do it by distribution.  If
> all of Debian testing, Ubuntu development, Fedora Core n and n-1,
> OpenSuse, Gentoo, has accepted the newer bits, is that enough time?
> 
> Clearly the wireless updates failed the second series of tests; but we
> haven't even decided, amongst kernel developers, under what
> circumstances is it permissible to break the first set of distro's.
> Clearly in the best of all worlds new interfaces are carefully
> documented, and no new interface is introduced without thinking very
> carefully about forwards and backwards compatibility.  Unfortuately,
> the wireless ABI interface is a legacy interface which seems to be
> really broken in many different ways.
> 
> John, has the wireless community considered creating a new interface
> which *is* carefully designed, and supporting both the new and the
> legacy interface for 2-3 years until all of the mainstream

Yes, nl80211/cfg80211 (sent to netdev@ last week) is the likely
successor.  Please, if you have suggestions for ABI/API-proofability,
review the patch and post suggestions!  We all know a carefully designed
is not just about the code, but about the semantics, structures, etc as
well.  It would be quite valuable to have everyone's input to make sure
it's as future-proof as possible.

Dan

> distributions have had a chance to cycle?  It would be hard, I know,
> but would it be harder than some of the alternatives, and would it be
> worth it?
> 
> Regards,
> 
> 						- Ted

