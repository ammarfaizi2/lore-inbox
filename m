Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUEQPlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUEQPlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUEQPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:41:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29358 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261680AbUEQPlD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:41:03 -0400
Message-Id: <200405171540.i4HFeuFK003144@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: tglx@linutronix.de
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.26] drivers/char/vt.c fix compiler warnings 
In-Reply-To: Your message of "Mon, 17 May 2004 14:47:56 +0200."
             <200405171447.56737.tglx@linutronix.de> 
From: Valdis.Kletnieks@vt.edu
References: <200405151505.23250.tglx@linutronix.de> <20040517104729.GA8933@wsdw14.win.tue.nl>
            <200405171447.56737.tglx@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1104724183P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 May 2004 11:40:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1104724183P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 17 May 2004 14:47:56 +0200, Thomas Gleixner said:

> Ooops, did not think about that. Was just annoyed from the compiler war=
nings.
> What about:

> +#if MAX_NR_KEYMAPS < 256		=

>  	if (i >=3D NR_KEYS || s >=3D MAX_NR_KEYMAPS)
> +#else
> +	if (i >=3D NR_KEYS)
> +#endif	=

>  		return -EINVAL;	=


Speaking as somebody who's had stuff rejected for doing this sort of ifde=
f'ing,
the *right* fix is to go back and look at the definitions of everything, =
and
see if there's a reason why the compiler is tossing the warning.

Canonical example is, of course the userland:

	char c;
	if ((c=3Dgetc()) !=3D EOF) {....

(I don't have a 2.4 tree handy to double-check, but maybe the variable 's=
'
should be something wider?  It's *quite* possible that there is/will be s=
ome
keyboard of the Chinese/Japanese/Korean persuasion which actually ends up=
 with
more than 256 keymap entries.....




--==_Exmh_1104724183P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAqN0HcC3lWbTT17ARAv2HAJ9s8td4mZ8iOMwxx7V+xk49Tth8gQCg6vxg
wt1AW4MHhc4WkT4HBFkYaNM=
=ov0Y
-----END PGP SIGNATURE-----

--==_Exmh_1104724183P--
