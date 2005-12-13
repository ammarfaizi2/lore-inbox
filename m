Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVLMNt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVLMNt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLMNt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:49:28 -0500
Received: from smtp06.auna.com ([62.81.186.16]:6620 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S932236AbVLMNt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:49:27 -0500
Date: Tue, 13 Dec 2005 14:51:12 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm1
Message-ID: <20051213145112.46301af0@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.44L0.0512122241270.17181-100000@netrider.rowland.org>
References: <20051212145845.7a76da76.akpm@osdl.org>
	<Pine.LNX.4.44L0.0512122241270.17181-100000@netrider.rowland.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc2 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_w=/criyvOxo37UQ.6eF7_rS";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Tue, 13 Dec 2005 14:49:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_w=/criyvOxo37UQ.6eF7_rS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Dec 2005 22:44:57 -0500 (EST), Alan Stern <stern@rowland.harvard=
.edu> wrote:

> On Mon, 12 Dec 2005, Andrew Morton wrote:
>=20
> > "J.A. Magallon" <jamagallon@able.es> wrote:
> > >
> > > > Sorry for the delay. I'm just compiling all rcs from rc2 to rc5 and=
 will
> > > > try to boot whith them.
> > > >=20
> > > > For the rest of your questions:
> > > > - I have no /etc/udev/agents.d/usb/usbcore
> > > > - I have killed all the devfs compat scripts/rules (BTW, when will =
be finally
> > > >   erradicated from  udev ;) ?
> > > > - Distro: Mandriva Cooker, updated daily, udev-077 now (the hangs I=
 reported
> > > >   were with 075).
> > > >=20
> > > > More info soon...
> > > >=20
> > >=20
> > > No problems with plain rc5. It does not seem to _always_ happen on -m=
m1,
> > > I thing I even got a clean boot, but just one.=20
> > > Detailed oops screenshot is here:
> > >=20
> > > http://belly.cps.unizar.es/~magallon/oops/oops.jpg
> > >=20
> >=20
> > Thanks for that.
> >=20
> > Let's add the usb list..
>=20
> Uh-oh.  Looks like this one was my fault...  Clashing uses of a local=20
> variable.  :-(
>=20
> Does this patch fix it?
>=20
> Alan Stern
>=20
>=20
>=20
> Index: usb-2.6/drivers/usb/core/message.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-2.6.orig/drivers/usb/core/message.c
> +++ usb-2.6/drivers/usb/core/message.c
> @@ -1387,11 +1387,11 @@ free_interfaces:
>  	if (dev->state !=3D USB_STATE_ADDRESS)
>  		usb_disable_device (dev, 1);	// Skip ep0
> =20
> -	n =3D dev->bus_mA - cp->desc.bMaxPower * 2;
> -	if (n < 0)
> +	i =3D dev->bus_mA - cp->desc.bMaxPower * 2;
> +	if (i < 0)
>  		dev_warn(&dev->dev, "new config #%d exceeds power "
>  				"limit by %dmA\n",
> -				configuration, -n);
> +				configuration, -i);
> =20
>  	if ((ret =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
>  			USB_REQ_SET_CONFIGURATION, 0, configuration, 0,
>=20

Bingo! This corrected the problem. I applied it to rc5-mm2 and booted nicel=
y.
One less bug.

A side question. Are this messages dangerous ?

hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xed200000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb 1-1: unable to read config index 0 descriptor/all
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
usb 1-1: can't read configurations, error -71
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected

lspci:
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI =
Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI =
Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI =
Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI =
Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI=
 Controller (rev 02)


Thanks for all.

But don't be too happy, I have a couple things in the queue, like SMP
kernel not booting with 'nosmp' :).

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-rc5-mm2 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006=
.1))

--Sig_w=/criyvOxo37UQ.6eF7_rS
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDntHQRlIHNEGnKMMRAoynAJwLYbqY9axU/MUt7dVXjQG55Sk5aACcCYgD
Wm/GzylSCSPy1kb6pzGh53Q=
=OZT2
-----END PGP SIGNATURE-----

--Sig_w=/criyvOxo37UQ.6eF7_rS--
