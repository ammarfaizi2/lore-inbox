Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWDYW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWDYW0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWDYW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:26:45 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:3340 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932226AbWDYW0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:26:43 -0400
Date: Wed, 26 Apr 2006 00:26:42 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060425222642.GA4921@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org> <20060424140831.GA94722@dspnet.fr.eu.org> <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:29:26PM -0400, Stephen Smalley wrote:
> On Mon, 2006-04-24 at 16:08 +0200, Olivier Galibert wrote:
> > On Mon, Apr 24, 2006 at 02:54:10PM +0200, Arjan van de Ven wrote:
> > > 
> > > > While that may be true[1], it gets a little annoying when broken is
> > > > meant to be synonymous to "not the SELinux model".  Especially since
> > > > there are aspects where SELinux' security can be considered broken,
> > > > complexity being one of them, crappy failure modes being another,
> > > > handling of new files a third, handling of namespaces a fourth.
> > > 
> > > while I agree with the first three arguments, handling of namespaces
> > > isn't  fundamental SELinux weakness.
> > 
> > I'm not sure.  It's linked to the "new files" problem.
> > Object-labelling security (be it inodes, attributes, whatever) are
> > good to protect specific objects, but it sucks on two points:
> > - new objects can have an incorrect by-default labels
> 
> This generally indicates a problem in policy or the application that
> needs to be fixed.  It doesn't mean that object labeling is itself
> problematic, anymore than the existing owner and mode information in the
> inode is inherently problematic.

Default owner and mode are handled by the kernel because otherwise it
would indeed be inherently problematic.  Don't expect normal
applications, editors or xml libraries to change from the normal
open(fname, O_RDWR|O_CREAT|O_TRUNC, 0666).  SELinux is not, and will
not, ever, be their problem.


> > - applications don't address objects directly, but by one of their
> >   names, the paths
> > 
> > Path-based security does not protect objects, it protects what you
> > access through the names, whether there are associated objects or not.
> > So in practice path security protects the behaviour of applications
> > against mucking with the filesystem, while object labelling protects
> > the contents of the files.  They're complementary, they need each
> > other in practice.
> 
> Object labeling achieves both.

In your dreams.


> I don't think it is religious - it has to do with the kernel's internal
> model and what makes sense for the kernel to implement.  And the
> question is not whether policy can/should be path-based; it is whether
> the kernel mechanism should be path-based.

"The" kernel mechanism?  The point of LSM is that there wasn't to be
one official and unique kernel mechanism.  You alternating between
"this is not acceptable because it is not SELinux" and "this is not
acceptable because it can be done with SELinux" gets a little tiring.


> And further, whether even
> such a path-based kernel mechanism should be done in the manner in which
> AppArmor does it.  Bad example, I suppose, but consider inotify - does
> it regenerate pathnames in the kernel, and use those pathnames in its
> own mechanism?

The implementation sucks, news at eleven.  At that point SELinux sucks
too, only differently, and don't even protect what is really
important[1].  Anyway, LSM is lacking path-based hooks, they should be
added in a reasonable fashion that indeed do not require regenerating
the paths or horribly slowing down hotpath code.

  OG.

[1] User data.  Because / is only a reinstall away.
