Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUGHVLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUGHVLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUGHVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:11:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263001AbUGHVLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:11:03 -0400
Date: Thu, 8 Jul 2004 23:09:26 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040708210925.GA13908@devserv.devel.redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040708205225.GI28324@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 08, 2004 at 10:52:25PM +0200, Adrian Bunk wrote:
> > marked as inline, but there are still cases when it decides not to inline
> > for various reasons.  E.g. in C++ world, lots of things are inline, yet
> > honoring that everywhere would mean very inefficient huge programs.
> > If a function relies for correctness on being inlined, then it should use
> > inline __attribute__((always_inline)).
> 
> include/linux/compiler-gcc3.h says:
> 
> <--  snip  -->
> 
> #if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
> # define inline         __inline__ __attribute__((always_inline))
> # define __inline__     __inline__ __attribute__((always_inline))
> # define __inline       __inline__ __attribute__((always_inline))
> #endif
> 
> <--  snip  -->
> 
> 
> @Arjan:
> This was added as part of your
>   [PATCH] ia32: 4Kb stacks (and irqstacks) patch
> What's the recommended solution for Nigel's problem?

the problem I've seen is that when gcc doesn't honor normal inline, it will
often error out if you always inline....
I'm open to removing the < 4 but as jakub said, 3.4 is quit good at honoring
normal inline, and when it doesn't there often is a strong reason.....

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA7bgExULwo51rQBIRAsMmAKCExdrxDBHibiPGdOzh80DPWWnIDACfQ4e5
wTN4W87l4IOWsebRcYr2d/4=
=Gw6t
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
