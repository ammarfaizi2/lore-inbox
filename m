Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUEGU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUEGU1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUEGU0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:26:48 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:649 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263750AbUEGURV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:17:21 -0400
Date: Fri, 7 May 2004 20:11:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Michael Westermann <mw@microdata-pos.de>,
       "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] handshake variable with DTR DSR DCD ...
Message-ID: <20040507181114.GG29503@lug-owl.de>
Mail-Followup-To: Michael Westermann <mw@microdata-pos.de>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20040507165413.D16132@microdata-pos.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CpYjv1NmbuaesVen"
Content-Disposition: inline
In-Reply-To: <20040507165413.D16132@microdata-pos.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CpYjv1NmbuaesVen
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-07 16:54:13 +0200, Michael Westermann <mw@microdata-pos.de>
wrote in message <20040507165413.D16132@microdata-pos.de>:
> diff -Nurp linux-2.4.26.old/drivers/char/serial.c linux-2.4.26/drivers/ch=
ar/serial.c
> --- linux-2.4.26.old/drivers/char/serial.c	2004-02-18 14:36:31.000000000 =
+0100
> +++ linux-2.4.26/drivers/char/serial.c	2004-05-07 16:42:19.000000000 +0200
> @@ -769,9 +769,12 @@ static _INLINE_ void check_modem_status(
>  	}
>  	if (info->flags & ASYNC_CTS_FLOW) {
>  		if (info->tty->hw_stopped) {
> -			if (status & UART_MSR_CTS) {
> +			if (status & info->status_flow) {
>  #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
> -				printk("CTS tx start...");
> +				if (info->status_flow & UART_MSR_CTS)
> +					printk("CTS tx start...");
> +				else=20
> +				    	printk("HW %x tx start...", info->status_flow);

A "\n" is missing here and was already missing in the initial version.

>  #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
> -				printk("CTS tx stop...");
> +				if (info->status_flow & UART_MSR_CTS)
> +				    	printk("CTS tx stop...");
> +				else
> +				    	printk("HW %x tx stop...", info->status_flow);

Dito.

> --- linux-2.4.26.old/include/asm-i386/termbits.h	2000-01-21 01:05:26.0000=
00000 +0100
> +++ linux-2.4.26/include/asm-i386/termbits.h	2004-05-07 16:43:39.00000000=
0 +0200
> @@ -132,6 +132,7 @@ struct termios {
>  #define  B3000000 0010015
>  #define  B3500000 0010016
>  #define  B4000000 0010017
> +#define CHWFLOW   001000000000	/* flexible hw flow_ctrl */
>  #define CIBAUD	  002003600000	/* input baud rate (not used) */
>  #define CMSPAR	  010000000000		/* mark or space (stick) parity */
>  #define CRTSCTS	  020000000000		/* flow control */

> It's only i386 yet, but please comment on it!

I won't comment on the code itself, as I don't know the 2.4.x serial
driver all that good:) Of course, non-i386 code would be cool, too:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--CpYjv1NmbuaesVen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAm9FCHb1edYOZ4bsRAjxCAKCRdx0tWn9mKQTgToEzCiOaj2z5qQCdEC2x
vh0hlGwwHg7MDV2ZqC4IWuE=
=IqSK
-----END PGP SIGNATURE-----

--CpYjv1NmbuaesVen--
