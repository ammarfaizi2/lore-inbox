Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKLSlJ>; Sun, 12 Nov 2000 13:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQKLSk7>; Sun, 12 Nov 2000 13:40:59 -0500
Received: from [24.219.13.61] ([24.219.13.61]:3592 "HELO kroah.com")
	by vger.kernel.org with SMTP id <S129055AbQKLSku>;
	Sun, 12 Nov 2000 13:40:50 -0500
Date: Sun, 12 Nov 2000 10:41:12 -0800
From: Greg KH <greg@kroah.com>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: wgreathouse@smva.com, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix compile problem in belkin_sa.c
Message-ID: <20001112104112.A13058@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.14-12 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Here's a patch that fixes the compile time problem in 2.4.0-test11-pre3
for the belkin_sa.c usb serial driver.  It also takes care of the two
compile time warnings.

Thanks,

greg k-h

--=20
greg@(kroah|wirex).com

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-belkin-2.4.0-test11-pre3.diff"
Content-Transfer-Encoding: quoted-printable

diff -Naur -X /home/greg/linux/dontdiff linux-2.4.0-test11-pre3/drivers/usb=
/serial/belkin_sa.c linux-2.4.0-test11-pre3-greg/drivers/usb/serial/belkin_=
sa.c
--- linux-2.4.0-test11-pre3/drivers/usb/serial/belkin_sa.c	Sun Nov 12 10:07=
:33 2000
+++ linux-2.4.0-test11-pre3-greg/drivers/usb/serial/belkin_sa.c	Sun Nov 12 =
10:23:12 2000
@@ -85,13 +85,35 @@
 static int  belkin_sa_ioctl		(struct usb_serial_port *port, struct file * =
file, unsigned int cmd, unsigned long arg);
 static void belkin_sa_break_ctl		(struct usb_serial_port *port, int break_=
state );
=20
+
+static __devinitdata struct usb_device_id id_table_combined [] =3D {
+	{ idVendor: BELKIN_SA_VID,	idProduct: BELKIN_SA_PID },
+	{ idVendor: BELKIN_OLD_VID,	idProduct: BELKIN_OLD_PID },
+	{ idVendor: PERACOM_VID,	idProduct: PERACOM_PID },
+	{ }							/* Terminating entry */
+};
+
+static __devinitdata struct usb_device_id belkin_sa_table [] =3D {
+	{ idVendor: BELKIN_SA_VID,	idProduct: BELKIN_SA_PID },
+	{ }							/* Terminating entry */
+};
+
+static __devinitdata struct usb_device_id belkin_old_table [] =3D {
+	{ idVendor: BELKIN_OLD_VID,	idProduct: BELKIN_OLD_PID },
+	{ }							/* Terminating entry */
+};
+
+static __devinitdata struct usb_device_id peracom_table [] =3D {
+	{ idVendor: PERACOM_VID,	idProduct: PERACOM_PID },
+	{ }							/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, id_table_combined);
+
 /* All of the device info needed for the Belkin serial converter */
-static __u16	belkin_sa_vendor_id	=3D BELKIN_SA_VID;
-static __u16	belkin_sa_product_id	=3D BELKIN_SA_PID;
 struct usb_serial_device_type belkin_sa_device =3D {
 	name:			"Belkin F5U103 USB Serial Adapter",
-	idVendor:		&belkin_sa_vendor_id,		/* the Belkin vendor ID */
-	idProduct:		&belkin_sa_product_id,		/* the Belkin F5U103 product id */
+	id_table:		belkin_sa_table,		/* the Belkin F5U103 device */
 	needs_interrupt_in:	MUST_HAVE,			/* this device must have an interrupt in=
 endpoint */
 	needs_bulk_in:		MUST_HAVE,			/* this device must have a bulk in endpoint =
*/
 	needs_bulk_out:		MUST_HAVE,			/* this device must have a bulk out endpoin=
t */
@@ -111,12 +133,9 @@
=20
=20
 /* This driver also supports the "old" school Belkin single port adaptor */
-static __u16	belkin_old_vendor_id	=3D BELKIN_OLD_VID;
-static __u16	belkin_old_product_id	=3D BELKIN_OLD_PID;
 struct usb_serial_device_type belkin_old_device =3D {
 	name:			"Belkin USB Serial Adapter",
-	idVendor:		&belkin_old_vendor_id,		/* the Belkin vendor ID */
-	idProduct:		&belkin_old_product_id,		/* the Belkin product id */
+	id_table:		belkin_old_table,		/* the old Belkin device */
 	needs_interrupt_in:	MUST_HAVE,			/* this device must have an interrupt in=
 endpoint */
 	needs_bulk_in:		MUST_HAVE,			/* this device must have a bulk in endpoint =
*/
 	needs_bulk_out:		MUST_HAVE,			/* this device must have a bulk out endpoin=
t */
@@ -135,12 +154,9 @@
 };
=20
 /* this driver also works for the Peracom single port adapter */
-static __u16	peracom_vendor_id	=3D PERACOM_VID;
-static __u16	peracom_product_id	=3D PERACOM_PID;
 struct usb_serial_device_type peracom_device =3D {
 	name:			"Peracom single port USB Serial Adapter",
-	idVendor:		&peracom_vendor_id,		/* the Peracom vendor ID */
-	idProduct:		&peracom_product_id,		/* the Peracom product id */
+	id_table:		peracom_table,			/* the Peracom device */
 	needs_interrupt_in:	MUST_HAVE,			/* this device must have an interrupt in=
 endpoint */
 	needs_bulk_in:		MUST_HAVE,			/* this device must have a bulk in endpoint =
*/
 	needs_bulk_out:		MUST_HAVE,			/* this device must have a bulk out endpoin=
t */
@@ -284,7 +300,6 @@
 	struct usb_serial_port *port =3D (struct usb_serial_port *)urb->context;
 	struct belkin_sa_private *priv =3D (struct belkin_sa_private *)port->priv=
ate;
 	struct usb_serial *serial;
-	struct tty_struct *tty;
 	unsigned char *data =3D urb->transfer_buffer;
=20
 	/* the urb might have been killed. */
@@ -360,7 +375,7 @@
 	unsigned int cflag =3D port->tty->termios->c_cflag;
 	unsigned int old_iflag =3D old_termios->c_iflag;
 	unsigned int old_cflag =3D old_termios->c_cflag;
-	__u16 urb_value; /* Will hold the new flags */
+	__u16 urb_value =3D 0; /* Will hold the new flags */
 =09
 	/* Set the baud rate */
 	if( (cflag&CBAUD) !=3D (old_cflag&CBAUD) ) {

--82I3+IH0IqGh5yIs--

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6DuRIMUfUDdst+ykRAh04AJ9YTSKPmoMh+v2kmTs7kjAczUyY9gCgtCJ9
2HFUf5Os7FCaLs6izp9yIEM=
=SrX/
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
