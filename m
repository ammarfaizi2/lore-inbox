Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTIXNMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTIXNMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:12:51 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:7410 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261346AbTIXNKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:10:38 -0400
Subject: Re: [PATCH] autofs4 deadlock during expire - kernel 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <Pine.LNX.4.44.0309242059120.4975-100000@raven.themaw.net>
References: <Pine.LNX.4.44.0309242059120.4975-100000@raven.themaw.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q+31+NTK/aqQ7VVAJFPi"
Organization: Red Hat, Inc.
Message-Id: <1064408962.5074.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 24 Sep 2003 15:09:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q+31+NTK/aqQ7VVAJFPi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-24 at 15:01, Ian Kent wrote:
> This is a corrected patch for the autofs4 daedlock problem I posted about=
=20
> @@ -206,6 +207,11 @@
> =20
>  		interruptible_sleep_on(&wq->queue);
> =20
> +		if (waitqueue_active(&wq->queue) && current !=3D wq->owner) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(wq->wait_ctr * (HZ/10));
> +		}
> +

this really really looks like you're trying to pamper over a bug by
changing the timing somewhere instead of fixing it...

also are you sure the deadlock isn't because of the racey use of
interruptible_sleep_on ?

--=-Q+31+NTK/aqQ7VVAJFPi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/cZeCxULwo51rQBIRAkDHAJ4qCLI7pnWgAclLCYY1SGcdAW8pigCgjSCT
G07Mo5b63x517h+48RMPTjw=
=kfzT
-----END PGP SIGNATURE-----

--=-Q+31+NTK/aqQ7VVAJFPi--
