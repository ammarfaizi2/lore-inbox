Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUHCVOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUHCVOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUHCVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:14:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266855AbUHCVO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:14:27 -0400
Date: Tue, 3 Aug 2004 23:13:39 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803211339.GB26620@devserv.devel.redhat.com>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20040803210737.GI2241@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2004 at 11:07:37PM +0200, Andrea Arcangeli wrote:
> On Tue, Aug 03, 2004 at 04:55:49PM -0400, Rik van Riel wrote:
> > @@ -198,9 +201,11 @@
> >  		return error;
> >  	}
> >  
> > -	if (shmflg & SHM_HUGETLB)
> > +	if (shmflg & SHM_HUGETLB) {
> > +		/* hugetlb_zero_setup takes care of mlock user accounting */
> >  		file = hugetlb_zero_setup(size);
> > -	else {
> > +		shp->mlock_user = current->user;
> > +	} else {
> >  		sprintf (name, "SYSV%08x", key);
> >  		file = shmem_file_setup(name, size, VM_ACCOUNT);
> >  	}
> 
> where do you change mlock_user in chown?

ok silly question maybe, but why would you?
The user that mlock'd gets to pay for it, and gets his credits back at
munlock. Chown doesn't really matter in that regard..... The thing that does
matter of course is that the user who "paid" in credits gets them back in
the end.. and that this does.

But maybe you see a useful use pattern that I'm missing? Please convince me :)

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEAACxULwo51rQBIRAgaBAJ9s3RGP3iRHBG2QGu5/l0c60f/7ggCdFAEq
6/uR3bXNONokT/INLIKd4Q0=
=tFTP
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
