Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSGYDlm>; Wed, 24 Jul 2002 23:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGYDlm>; Wed, 24 Jul 2002 23:41:42 -0400
Received: from dracula.gtri.gatech.edu ([130.207.193.70]:6828 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP
	id <S317083AbSGYDll>; Wed, 24 Jul 2002 23:41:41 -0400
Date: Wed, 24 Jul 2002 23:43:16 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3-ac2 I2O (Promise SX6000) funkiness
Message-ID: <20020725034316.GA4501@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying to use a Promise SX6000 board.  This one has a 128 meg stick
on it, and five 120 gig drives in a RAID5 configuration.

The array is created and initialized fine (save the 12 hours or so of
incessant beeping by the card..)

I fire up the i2o_pci and i2o_block modules and the card and its array
are detected:

	I2O Core - (C) Copyright 1999 Red Hat Software
	I2O: Event thread created as pid 9
	I2O configuration manager v 0.04.
	  (C) Copyright 1999 Red Hat Software
	Linux I2O PCI support (c) 1999 Red Hat Software.
	i2o: Checking for PCI I2O controllers...
	PCI: Found IRQ 10 for device 00:11.1
	PCI: Sharing IRQ 10 with 00:07.2
	i2o: I2O controller on bus 0 at 137.
	i2o: PCI I2O controller at 0xDA000000 size=3D4194304
	I2O: Promise workarounds activated.
	I2O: MTRR workaround for Intel i960 processor
	i2o/iop0: Installed at IRQ10
	i2o: 1 I2O controller found and installed.
	Activating I2O controllers...
	This may take a few minutes if there are many devices
	i2o/iop0: Reset rejected, trying to clear
	i2o/iop0: LCT has 9 entries.
	i2o/iop0: Configuration dialog desired.
	I2O Block Storage OSM v0.9
	   (c) Copyright 1999-2001 Red Hat Software.
	i2o_block: registered device at major 80  =20
	i2o_block: Checking for Boot device...
	i2o_block: Checking for I2O Block devices...
	i2ob: Installing tid 11 device at unit 0  =20
	i2o/hda: Max segments 28, queue depth 8, byte limit 49152.
	i2o/hda: Type 68: 468987MB, 512 byte sectors.
	i2o/hda: Maximum sectors/read set to 96.  =20
	 i2o/hda: i2o/hda1

So now it's time to create a filesystem.

	mke2fs -j -m -0 /dev/i2o/hda1

It starts out fine, then the console starts spewing these messages after
about 30/2664 inode tables.

	i2o/iop0: No handler for event (0x00000020)
	i2o/iop0: No handler for event (0x00000020)
	i2o/iop0: No handler for event (0x00000020)
	i2o/iop0: No handler for event (0x00000020)
	i2o/iop0: No handler for event (0x00000020)
	...

After I break out of mke2fs, the errors continue for a while, then
change to:

	i2o/iop0: Hardware Failure: Unknown Error =20
	i2o/iop0: Hardware Failure: Unknown Error =20
	i2o/iop0: Hardware Failure: Unknown Error =20
	...
	i2o_post_wait event completed after timeout.
	i2o_post_wait event completed after timeout.
	i2o_post_wait event completed after timeout.
	...
	i2ob_release: controller rejected unclaim.

This happens with 2.4.19rc2aa1 SMP, 2.4.19rc3aa1 SMP.
It also happens with 2.4.19rc3ac2 SMP (with noapic+nosmp, as I have the
endless APIC Error bug with that kernel)=20
And finally, it happens on the "stock" RedHat 2.4.18-5 Uniprocessor kernel.

So, can anyone tell me what's going on here?  Is the controller on the
fritz?  Is the host PC all screwed up?  (memtest86 says the RAM is
likely fine; though the SX6000 provides no means for me to verify it=20
on the card itself)=20

FWIW, this is a newer SX6000 with PDC20276 chips on it, and it's sharing
IRQ10 with the usb controller.  Disabling it makes no difference.

Further details can be provided upon request...

I can move the controller to another machine this weekend for further
testing.  But in the mean time, Just what is event 0x00000020?

I suppose I can call up Promise, but as their driver won't even compile,
I don't have much faith in their ability to do anything but shave a
couple of hours off of my life.

 - Pizza
--=20
Solomon Peachy                                   pizza@f*cktheusers.org
I'm not broke, but I'm badly bent.                         ICQ #1318344
Patience comes to those who wait.                         Melbourne, FL

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9P3PUPuLgii2759ARAmuPAJ91dEl+kQeUAfWIza+T2VIPhvUBcgCfR2RS
MEy1aNv84fLEA2MIh7inZKw=
=0WR4
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
