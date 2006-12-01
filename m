Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031694AbWLABNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031694AbWLABNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031692AbWLABNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:13:32 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:64474 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1031689AbWLABNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:13:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Date: Fri, 1 Dec 2006 02:08:28 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>
References: <20061128020246.47e481eb.akpm@osdl.org> <20061130131240.21b1e889.akpm@osdl.org> <200611302232.03608.rjw@sisk.pl>
In-Reply-To: <200611302232.03608.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612010208.29331.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 30 November 2006 22:32, Rafael J. Wysocki wrote:
> [Trimmed the Cc list a bit.]
> 
> On Thursday, 30 November 2006 22:12, Andrew Morton wrote:
> > On Thu, 30 Nov 2006 21:21:27 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Thursday, 30 November 2006 02:04, Rafael J. Wysocki wrote:
> > > > On Thursday, 30 November 2006 00:26, Andrew Morton wrote:
> > > > > On Thu, 30 Nov 2006 00:08:21 +0100
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > 
> > > > > > On Wednesday, 29 November 2006 22:31, Rafael J. Wysocki wrote:
> > > > > > > On Wednesday, 29 November 2006 22:30, Andrew Morton wrote:
> > > > > > > > On Wed, 29 Nov 2006 21:08:00 +0100
> > > > > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > > > 
> > > > > > > > > On Wednesday, 29 November 2006 20:54, Rafael J. Wysocki wrote:
> > > > > > > > > > On Tuesday, 28 November 2006 11:02, Andrew Morton wrote:
> > > > > > > > > > > 
> > > > > > > > > > > Temporarily at
> > > > > > > > > > > 
> > > > > > > > > > > http://userweb.kernel.org/~akpm/2.6.19-rc6-mm2/
> > > > > > > > > > > 
> > > > > > > > > > > Will appear eventually at
> > > > > > > > > > > 
> > > > > > > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> > > > > > > > > > 
> > > > > > > > > > A minor issue: on one of my (x86-64) test boxes the uli526x driver doesn't
> > > > > > > > > > work when it's first loaded.  I have to rmmod and modprobe it to make it work.
> > > > > > > > 
> > > > > > > > That isn't a minor issue.
> > > > > > > > 
> > > > > > > > > > It worked just fine on -mm1, so something must have happened to it recently.
> > > > > > > > > 
> > > > > > > > > Sorry, I was wrong.  The driver doesn't work at all, even after reload.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > tulip-dmfe-carrier-detection-fix.patch was added in rc6-mm2.  But you're
> > > > > > > > not using that (corrent?)
> > > > > > > > 
> > > > > > > > git-netdev-all changes drivers/net/tulip/de2104x.c, but you're not using
> > > > > > > > that either.
> > > > > > > > 
> > > > > > > > git-powerpc(!) alters drivers/net/tulip/de4x5.c, but you're not using that.
> > > > > > > > 
> > > > > > > > Beats me, sorry.  Perhaps it's due to changes in networking core.  It's
> > > > > > > > presumably a showstopper for statically-linked-uli526x users.  If you could
> > > > > > > > bisect it, please?  I'd start with git-netdev-all, then tulip-*.
> > > > > > > 
> > > > > > > OK, but it'll take some time.
> > > > > > 
> > > > > > OK, done.
> > > > > > 
> > > > > > It's one of these (the first one alone doesn't compile):
> > > > > > 
> > > > > > git-netdev-all.patch
> > > > > > git-netdev-all-fixup.patch
> > > > > > libphy-dont-do-that.patch
> > > 
> > > Hm, all of these patches are the same as in -mm1 which hasn't caused any
> > > problems to appear on this box.
> > > 
> > > So, it seems there's another change between -mm1 and -mm2 that causes this
> > > to happen.
> > > 
> > 
> > It would be nice to eliminate libphy-dont-do-that.patch if poss - that was
> > a rogue akpm patch aimed at some incomprehensible gobbledigook in the
> > netdev tree (and to fix the current_is_keventd-not-exported-to-modules
> > bug).
> 
> Unfortunately the kernel doesn't compile without it ...
> 
> Well, I think I'll try to find the patch that contains the change which has
> triggered this.

It looks like the winner is:

gregkh-driver-driver-core-fixes-sysfs_create_link-retval-checks-in-core.c.patch

Without this patch there are no problems, with this patch applied the problems
(with uli526x, when it's the second interface and the first one is not used)
occur, almost 100% of the time.
