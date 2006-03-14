Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWCNKi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWCNKi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWCNKi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:38:59 -0500
Received: from lug-owl.de ([195.71.106.12]:40102 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751873AbWCNKi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:38:58 -0500
Date: Tue, 14 Mar 2006 11:38:54 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Message-ID: <20060314103854.GC32065@lug-owl.de>
Mail-Followup-To: Lanslott Gish <lanslott.gish@gmail.com>,
	Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
	Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb <linux-usb-devel@lists.sourceforge.net>,
	tejohnson@yahoo.com, hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <200603112155.38984.daniel.ritz-ml@swissonline.ch> <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com> <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-03-14 09:10:13 +0800, Lanslott Gish <lanslott.gish@gmail.com> =
wrote:
> i fixed some codes and add swap_x & swap_y functions.
> and test your patch passed for my touchset hrdware.
> here is the patch only for your usbtouchscreen.c
> could you help to apply this?
> thank you.
>=20
> Regards,
>=20
> Lanslott Gish
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc6.patched/drivers/usb/input/usbtouchscreen.c
> +++ linux-2.6.16-rc6/drivers/usb/input/usbtouchscreen.c
> @@ -224,13 +224,24 @@
>   * PanJit Part
>   */
>  #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
> +
> +static int swap_x;
> +module_param(swap_x, bool, 0644);
> +MODULE_PARM_DESC(swap_x, "If set X axe is swapped before XY swapped.");
> +static int swap_y;
> +module_param(swap_y, bool, 0644);
> +MODULE_PARM_DESC(swap_y, "If set Y axe is swapped before XY swapped.");
> +
>  static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *=
press)
>  {
> -       *x =3D pkt[1] | (pkt[2] << 8);
> -       *y =3D pkt[3] | (pkt[4] << 8);
> +       *x =3D (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
> +       *y =3D (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);
>         *touch =3D (pkt[0] & 0x01) ? 1 : 0;
>=20
> -       return 1;
> +	if(swap_x) *x =3D *x ^ 0x0FFF;
> +	if(swap_y) *y =3D *y ^ 0x0FFF;
> +
> + 	return 1;
>  }
>  #endif
>=20

Um, I think it's generally a good idea to allow this, but I'd say this
should go into the common code part using the pre-known number range.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEFp0+Hb1edYOZ4bsRAhntAJ9tmcgcvR57teoeJIaJRqxBbrQpoACeNPFE
HrHJmjM0mkN9ZQsvARoLx+0=
=06aU
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
