Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUANUI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUANUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:07:53 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:30853 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263544AbUANUHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:07:11 -0500
Date: Thu, 15 Jan 2004 08:47:13 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
In-reply-to: <400564AD.6050407@tiscali.it>
To: Mauro Andreolini <m.andreolini@tiscali.it>
Cc: Daniele Venzano <webvenza@libero.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074109633.2189.59.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-6HhaMuTTiSwvCJAgPv1s";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <3FE5F1110001ED59@mail-4.tiscali.it>
 <20040113131806.GA343@elf.ucw.cz>
 <20040113212811.GA12144@gateway.milesteg.arr> <400564AD.6050407@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6HhaMuTTiSwvCJAgPv1s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I think you'll find that the 'bad: scheduling while atomic' reports are
completely unrelated to whether the drivers works after suspend or not;
they simply reflect that drivers_resume is being called with
preempt_count > 0 (IRQs/preempt not reenabled after copying the image or
fpu not released).

Regards,

Nigel

On Thu, 2004-01-15 at 04:47, Mauro Andreolini wrote:
> Daniele Venzano wrote:
>=20
>  >
>  >I added support for sis900 and the bash was being killed even before th=
e
>  >driver had any support for suspend/resume.
>  >I reported that same problem (shell being killed) some time ago, there=20
> was
>  >some follow up, but if I remember right no solution was found at the
>  >time.
>  >
>  >>>bad: scheduling while atomic!
>  >>>Call Trace:
>  >>> [<c0119d16>] schedule+0x586/0x590
>  >>> [<c0124f5c>] __mod_timer+0xfc/0x170
>  >>> [<c0125ab3>] schedule_timeout+0x63/0xc0
>  >>> [<c0125a40>] process_timeout+0x0/0x10
>  >>> [<c01da44b>] pci_set_power_state+0xeb/0x190
>  >>> [<ec947823>] sis900_resume+0x63/0x130 [sis900]
>  >>> [<c01dc9a6>] pci_device_resume+0x26/0x30
>  >
>  >
>  >I'll check this, the card keeps working after resume or not ?
>  >
>  >Thanks, bye.
>  >
> Hi Daniele,
>=20
> the card does _not_ work after resume, both on 2.6.1-rc2 vanilla and=20
> with Pavel's patch.
> I have to manually
>=20
> rmmod sis900
> modprobe sis900
> ifconfig <ip> eth0 up
>=20
> After that, it starts working again.
>=20
> Bye
> Mauro Andreolini
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-6HhaMuTTiSwvCJAgPv1s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABZzBVfpQGcyBBWkRAhPXAKChk7jWEVvy7w2J2ml/F0S+6s2E/ACghviF
Bgo8CSXA3RQsQTJoFrfe6gM=
=a/K/
-----END PGP SIGNATURE-----

--=-6HhaMuTTiSwvCJAgPv1s--

