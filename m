Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBMQAL>; Wed, 13 Feb 2002 11:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBMQAF>; Wed, 13 Feb 2002 11:00:05 -0500
Received: from hal.astro.umn.edu ([128.101.221.100]:3495 "EHLO astro.umn.edu")
	by vger.kernel.org with ESMTP id <S287306AbSBMP7y>;
	Wed, 13 Feb 2002 10:59:54 -0500
Date: Wed, 13 Feb 2002 09:59:48 -0600
From: kelley eicher <carde@astro.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: scsi abort 0x2002 and eth0: too much work on a dual amd 760mpx system
Message-ID: <20020213095948.B12860@astro.umn.edu>
In-Reply-To: <20020211120227.B5908@astro.umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211120227.B5908@astro.umn.edu>; from carde@astro.umn.edu on Mon, Feb 11, 2002 at 12:02:27PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

low and behold, i found that this was all caused by improper scsi terminati=
on
which i'm sort of suprised at because the controller didn't bitch about it
at boot while initializing. <shrug>

-kelley


On Mon, Feb 11, 2002 at 12:02:27PM -0600, kelley eicher wrote:
> i'm having some problems with the 2.4.17 linux kernel on a dual athlon
> system that i was hoping someone could shed some light on. there seem
> to be multiple problems so i'm not quite sure which path to follow at this
> point.
>=20
> the scenario is that i have a system with the following hardware:
>=20
> # awk '/\(/' /proc/pci
>     Host bridge: PCI device 1022:700c (Advanced Micro Devices [AMD]) (rev=
 17).
>     PCI bridge: PCI device 1022:700d (Advanced Micro Devices [AMD]) (rev =
0).
>     ISA bridge: Advanced Micro Devices [AMD] AMD-768 [??] ISA (rev 4).
>     IDE interface: Advanced Micro Devices [AMD] AMD-768 [??] IDE (rev 4).
>     Bridge: Advanced Micro Devices [AMD] AMD-768 [??] ACPI (rev 3).
>     SCSI storage controller: Adaptec 7892A (rev 2).
>     PCI bridge: Advanced Micro Devices [AMD] AMD-768 [??] PCI (rev 4).
>     VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 13=
3).
>     Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev=
 116).
>=20
> while this machine is at work i see aic7xxx_abort errors in dmesg from ti=
me
> to time during heavy i/o. interestingly, this does not crash the machine =
or
> the devices in question but recovers with an aic7xxx_dev_reset instruction
> after 1-2 minutes of abort attempts.
>=20
> during the time between the apparent scsi failures i see a few error
> messages in the form of 'eth0: Too much work in interrupt, status e401.'
>=20
> looking at /proc/interrupts i see that indeed, the eth0 device is hard at
> work.
>=20
> # cat /proc/interrupts
>            CPU0       CPU1      =20
>   0:   33669019   33490567    IO-APIC-edge  timer
>   1:      19117      19797    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>  10:   32635348   32632811   IO-APIC-level  eth0
>  11:     381721     381874   IO-APIC-level  aic7xxx
>  14:     236054     249997    IO-APIC-edge  ide0
>  15:          0          6    IO-APIC-edge  ide1
> NMI:          0          0=20
> LOC:   67153036   67153815=20
> ERR:          0
> MIS:         32
>=20
> i have researched the 'eth0: Too much work in interrupt, status e401.' a =
bit
> and found that it is possible to increase the threshold for which these
> errors will be printed. i did not attempt this because it does not seem t=
hat
> it should be a solution to this problem but more of a crutch. i.e. bad th=
ings
> still happen, you just don't see them.=20
>=20
> another reason i refrained from making any adjustments to settings for the
> driver is that i have an almost identical system in a very similar load
> and role that exhibits *none* of the problems mentioned.=20
>=20
> # awk '/\)/' /proc/pci
>     Host bridge: PCI device 1022:700c (Advanced Micro Devices [AMD]) (rev=
 17).
>     PCI bridge: PCI device 1022:700d (Advanced Micro Devices [AMD]) (rev =
0).
>     ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 2).
>     IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev =
1).
>     Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 1).
>     USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev=
 7).
>     SCSI storage controller: Adaptec 7892A (rev 2).
>     SCSI storage controller: Adaptec 7892A (#2) (rev 2).
>     Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev=
 116).
>     VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 17=
).
>=20
> this second machine runs an identical 2.4.17 kernel to that of the first.
>=20
> the most significant difference i see here is that the chipset is the amd
> 760mp rather than 760mpx which is purely a supposed improvement to the
> south bridge 765->768.
>=20
> so before i go tearing machines apart in hopes of debugging which piece of
> hardware is the cause of this less than optimal behavior, would anyone ca=
re
> to wager what the cause is?
>=20
> -kelley
>=20


--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ao10F3O5KT+A1xQRAhVoAJ9CZAnBTaOYQDLc0Tz2EKs+V4ul8wCeJ3B/
1Qf9/papo3jDAocaF4CoSj8=
=fKHn
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
