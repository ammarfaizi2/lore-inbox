Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQKHNCG>; Wed, 8 Nov 2000 08:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQKHNB5>; Wed, 8 Nov 2000 08:01:57 -0500
Received: from air.lug-owl.de ([62.52.24.190]:47121 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129437AbQKHNBs>;
	Wed, 8 Nov 2000 08:01:48 -0500
Date: Wed, 8 Nov 2000 14:01:46 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: [uPATCH] Again CLOCKS_PER_SEC on Alpha (maybe Sparc and PPC too)
Message-ID: <20001108140146.A31092@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux air 2.4.0-test8-pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

CLOCKS_PER_SEC is still missing:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fo=
mit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 -mcpu=
=3Dev4 -Wa,-mev6    -c -o binfmt_elf.o binfmt_elf.c
binfmt_elf.c: In function `create_elf_tables':
binfmt_elf.c:166: `CLOCKS_PER_SEC' undeclared (first use in this function)
binfmt_elf.c:166: (Each undeclared identifier is reported only once
binfmt_elf.c:166: for each function it appears in.)

Here's the old patch:

--- linux/include/asm-alpha/#param.h    Wed Nov  1 14:11:11 2000
+++ linux/include/asm-alpha/param.h     Wed Nov  1 14:54:59 2000
@@ -26,5 +26,9 @@
 #endif
=20
 #define MAXHOSTNAMELEN 64      /* max length of hostname */
+
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC HZ      /* frequency at which times() counts */
+#endif


--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoJTrkACgkQHb1edYOZ4bve4ACgjf2RE31qlNyem01zHLo3PP4m
aIMAn2BPZw1Z9iOqTdpppqzpEw+9bSsa
=63UJ
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
