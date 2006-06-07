Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWFGAMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWFGAMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWFGAMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:12:46 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:46511 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751394AbWFGAMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:12:45 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 10:13:49 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>, ak@suse.de,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606070938.34927.ncunningham@linuxmail.org> <44861899.1040506@goop.org>
In-Reply-To: <44861899.1040506@goop.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6354209.OMtpVjPVgC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071013.53490.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6354209.OMtpVjPVgC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 07 June 2006 10:06, Jeremy Fitzhardinge wrote:
> Nigel Cunningham wrote:
> > * Driver suspend and resume calls should only handle cpu0, and should n=
ot
> > touch other processors. The same semantics regarding hardware state and
> > values of variables apply here.
>
> Isn't the trouble that in this case, the devices themselves are the
> CPUs, and so the CPUs themselves need to operate on their own state?
>
> Or perhaps, to look at it another way, suspend/resume is just a special
> case of:
>
>    1. unplug cpus 1-N
>    2. [something]
>    3. re-plug cpus 1-N
>
> where [something] in this case is "suspend cpu0".
>
> But the problem is that there's nothing which keeps track of whether the
> re-plugged cpus 1-N are the "same" as the unplugged 1-N, and so nothing
> can apply the same per-cpu settings to them.  In the suspend/resume case
> they clearly are, but in the general remove/add case, do you really want

It's probably safter to say "In the suspend/resume case, they may well be."=
=20
It's not inconceivable that a system could be suspended, a faulty cpu=20
replaced with another, and the system resumed. Hotplugging ought to handle=
=20
that nicely.

> the new CPU to get the same state as the old one just because it ends up
> with the same logical CPU number?  Perhaps, but what if it doesn't even
> have the same capabilities?  (Do we support heterogeneous CPUs anyway?)

Indeed. I'm also not sure that there's necessarily a guarantee that cpus wi=
ll=20
be hotplugged in the same order. Perhaps those with more knowledge can=20
clarify there.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart6354209.OMtpVjPVgC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhhpBN0y+n1M3mo0RAkr3AKCihwppF3OaGXotxShoSGuZ5uBVdgCgxQ4N
QPe/CZ+RVf+1BQEu6CkpgZY=
=Rb/v
-----END PGP SIGNATURE-----

--nextPart6354209.OMtpVjPVgC--
