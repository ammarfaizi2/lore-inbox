Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUG1Mlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUG1Mlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUG1Mll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:41:41 -0400
Received: from lists.us.dell.com ([143.166.224.162]:55218 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266895AbUG1MlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:41:19 -0400
Date: Wed, 28 Jul 2004 07:40:10 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Balazic <david.balazic@hermes.si>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040728124010.GA16423@lists.us.dell.com>
References: <B1ECE240295BB146BAF3A94E00F2DBFF0901F6@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF0901F6@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2004 at 02:16:19PM +0200, David Balazic wrote:
> The same delay as before.
>=20
> I built 2.6.8-rc1 first, then patched and issued a "make bzImage";
> maybe it did not compile all the new stuff ?

No, it didn't work for Jeff either, and I've been gone on vacation/OLS
the past couple weeks, just now getting back into normal work mode.  I
haven't forgotten about you.

The crazy thing is, the early real mode code has issued a "Get Disk
Type" (int13 fn15) command for ages, so I suspect it's not being slow for
disk 80 or 81, but for one of the higher values.  From setup.S:

# Check that there IS a hd1 :-)
        movw    $0x01500, %ax
        movb    $0x81, %dl
        int     $0x13
        jc      no_disk1
        cmpb    $3, %ah
        je      is_disk1

This is all I was trying to accomplish with that test patch.

David, you had said before that by downgrading your BIOS you no longer
saw the delay.  Is this not still true?

You also mentioned that Grub made different calls.  I'll check that
out too.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBB56qIavu95Lw/AkRAvjDAKCT6nCybJa4OX6JMLpJXb1++g4vBwCfYDY3
LT7cZTbYHhkg12+mpYe74bI=
=m6tZ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
