Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbSI3JfK>; Mon, 30 Sep 2002 05:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261985AbSI3JfK>; Mon, 30 Sep 2002 05:35:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31837 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261982AbSI3JfJ>; Mon, 30 Sep 2002 05:35:09 -0400
Date: Mon, 30 Sep 2002 10:40:12 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: serial24@macrolink.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
Message-ID: <20020930094012.GC20605@redhat.com>
References: <E17uesu-0002dE-00@mm.lan.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="56p9wBiXEyg+KhLM"
Content-Disposition: inline
In-Reply-To: <E17uesu-0002dE-00@mm.lan.amelek.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--56p9wBiXEyg+KhLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 10:05:16PM +0200, Marek Michalkiewicz wrote:

> below is a patch that moves parport_serial.c from drivers/parport/
> to drivers/char/ - this fixes the wrong link order when the drivers
> are compiled into the kernel.

What was wrong with the original, much smaller patch that you sent me
previously (below)?

I'm happy to accept whichever patch is the better.

Tim.
*/

2002-08-28  Marek Michalkiewicz <marekm@amelek.gda.pl> [sent 2002-08-28]

	* drivers/char/serial.c (register_serial): Call rs_init() if it
	hasn't already been called.  For parport_serial.c.

--- linux/drivers/char/serial.c.init_order	2002-08-28 20:55:10.000000000 +0=
100
+++ linux/drivers/char/serial.c	2002-08-28 21:00:24.000000000 +0100
@@ -254,6 +254,7 @@
=20
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
+static int serial_initialized;
=20
 static struct timer_list serial_timer;
=20
@@ -5385,6 +5386,10 @@
 	int i;
 	struct serial_state * state;
=20
+	if (serial_initialized)
+		return;
+	serial_initialized++;
+
 	init_bh(SERIAL_BH, do_serial_bh);
 	init_timer(&serial_timer);
 	serial_timer.function =3D rs_timer;
@@ -5603,6 +5608,11 @@
 	struct async_struct *info;
 	unsigned long port;
=20
+	if (!serial_initialized) {
+		printk("register_serial(): calling rs_init()\n");
+		rs_init();
+	}
+
 	port =3D req->port;
 	if (HIGH_BITS_OFFSET)
 		port +=3D (unsigned long) req->port_high << HIGH_BITS_OFFSET;

--56p9wBiXEyg+KhLM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9mBv7tO8Ac4jnUq4RAghEAKCRwDknCdy1Rs/uHr/QbFMJPNXjjQCfQOaa
VtD5XBwV1neS83TqHVp8BLw=
=GfHI
-----END PGP SIGNATURE-----

--56p9wBiXEyg+KhLM--
