Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVG2EMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVG2EMt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVG2EMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:12:49 -0400
Received: from mx3.mail.ru ([194.67.23.149]:32359 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S261552AbVG2EMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:12:45 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Syncing single filesystem (slow USB writing)
Date: Fri, 29 Jul 2005 08:12:23 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507290731.32694.arvidjaar@mail.ru> <20050728205016.1bdf7288.akpm@osdl.org>
In-Reply-To: <20050728205016.1bdf7288.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart112267880.GVirQ4N2jW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507290812.25976.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart112267880.GVirQ4N2jW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 July 2005 07:50, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > Mandrake always mounted USB sticks with sync option; it was effectively
> > noop except for a patch that implemented limited dsync semantic.
> >
> > Now, when full sync support for FATis in kernel, moutning with sync
> > became real pain. Writing speed dropped from 3MB/s to 30KB/s in my case
> > (and I am not alone).
>
> Unfortunately I think we're just going to have to live with that.  It is
> right that fatfs behaves as it does, and unfortunate that some distros wi=
ll
> operate slowly.
>

Well, I was not going to suggest killing sync support in FAT :)

> For reference: how does mandrake implement this?  Just in /etc/fstab?  How
> should we tell other people to fix this?
>

Yes, just fstab option. It has been "fixed" a couple of days ago by removin=
g=20
sync but I am going to test effect of dsync; it should behave more or less =
as=20
before and provide at least some level of fs consistency.

> > One idea how to improve situation - continue to mount with dsync (having
> > basically old case) and do frequent sync of filesystem (this culd be
> > started as HAL callout or whatever). Unfortunately, I could not find a
> > way to request a sync (flush) of single mount point or block device. Ha=
ve
> > I missed something?
>
> It's trivial to do in-kernel but no, I'm afraid there isn't a userspace
> interface for this.

Oh well, let's do it in kernel to check if it is worth hassle.

Thanks

--nextPart112267880.GVirQ4N2jW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC6aypR6LMutpd94wRAhiYAKDOTFlwZOCtUTp+YohcvSY6/gENjACcCB3A
T6FBtoG9nmJ3pU6aKlvCwNs=
=5jCc
-----END PGP SIGNATURE-----

--nextPart112267880.GVirQ4N2jW--
