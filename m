Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290747AbSAYSfd>; Fri, 25 Jan 2002 13:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290773AbSAYSfY>; Fri, 25 Jan 2002 13:35:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43925 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290747AbSAYSfI>; Fri, 25 Jan 2002 13:35:08 -0500
Date: Fri, 25 Jan 2002 11:34:59 -0700
Message-Id: <200201251834.g0PIYxj02545@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Rainer Krienke <krienke@uni-koblenz.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <20020125124110.A357@devserv.devel.redhat.com>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com>
	<200201240858.g0O8wnH03603@bliss.uni-koblenz.de>
	<20020124121649.A7722@devserv.devel.redhat.com>
	<200201250728.g0P7SDH26738@bliss.uni-koblenz.de>
	<20020125124110.A357@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: nfs-list removed from Cc:ed because slow^Wsourcefore has a
broken mail configuration which always bounces my email]

Pete Zaitcev writes:
> > From: Rainer Krienke <krienke@uni-koblenz.de>
> > Date: Fri, 25 Jan 2002 08:28:13 +0100
> 
> > > Rainer, you missed the point. Nobody cares about small things
> > > such as "cannot start nfsd" while your 4096 mounts patch
> > > simply CORRUPTS YOUR DATA TO HELL.
> > 
> > Well I never said, I really knew what I was doing:-).  Thats exacly why I 
> > asked about why to use more major devices? OK the anser to this question 
> > seems to be that minor devices may only be 8 bit due to the static nature of 
> > some kernel structures. Right?
> 
> Close enough... Actual reason is the implementation of MINOR().
> 
> > > If you need more than 1200 mounts, you have to add more majors
> > > to my patch. There is a number of them between 115 and 198.
> > > I suspect scalability problems may become evident
> > > with this approach, but it will work.
> > 
> > The solution Richard posted seems to be interesting at this point isn't it?
> 
> I thought about the rgooch's suggestion, it sounds good for 2.5.
> Red Hat do not ship devfs enabled currently, and I cannot use his
> allocation function if someone uses static majors, or some modules
> may not load. The patch does include a safety element (majorhog_xxx)
> that reserves majors properly. The devfs would make that unnecessary.

The allocation function should be safe, since it only gives majors
which are not assigned in devices.txt. Drivers which statically grab
unassigned majors are broken, and *will* trip over each other at some
point.

As I said before, I can move the major allocation function into a
generic place and not have it depend on CONFIG_DEVFS_FS. So it doesn't
have to matter if RH ship devfs or not.

BTW: please Cc: me, otherwise I may not see responses.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
