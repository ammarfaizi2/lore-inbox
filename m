Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUGJGdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUGJGdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUGJGdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:33:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56491 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266163AbUGJGdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:33:12 -0400
Date: Sat, 10 Jul 2004 08:31:34 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040710063134.GA8267@devserv.devel.redhat.com>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com> <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au> <20040709062403.GA15585@devserv.devel.redhat.com> <20040710012117.GA28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20040710012117.GA28324@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 10, 2004 at 03:21:17AM +0200, Adrian Bunk wrote:
> > one thing to note is that you also need to monitor stack usage then :)
> > inlining somewhat blows up stack usage so do monitor it...
> 
> How could inlining increase stack usage?

void foo1(void)
{
	char array[200];
	do_something(array);
}

void foo2(void)
{
	char other_array[200];
	do_somethingelse(other_array);
}

void function_to_which_they_inline(void)
{
	foo1();
	foo2();
}

(assume the do_* functions get inlined into foo or are defines or whatever)

without inlining it's clear that the max stack usage is 200, the lifetimes
of the 2 arrays are 100% exclusive.

With inlining, gcc reorders instructions in it's optimisation passes, and as
a result the lifetimes of the 2 arrays no longer are exclusive and as a
result gcc has no choice to have both separately on the stack.


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA741GxULwo51rQBIRArEcAJ9/pQkgQ4fRJEnGSfjW/dFYagEetwCcDRq4
SwKIfx1v1qBK5WMft3Yqi24=
=uE9U
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
