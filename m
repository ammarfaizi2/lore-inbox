Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTHTXGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTHTXGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:06:33 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:48808 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S262304AbTHTXGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:06:30 -0400
Subject: Re: [ACPI] RE: [patch] 2.4.x ACPI updates
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Grover <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@sourceforge.net
In-Reply-To: <Pine.LNX.4.55L.0308201514140.617@freak.distro.conectiva>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC7F@hdsmsx402.hd.intel.com>
	 <Pine.LNX.4.55L.0308201514140.617@freak.distro.conectiva>
Content-Type: multipart/mixed; boundary="=-1yr93LEgJfo9rDUMgGVC"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 21 Aug 2003 00:06:16 +0100
Message-Id: <1061420776.1790.18.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 20 Aug 2003 23:05:12.0367 (UTC) FILETIME=[826C43F0:01C3676F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1yr93LEgJfo9rDUMgGVC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

So had this compile error :
setup.c: In function `parse_cmdline_early':
setup.c:830: `skip_ioapic_setup' undeclared (first use in this function)
setup.c:830: (Each undeclared identifier is reported only once
setup.c:830: for each function it appears in.)

Since just in arch/i386/kernel/io_apic.c, skip_ioapic_setup is declared
and in arch/i386/kernel/Makefile we have
obj-$(CONFIG_X86_IO_APIC)       +=3D io_apic.o
I think this is the correct patch.

thanks

On Wed, 2003-08-20 at 19:15, Marcelo Tosatti wrote:
>=20
>=20
> On Tue, 19 Aug 2003, Brown, Len wrote:
>=20
> > Andy/Jeff/Marcelo,
> >
> > At Jeff's request, I've back ported ACPICA 20030813 from
> > http://linux-acpi.bkbits.net/linux-acpi-2.4 into a new tree for 2.4.22:
> > http://linux-acpi.bkbits.net/linux-acpi-2.4.22
> >
> > I've restored acpitable.[ch], which was deleted too late for this
> > release cycle; and will live on until 2.4.23 -- as well as restored
> > CONFIG_ACPI_HT_ONLY under CONFIG_ACPI; restored the 8-bit characters
> > that got expanded to 16-bits in a previous merge; and deleted some dmes=
g
> > verbiage that Jeff didn't think was appropriate for the baseline kernel=
.
> >
> > I exported this a patch and then imported onto a clone of Marcelo's
> > tree, so it appears as a single cset where the changes that got un-done
> > never happened.  I've done some sanity tests on it, and will test it
> > some more tomorrow.  Take a look at it and let me know if I missed
> > anything.  When Andy is happy with it I'll leave it to him to re-issue =
a
> > pull request from Marcelo.
>=20
> Cool!!
>=20
> Ill try to take a look at the patch now (having serious conectivity issue=
s
> :()
>=20
--=20
S=E9rgioMB
email: sergiomb@netcabo.pt

Who gives me one shell, give me everything.

--=-1yr93LEgJfo9rDUMgGVC
Content-Disposition: attachment; filename=fixcompile.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=fixcompile.diff; charset=ISO-8859-1

--- linux-2.4.22-rc2.orig/arch/i386/kernel/setup.c	Wed Aug 20 23:52:45 2003
+++ linux-2.4.22-rc2/arch/i386/kernel/setup.c	Wed Aug 20 23:54:36 2003
@@ -824,11 +824,12 @@
 			acpi_ht =3D 1;=20
 			if (!acpi_force) acpi_disabled =3D 1;=20
 		}=20
-
-                /* disable IO-APIC */
-                else if (!memcmp(from, "noapic", 6)) {
-                        skip_ioapic_setup =3D 1;
-                }
+#ifdef CONFIG_X86_IO_APIC
+		/* disable IO-APIC */
+		else if (!memcmp(from, "noapic", 6)) {
+			skip_ioapic_setup =3D 1;
+		}
+#endif
 #endif
 		/*
 		 * highmem=3Dsize forces highmem to be exactly 'size' bytes.

--=-1yr93LEgJfo9rDUMgGVC--

