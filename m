Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUF3SRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUF3SRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUF3SRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:17:55 -0400
Received: from lists.us.dell.com ([143.166.224.162]:24946 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266703AbUF3SRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:17:43 -0400
Date: Wed, 30 Jun 2004 13:17:15 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EDD breaks x86-64 build
Message-ID: <20040630181715.GA17774@lists.us.dell.com>
References: <40E24E0D.3060808@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <40E24E0D.3060808@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2004 at 01:22:21AM -0400, Jeff Garzik wrote:
>   CC      arch/x86_64/kernel/setup.o
> arch/x86_64/kernel/setup.c: In function `copy_edd':
> arch/x86_64/kernel/setup.c:415: error: `EDD_MBR_SIGNATURE' undeclared=20
> (first use in this function)
> arch/x86_64/kernel/setup.c:415: error: (Each undeclared identifier is=20
> reported only once
> arch/x86_64/kernel/setup.c:415: error: for each function it appears in.)
> arch/x86_64/kernel/setup.c:417: error: `EDD_MBR_SIG_NR' undeclared=20
> (first use in this function)
> make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2

Arrgh.  On i386 it's in include/asm-i386/setup.h  On x86_64 it
belongs in include/asm-x86_64/bootsetup.h.


Patch below defines EDD_MBR_SIG_NR and EDD_MBR_SIGNATURE on x86_64.


Signed-off-by: Matt_Domsch <Matt_Domsch@dell.com>


=3D=3D=3D=3D=3D include/asm-x86_64/bootsetup.h 1.4 vs edited =3D=3D=3D=3D=3D
--- 1.4/include/asm-x86_64/bootsetup.h	2004-04-12 12:53:56 -05:00
+++ edited/include/asm-x86_64/bootsetup.h	2004-06-30 13:12:35 -05:00
@@ -26,8 +26,9 @@
 #define INITRD_START (*(unsigned int *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
 #define EDID_INFO (*(struct edid_info *) (PARAM+0x440))
-#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
+#define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE saved_command_line
 #define COMMAND_LINE_SIZE 256

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA4wOrIavu95Lw/AkRAhSnAJ0VtiSDhVchrY9+yWrcV8SvOi1EfACeNCrb
um/IVeClepTfz/EUnrjMmNY=
=Pvck
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
