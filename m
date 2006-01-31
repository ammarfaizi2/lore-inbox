Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWAaD2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWAaD2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWAaD2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:28:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55974 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030297AbWAaD2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:28:17 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Tue, 31 Jan 2006 13:24:34 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034539.3178.56611.stgit@localhost.localdomain> <200601302305.18202.rjw@sisk.pl>
In-Reply-To: <200601302305.18202.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1584366.9XBjUQl9ty";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601311324.38149.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1584366.9XBjUQl9ty
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 31 January 2006 08:05, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> > Disable usermode helper invocations when the freezer is on. This avoids
> > deadlocks due to hotplug events occuring while processes are frozen.
> >
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> >
> >  kernel/kmod.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > index 51a8920..12afa2c 100644
> > --- a/kernel/kmod.c
> > +++ b/kernel/kmod.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/mount.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > +#include <linux/freezer.h>
> >  #include <asm/uaccess.h>
> >
> >  extern int max_threads;
> > @@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
> >  	if (!khelper_wq)
> >  		return -EBUSY;
> >
> > +	if (freezer_is_on())
> > +		return 0;
> > +
> >  	if (path[0] =3D=3D '\0')
> >  		return 0;
>
> Disabling the usermode helper while freeze_processes() is executed seems =
to
> be a good idea to me, but I think it should be done with a mutex or
> something like that.

With the refrigerator code you guys are using at the moment, ouldn't that=20
result in deadlocks when we later try to freeze the process in preparation=
=20
for the atomic restore? (Or perhaps you don't freeze processes at that=20
point?)

Regards,

Nigel

> Greetings,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1584366.9XBjUQl9ty
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3th2N0y+n1M3mo0RAt0LAKCOw29EP4jNmRHVrJRo5I5YxbrFkACg8mGr
Y2vIcdcqZYdlMACB28qc8sg=
=bauA
-----END PGP SIGNATURE-----

--nextPart1584366.9XBjUQl9ty--
