Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUITMIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUITMIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUITMIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:08:17 -0400
Received: from grendel.firewall.com ([66.28.58.176]:11927 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S266344AbUITMIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:08:12 -0400
Date: Mon, 20 Sep 2004 14:08:05 +0200
From: Marek Habersack <grendel@caudium.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG() triggerred by Tux
Message-ID: <20040920120805.GB4545@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20040915185230.GA4502@beowulf.thanes.org> <20040916220938.GB752@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20040916220938.GB752@MAIL.13thfloor.at>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 17, 2004 at 12:09:38AM +0200, Herbert Poetzl scribbled:
> On Wed, Sep 15, 2004 at 08:52:30PM +0200, Marek Habersack wrote:
> > Hello,
> >=20
> >   I realize that this question might be out of topic for this list, but
> > since I've already tried to get help from the Tux mailing list and had =
no
> > response, I'm hoping I will find some guidance here. The bug can be
> > triggerred very easily by installing and using the demo4.c module shipp=
ed
> > with the tux userland (tested with the 3 last versions of the Tux patch=
 for
> > both 2.4 and the 2.6 kernels). BUG() gets called when the request is
> > redirected by Tux to the userland server and _after_ the latter handles=
 the
> > connection and delivers the content to the browser. Here's the message:
> >=20
> > Sep 15 12:39:30 quantum kernel: ------------[ cut here ]------------
> > Sep 15 12:39:30 quantum kernel: kernel BUG at fs/inode.c:1098!
> 						~~~~~~~~~~~~~~~
> check what's at this location in your kernel source
> this will probably provide information what went
> wrong there ...
That was the first thing I did, here's the code:

        if (inode->i_state & I_CLEAR)
                BUG();

And the inode of the file tux is trying to close is indeed cleared before.
Tux's tux_close() routine implements basically what sys_close does and the
error happens when filp_close calls fput on the file structure passed from
tux_close. Replacing the tux version of sys_close with a call to the latter
gives the same effect, so the error is either before the code or after that,
but I'm still quite lost in all the filesystem code...

thanks for help,

marek

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBTsglq3909GIf5uoRAjaGAKCAVjHkTwiN1txGzsdYZ/Jq1J5SSQCcD8m1
rNMSXd5K3eiwtEwdbOa5JsM=
=sUkf
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
