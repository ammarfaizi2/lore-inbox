Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUEWJ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUEWJ61 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEWJ60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:58:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261998AbUEWJ6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:58:24 -0400
Date: Sun, 23 May 2004 11:58:13 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040523095813.GA14170@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <1085296400.2781.2.camel@laptop.fenrus.com> <20040523084415.GB16071@alpha.home.local> <20040523091356.GD5889@devserv.devel.redhat.com> <20040523094853.GA16448@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20040523094853.GA16448@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Sun, May 23, 2004 at 11:48:53AM +0200, Willy Tarreau wrote:
> On Sun, May 23, 2004 at 11:13:56AM +0200, Arjan van de Ven wrote:
> > On Sun, May 23, 2004 at 10:44:15AM +0200, Willy Tarreau wrote:
> > > Hi Arjan,
> > > 
> > > On Sun, May 23, 2004 at 09:13:20AM +0200, Arjan van de Ven wrote:
> > > > on first look it seems to be missing a bunch of get_user() calls and
> > > > does direct access instead....
> > > 
> > > It was intentional for speed purpose. The areas are checked once with
> > > verify_area() when we need to access memory, then data is copied directly
> > > from/to memory. I don't think there's any risk, but I can be wrong.
> > 
> > it's an oopsable offence; nothing is making sure the memory is actually
> > present for example.
> 
> You mean like when a user does a malloc() and the memory is not physically
> allocated because not used yet ? or even in case memory has been swapped
> out ? 

Well both. Or even a stray invalid userspace pointer.

copy_from_user/get_user will catch the trap the cpu will cause in such a
case, and the VM will swap in the page, allocate a new page in case of the
malloc-but-never-used-yet or throw a segmentation fault if the userspace
pointer is broken.

If there is no protection (eg there is no exception handler defined) then
the kernel will throw an oops since it's an uncaught/unhandled kernel mode
exception. Obviously copy_from_user/get_user and co have such exception
handlers defined and will do the expected (right) thing. Direct access does
not.



--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAsHW1xULwo51rQBIRArnjAJ9ss++9/70om+GpTgwTf2CxG5PB1wCfbxtI
hzrz8PjXhi3qzUlfVzAcF5w=
=cant
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
