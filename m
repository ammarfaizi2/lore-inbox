Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUIXB5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUIXB5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIXBy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:54:57 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:64262 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S267209AbUIXBxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:53:12 -0400
Subject: [PATCH] abit nf7-s timer workaround new entry
From: Antony Suter <suterant@users.sourceforge.net>
To: List LKML <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com, mingo@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9f6xTBunC1X1jVfsmx+x"
Message-Id: <1095990772.9016.15.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 11:52:52 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9f6xTBunC1X1jVfsmx+x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Without this patch, dmi_scan.c does not apply a workaround for my
motherboard + bios version, and my timer is XT-PIC instead of
IO-APIC-edge. My bios is more recent than the other entry in the table
for my motherboard.

Patch against 2.6.9-rc2-bk8. The patch will need to be massaged as I was
unsure whether the motherboard id fields were supposed to be unique.

ie from:
           CPU0
  0:    2212265          XT-PIC  timer
  1:       2677    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi

to:
           CPU0
  0:     157481    IO-APIC-edge  timer
  1:        285    IO-APIC-edge  i8042
  8:          3    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi

####

diff -u -prauN linux-2.6.9-rc2-bk8/arch/i386/kernel/dmi_scan.c
linux-as268/arch/i386/kernel/dmi_scan.c
--- linux-2.6.9-rc2-bk8/arch/i386/kernel/dmi_scan.c     2004-09-24
11:01:02.813142848 +1000
+++ linux-as268/arch/i386/kernel/dmi_scan.c     2004-09-24
00:41:17.834565944 +1000
@@ -381,6 +381,12 @@ static __initdata struct dmi_blacklist d
                        MATCH(DMI_BIOS_VERSION, "6.00 PG"),
                        MATCH(DMI_BIOS_DATE, "03/24/2004") }},

+       { ignore_timer_override, "Abit NF7-S v2 _second entry_", {
+                       MATCH(DMI_BOARD_VENDOR,
"http://www.abit.com.tw/"),
+                       MATCH(DMI_BOARD_NAME, "NF7-S/NF7,NF7-V
(nVidia-nForce2)"),
+                       MATCH(DMI_BIOS_VERSION, "6.00 PG"),
+                       MATCH(DMI_BIOS_DATE, "07/06/2004") }},
+
        { ignore_timer_override, "Asus A7N8X v2", {
                        MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer
INC."),
                        MATCH(DMI_BOARD_NAME, "A7N8X2.0"),

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "Facts do not cease to exist because they are ignored." - Aldous Huxley

--=-9f6xTBunC1X1jVfsmx+x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBU33zZu6XKGV+xxoRAk7FAJ9xX5fyfd3ncJbn3jb3ksGV2lyf3QCeLdFz
KEZi7MxQCF1k+UrUxPgMk/U=
=Cj9W
-----END PGP SIGNATURE-----

--=-9f6xTBunC1X1jVfsmx+x--

