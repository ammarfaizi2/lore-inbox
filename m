Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUASRwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUASRwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:52:13 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:29363 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261879AbUASRuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:50:37 -0500
Date: Tue, 20 Jan 2004 06:56:04 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Help port swsusp to ppc.
In-reply-to: <1074490463.10595.16.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074534964.2505.6.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-OJiUoqa4Dv1i4/YUjPz8";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040119105237.62a43f65@localhost>
 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
 <1074490463.10595.16.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OJiUoqa4Dv1i4/YUjPz8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, 2004-01-20 at 00:39, Benjamin Herrenschmidt wrote:
> I see no reason why this would be needed on ppc, only the last step,
> that is the actual CPU state save, should matter.

Besides saving the CPU state, the code copies the original kernel back.
It sort of defeats the purpose to remove that code :>

> That's very hairy... You basically assume the boot kernel and the
> restore kernel are completely identical, which isn't something I would
> do. I didn't have time to dive into it, but I do/did intend to implement
> swsusp on ppc and I would eventually resume the whole environement
> straight from the bootloader without kernel help.

Well, the whole things is pretty hairy :> But I don't think there's
anything wrong with assuming the boot and restored kernels are
identical. After all, we're calling it suspending and resuming, not
kexec. It does sound nice to do it all from the bootloader without
kernel help.

> If you want to pass some infos between the "loader" kernel and the "loade=
d"
> one, I strongly suggest you define some well specified interface for doin=
g
> so that is immune to kernel versions.

It is a well defined interface: a section of memory marked nosave, with
variables given the matching attribute. Not my idea, by the way. If you
have a problem, you should be taking it up with Pavel or Linus. We
should also note that the interface can't be too well defined - there
has to be room for development over time.

> Also, I haven't looked in details, but when switching to the "new" kernel
> from the "loader" (boot) one, do you shut down all devices properly ?
> This switch could actually be fairly similar to a kexec pass in this
> regard.

Yes. we device_suspend. Regarding the similarities with kexec, I fully
agree. In fact, there is also LKCD to think off. There should be a
synergy here.

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-OJiUoqa4Dv1i4/YUjPz8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADBozVfpQGcyBBWkRAvAgAKCV4WNFALcU3nmzRAmV1I4CDUcTpwCfexbf
/Vk7YihfcJa4ZVmGiQUSx1g=
=COAG
-----END PGP SIGNATURE-----

--=-OJiUoqa4Dv1i4/YUjPz8--

