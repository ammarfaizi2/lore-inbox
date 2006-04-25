Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWDYQ0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWDYQ0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWDYQ0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:26:00 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:46241 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751582AbWDYQZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:25:59 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Olivier Galibert <galibert@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424140831.GA94722@dspnet.fr.eu.org>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424124556.GA92027@dspnet.fr.eu.org>
	 <1145883251.3116.27.camel@laptopd505.fenrus.org>
	 <20060424140831.GA94722@dspnet.fr.eu.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 12:29:26 -0400
Message-Id: <1145982566.21399.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 16:08 +0200, Olivier Galibert wrote:
> On Mon, Apr 24, 2006 at 02:54:10PM +0200, Arjan van de Ven wrote:
> > 
> > > While that may be true[1], it gets a little annoying when broken is
> > > meant to be synonymous to "not the SELinux model".  Especially since
> > > there are aspects where SELinux' security can be considered broken,
> > > complexity being one of them, crappy failure modes being another,
> > > handling of new files a third, handling of namespaces a fourth.
> > 
> > while I agree with the first three arguments, handling of namespaces
> > isn't  fundamental SELinux weakness.
> 
> I'm not sure.  It's linked to the "new files" problem.
> Object-labelling security (be it inodes, attributes, whatever) are
> good to protect specific objects, but it sucks on two points:
> - new objects can have an incorrect by-default labels

This generally indicates a problem in policy or the application that
needs to be fixed.  It doesn't mean that object labeling is itself
problematic, anymore than the existing owner and mode information in the
inode is inherently problematic.

> - applications don't address objects directly, but by one of their
>   names, the paths
> 
> Path-based security does not protect objects, it protects what you
> access through the names, whether there are associated objects or not.
> So in practice path security protects the behaviour of applications
> against mucking with the filesystem, while object labelling protects
> the contents of the files.  They're complementary, they need each
> other in practice.

Object labeling achieves both.  It doesn't require a path-based
mechanism in the kernel.

> It's more robust at protecting objects contents, it's less robust at
> protecting application behaviour.  A lot like GR and QM, the best
> model is somewhere in the middle :-)

How is it less robust?  I haven't seen such an argument.

> For now if I follow correctly the LSM interfaces are decent for
> object-based policy implementations, and not decent for path-based
> ones.

Yes.

>   Maybe the object-based policy hooks should be evolving in the
> direction of SELinux' comfort, and additional hooks specifically for
> path-based policy added, probably along the lines of what AppArmor
> needs.  Then hopefully someday someone will build a security system
> that uses the best features from both.  But refusing path-based policy
> in the kernel for religious reasons would be annoying.

I don't think it is religious - it has to do with the kernel's internal
model and what makes sense for the kernel to implement.  And the
question is not whether policy can/should be path-based; it is whether
the kernel mechanism should be path-based.  And further, whether even
such a path-based kernel mechanism should be done in the manner in which
AppArmor does it.  Bad example, I suppose, but consider inotify - does
it regenerate pathnames in the kernel, and use those pathnames in its
own mechanism?

-- 
Stephen Smalley
National Security Agency

