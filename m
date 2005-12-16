Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVLPO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVLPO1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVLPO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:27:12 -0500
Received: from mxout01.versatel.de ([212.7.152.117]:5290 "EHLO
	mxout01.versatel.de") by vger.kernel.org with ESMTP id S932288AbVLPO1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:27:10 -0500
Date: Fri, 16 Dec 2005 15:26:47 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051216142543.GA20069@zeus.uziel.local>
References: <200512072246.06222.rjw@sisk.pl> <20051210160641.GB5047@elf.ucw.cz> <200512102106.41952.rjw@sisk.pl> <200512102356.27271.rjw@sisk.pl> <20051216020903.GB26568@hexapodia.org> <20051216101623.GA7878@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20051216101623.GA7878@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2005 at 11:16:23AM +0100, Stefan Seyfried wrote:
> This is almost trivially solvable from userspace (not tested, beware :-):
> - check the return code of your write() to /sys/power/state
> - if it is ENOMEM (better look into the kernel code if this is what is
>   actually reported...), then write "0" to image_size and try again.
>=20
> or (not as sophisticated, and i am not sure if the paths are all correct):
> ----
> #!/bin/sh
> echo 150  > /sys/power/image_size
> echo disk > /sys/power/state
> if [ $? -ne 0 ]; then
>     echo 0 > /sys/power/image_size
>     echo disk > /sys/power/state
> fi
> ----
> this will retry on any error (e.g. process not stopped, no swap space
> at all, device refused to suspend...) not only on ENOMEM, but echo
> unfortunately does not return the error code, only success or failure.
> Easy solution would be a small perl or C program.
>=20
> I am not convinced that this should be handled in the kernel.

I do not see a horrific logical problem here, given that the maximum
desired image size is the minimum of max_image_size and free swap space
available. The main question is the one of implementation, though.

Yours,
Chris


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ6LOp12m8MprmeOlAQKHVBAAstBrxobbzn/L0BaNTKIr/uKcn0Wq9QOG
sRE/q4iGlYYV5NtUFrUSOxH3ZRt/ThMXMU0K9YDsYAcOHDiGTGJAEiWeP504qazy
Px2p41Vjd3/iBVbiq7bOfQTnAFwOwIZrnYi9JgfjojvA3Xj8qQEpmEjuZ3N2dsL4
9WeOfiRCqILTLXxQxhehFxj+3nfUbN4mebGyWLzv2Ypr4NbPUS4CqKzgFactrLDM
b+Jc7KXcGIxABQAO+Vw8ynqa8TI6v/Bb3t/xhae3HFbBdn1dWhM3cxHd6+Aq0Me7
tU9SiNcLGxy6KqVOvMcwDZ1ZFxsFTtYzrv6yGDf5S/nuww1SbAwOLeDEPDFr/Rnb
ZRHukqLJk1BcnUuMOEClpkkueTndfl12oMTT9S/vuN96TvBevIFMHb2dDgIUVBP1
ijpzcOkTYAwVAtRclzGelNgDfmp0FjIwO7e3rwbzMl+zrOUs68kRLqrMRDPeTWgi
Y2h5M5djxp8pcnXYPYE0A2bdvxLGEmSNhSToWmV6xtX0Z/1c0C0+4yNjk3t1ofbd
RZGX80PivbWj7CLCbAgs7WdAAGXcvBVZyTD2YBGW1g6e7VstNQtAQRuNruqdQwBN
8UVgYTvsqTOWNrJ3tlwLhPF9AFDBwfLBvwYtrjHUOnCHfhvypL5lgRHqlVude1iu
e4yEmOLeU18=
=xAAW
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

