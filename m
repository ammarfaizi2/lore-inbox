Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265543AbUFUAqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbUFUAqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 20:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUFUAqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 20:46:23 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:4580 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265543AbUFUAqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 20:46:19 -0400
Subject: Re: [ACPI] [BKPATCH] ACPI for 2.4
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: Len Brown <len.brown@intel.com>, Mikael.Pettersson@csd.uu.se
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1087540935.4488.214.camel@dhcppc4>
References: <1087540935.4488.214.camel@dhcppc4>
Content-Type: multipart/mixed; boundary="=-zUKFYDXO79JfrGNg1TvU"
Message-Id: <1087777894.4916.13.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 21 Jun 2004 01:31:35 +0100
X-OriginalArrivalTime: 21 Jun 2004 00:31:36.0212 (UTC) FILETIME=[1C39FD40:01C45727]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zUKFYDXO79JfrGNg1TvU
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Mikael, I think you are the "guy" whose propose this patch on lkml.
I am forwarding to ACPI ml, where is the right place to send ACPI
patches.=20

Hi Len,
Mikael said
"2.4.27-rc1 reintroduced the double-speed timer ACPI bug.=20
Both x86-64 and i386 are affected.

The patch below fixes it on my box. It's a backport of a
patch Hans-Frieder Vogt made for 2.6.7-bk2, extended to
also handle i386.
/Mikael Pettersson"

On Fri, 2004-06-18 at 08:32, Len Brown wrote:=20
> Hi Marcelo, please do a=20
>=20
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.27
>=20
> thanks,
> -Len
>=20
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.=
4.27/acpi-20040326-2.4.27.diff.gz

> <len.brown@intel.com> (04/06/18 1.1359.6.27)
>    [ACPI] fix 2.4.27-pre3 IRQ override regression
>    due to dynamically allocated mp_irqs[].
>    http://bugzilla.kernel.org/show_bug.cgi?id=3D2834
>=20

Hope help something, sorry for my poor English.
--=20
S=E9rgio M. B.

--=-zUKFYDXO79JfrGNg1TvU
Content-Disposition: attachment; filename=1.diff
Content-Type: text/x-patch; name=1.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.4.27-rc1/arch/i386/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c
--- linux-2.4.27-rc1/arch/i386/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
+++ linux-2.4.27-rc1.mpparse-fix/arch/i386/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
@@ -1211,7 +1211,7 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic == mp_ioapics[ioapic].mpc_apicid) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -ruN linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c
--- linux-2.4.27-rc1/arch/x86_64/kernel/mpparse.c	2004-06-21 00:39:30.000000000 +0200
+++ linux-2.4.27-rc1.mpparse-fix/arch/x86_64/kernel/mpparse.c	2004-06-21 00:50:01.000000000 +0200
@@ -866,7 +866,7 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic == intsrc.mpc_dstapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--=-zUKFYDXO79JfrGNg1TvU--

