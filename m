Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUFCOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUFCOEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUFCOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:04:04 -0400
Received: from smtpauth2-ext.prodigy.net ([207.115.63.116]:12004 "EHLO
	smtpauth2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263725AbUFCOD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:03:59 -0400
Subject: APIC / ACPI Build issue
From: gaumer <gaumer@egaumer.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8S15divMcs015Zu1yitq"
Message-Id: <1086271422.16648.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 10:03:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8S15divMcs015Zu1yitq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Excuse my ignorance, I'm new to kernel development.

I've just patched my source with rc2-mm2 and there seems to be a build
issue concerning APIC / ACPI support.

The error:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0xdaca): In function `acpi_register_gsi':
: undefined reference to `mp_register_gsi'
make[1]: *** [.tmp_vmlinux1] Error 1

It seems that in arch/i386/kernel/acpi/boot.c
at line 462 we have:

#ifdef CONFIG_X86_IO_APIC
        if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_IOAPIC) {
                mp_register_gsi(gsi, edge_level, active_high_low);
        }
#endif

...yet mp_register_gsi is only defined if:

(line 879 of arch/i386/kernel/mpparse.c)
#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_ACPI_INTERPRETER)

So if the .config looks like:

# Power management options (ACPI, APM)
#
# CONFIG_PM is not set
                                                                           =
                                                                           =
                            =20
#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=3Dy
                                                                           =
                                                                           =
                            =20
#
# CPU Frequency scaling

With the power management stuff turned off and SMP support enabled the
result is this build error.=20

Does CONFIG_ACPI_INTERPRETER have to be defined? If so, then can we
require the definition in arch/i386/kernel/acpi/boot.c as well? This is
not an area I'm familiar with.

The last build I did was on 2.6.6-mm5 and things were okay there (same
config).



--=-8S15divMcs015Zu1yitq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAvy++ZWL8hfFdQekRAl2vAJ4ziTDXX4ne2dXSlrFqc9YKlkrueQCgg1yL
3kRNz83FxFCvn0DO4JceIiY=
=5dUZ
-----END PGP SIGNATURE-----

--=-8S15divMcs015Zu1yitq--

