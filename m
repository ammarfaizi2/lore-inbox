Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264976AbUFALFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbUFALFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUFALFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:05:46 -0400
Received: from mail.donpac.ru ([80.254.111.2]:48352 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264976AbUFALFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:05:42 -0400
Date: Tue, 1 Jun 2004 15:05:32 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Gabriel Ebner <ge@gabrielebner.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601110532.GE25943@pazke>
Mail-Followup-To: Gabriel Ebner <ge@gabrielebner.at>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <15751764.P3t0zfFIzn@schnecke2.gabrielebner.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <15751764.P3t0zfFIzn@schnecke2.gabrielebner.at>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dMdWWqg3F2Dv/qfw
Content-Type: multipart/mixed; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 153, 06 01, 2004 at 12:00:32PM +0200, Gabriel Ebner wrote:
> Hello,
>=20
> Compiling 2.6.7-rc2-mm1 on x86_64 using the attached config gives me the
> following error, though 2.6.7-rc1-mm2 compiled just fine:
>=20
> ...
>   AS      arch/x86_64/lib/memset.o
>   AS      arch/x86_64/lib/putuser.o
>   AS      arch/x86_64/lib/thunk.o
>   CC      arch/x86_64/lib/usercopy.o
>   LD      arch/x86_64/lib/built-in.o
>   AR      arch/x86_64/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x4236): In function
> `dmi_disable_acpi':
> : undefined reference to `acpi_force'
> arch/x86_64/kernel/built-in.o(.init.text+0x42a7): In function
> `force_acpi_ht':
> : undefined reference to `acpi_force'
> arch/x86_64/kernel/built-in.o(.init.text+0x4347): In function
> `acpi_boot_init':
> : undefined reference to `dmi_get_system_info'
> arch/x86_64/kernel/built-in.o(.init.text+0x43a9): In function
> `acpi_boot_init':
> : undefined reference to `acpi_force'
> arch/x86_64/kernel/built-in.o(.init.text+0x4408): In function
> `acpi_boot_init':
> : undefined reference to `dmi_check_system'
> arch/x86_64/ia32/built-in.o(.data+0x898): In function `ia32_sys_call_tabl=
e':
> : undefined reference to `compat_get_mempolicy'
> drivers/built-in.o(.init.text+0xff1): In function `acpi_sleep_init':
> : undefined reference to `dmi_check_system'
> drivers/built-in.o(.init.text+0x848a): In function `i8042_init':
> : undefined reference to `dmi_check_system'
> arch/x86_64/pci/built-in.o(.init.text+0xb3f): In function
> `pcibios_irq_init':
> : undefined reference to `dmi_check_system'
> make: *** [.tmp_vmlinux1] Fehler 1
> schnecke2 linux #
=20
Try the attached patch, it should fix DMI related problem.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dmi-fix
Content-Transfer-Encoding: quoted-printable

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc2-mm1.vanilla/include/linux=
/dmi.h linux-2.6.7-rc2-mm1/include/linux/dmi.h
--- linux-2.6.7-rc2-mm1.vanilla/include/linux/dmi.h	2004-06-01 14:48:18.000=
000000 +0400
+++ linux-2.6.7-rc2-mm1/include/linux/dmi.h	2004-06-01 14:50:24.000000000 +=
0400
@@ -32,7 +32,7 @@ struct dmi_system_id {
=20
 #define DMI_MATCH(a,b)	{ a, b }
=20
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
=20
 extern int dmi_check_system(struct dmi_system_id *list);
 extern char * dmi_get_system_info(int field);

--y0Ed1hDcWxc3B7cn--

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvGL8by9O0+A2ZecRAsujAJ9IBk6fA/QFLVoQCr7Jc+aYTlyIGQCfWHH/
Lfe6WaJ+KALWERYPM1Yi2ug=
=gLiO
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
