Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVAGAsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVAGAsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVAGAsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:48:01 -0500
Received: from smtp07.auna.com ([62.81.186.17]:31207 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261191AbVAGAqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:46:35 -0500
Date: Fri, 07 Jan 2005 00:46:31 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: i2c: lost sensors with 2.6.10(-mm1)
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com, akpm@osdl.org
X-Mailer: Balsa 2.2.6
Message-Id: <1105058791l.5580l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-et7NTzdsNW97tpX2wlFv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-et7NTzdsNW97tpX2wlFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi...

I have lost my sensors info with 2.6.10, in particular -mm1.
They work fine with 2.6.9-mm1 (current state of the box, booted on
2.6.9 or 10, no other difference).

Some info follows.

With 2.6.9-mm1, I get this:

Module                  Size  Used by
w83627hf               25128  0
i2c_sensor              3456  1 w83627hf
i2c_isa                 2304  0
i2c_i801                7820  0
i2c_dev                 8192  0
i2c_core               19712  5 w83627hf,i2c_sensor,i2c_isa,i2c_i801,i2c_de=
v

sensors:
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.49 V  (min =3D  +1.93 V, max =3D  +1.93 V)
...

With 2.6.10-mm1:

Module                  Size  Used by
w83627hf               24224  0
i2c_sensor              3968  1 w83627hf
i2c_isa                 2304  0
i2c_i801                9996  0
i2c_dev                 8960  0
i2c_core               20992  5 w83627hf,i2c_sensor,i2c_isa,i2c_i801,i2c_de=
v

sensors:
No sensors found!

I have noticed different contents in /sys:
under 2.6.9:
/sys/devices/platform/i2c-1:
/sys/devices/platform/i2c-1/1-0290:
/sys/devices/platform/i2c-1/1-0290/power:
/sys/devices/platform/i2c-1/power:

under 2.6.10:
/sys/devices/platform/i2c-1:
/sys/devices/platform/i2c-1/power:

So some /sys nodes are missing !!!
(the isa bus)


Debug output from 2.6.10-mm1:

Jan  7 01:33:11 werewolf kernel: i2c /dev entries driver
Jan  7 01:33:11 werewolf kernel: i2c-core: driver dev_driver registered.
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: I801 using PCI In=
terrupt for SMBus.
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: SMBREV =3D 0x2
Jan  7 01:33:11 werewolf kernel: i801_smbus 0000:00:1f.3: I801_smba =3D 0x5=
00
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-0: Registered as minor 0
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-0: registered as adapter #=
0
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: Registered as minor 1
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: registered as adapter #=
1
Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa entry =
for adapter 9191, addr 0290
Jan  7 01:33:12 werewolf sensord: sensord started
Jan  7 01:33:12 werewolf lm_sensors: sensord startup succeeded

Some ideas ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-2mdk)) #2


--=-et7NTzdsNW97tpX2wlFv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB3dvnRlIHNEGnKMMRAja2AKCIdXJJqbXwXRgsL/6UW5khm8lAQACghiCk
KRjTKE99LGgKPldc5U0fj8g=
=kBQL
-----END PGP SIGNATURE-----

--=-et7NTzdsNW97tpX2wlFv--

