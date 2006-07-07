Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWGGVXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWGGVXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGGVW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:22:59 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30908 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932224AbWGGVW6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:22:58 -0400
Message-Id: <200607072122.k67LMjfL004124@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6 libata stupid question...
In-Reply-To: Your message of "Fri, 07 Jul 2006 17:12:01 BST."
             <1152288721.20883.12.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <200607070428.k674S8Rf005209@turing-police.cc.vt.edu>
            <1152288721.20883.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152307365_2951P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 17:22:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152307365_2951P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jul 2006 17:12:01 BST, Alan Cox said:

> The fact you get the same response with drivers/ide rather suggests that
> in this case the problem is cable detection. Tweak ata_piix to print out
> the cable type it detects. If it thinks its a 40 pin cable you know
> where to start

I tried instrumenting ich_pata_cbl_detect(), but it turns out that
the chipset is an ICH3M (lspci ID 8086:248A), which ends up down in
piix_pata_prereset which forces a 40-pin:

        ap->cbl = ATA_CBL_PATA40;

Guess that explains that, unless the chipset actually *can* do 80-pin
and has an 80-pin cable (which would be surprising because apparently
none of the other piix variants can...)


--==_Exmh_1152307365_2951P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErtClcC3lWbTT17ARAvpvAJ0TiIcIhTBlBEewB5QmIsZEArpn9gCg/JpB
b0hSZLw6Om4iJ95SA0gg4kU=
=hGHk
-----END PGP SIGNATURE-----

--==_Exmh_1152307365_2951P--
