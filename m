Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWKCUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWKCUwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWKCUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:52:44 -0500
Received: from master.altlinux.org ([62.118.250.235]:65291 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932123AbWKCUwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:52:43 -0500
Date: Fri, 3 Nov 2006 23:52:23 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
Message-ID: <20061103205223.GC7240@procyon.home>
References: <1162576973.3967.10.camel@w100> <20061103220018.577ded43.vsu@altlinux.ru> <1162585327.3967.18.camel@w100>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <1162585327.3967.18.camel@w100>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2006 at 02:22:07PM -0600, Alberto Alonso wrote:
> On Fri, 2006-11-03 at 22:00 +0300, Sergey Vlasov wrote:=20
> > On Fri, 03 Nov 2006 12:02:53 -0600 Alberto Alonso wrote:
> >=20
> > > I have a Pacific Digital qstor card on irq 193. I am using kernel
> > > 2.6.17.13 SMP
> > >=20
> > >=20
> > > irq 193: nobody cared (try booting with the "irqpoll" option)
> >=20
> > Did you try this option?  It may decrease performance, but in some cases
> > IRQ routing is so screwed that only irqpoll helps.
>=20
> I have now switched to using that option. Will kick in after I reboot.

Actually, it might be better to wait with this - it is the last resort
option, if there is nothing else to try.

> 0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (r=
ev 04) (prog-if 10 [OHCI])
>         Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
>         Flags: bus master, medium devsel, latency 64, IRQ 10
>         Memory at fe9fe000 (32-bit, non-prefetchable) [size=3D4K]

Can you try with ohci-hcd loaded (and without irqpoll)?  USB
controllers might cause such problems, because BIOSen often do weird
things with them for legacy emulation; however, loading a proper
driver should make BIOS stop messing with the hardware behind the back
of the OS.

After loading ohci-hcd look which IRQ does the USB controller use - if
it is the same IRQ as the qstor card, you should keep ohci-hcd loaded
to avoid problems.  (If it is on some other IRQ, loading ohci-hcd
might still help - the code for enabling the PCI device calls ACPI
BIOS, which might change interrupt routing setup in the chipset.)

Also look for something like "USB Keyboard Support" and maybe "USB
Mouse Support" in BIOS setup - some BIOS versions have severe problems
with this emulation, so it may be better to disable it unless you
really need it.

Disabling USB in the BIOS setup if you really don't need might be
another option.

> 0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 U=
ltra3 SCSI Adapter (rev 01)
>         Subsystem: Gateway 2000: Unknown device 1040
>         Flags: medium devsel
>         I/O ports at 1000 [disabled] [size=3D256]
>         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
>         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
>         Capabilities: [40] Power Management version 2
>=20
> 0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 U=
ltra3 SCSI Adapter (rev 01)
>         Subsystem: Gateway 2000: Unknown device 1040
>         Flags: medium devsel
>         I/O ports at 1400 [disabled] [size=3D256]
>         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
>         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
>         Capabilities: [40] Power Management version 2

These devices seem to be disabled, but if loading ohci-hcd does not
help, you can try to load the sym53c8xx driver and look whether it
ends up on the same IRQ as qstor.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFS6wHW82GfkQfsqIRAqFVAJ46qTsHZcUcKds+dld7ewRYwe5+1ACglVqg
jmJdm/q/4dWiY2CUYnr1Z8Q=
=qRci
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
