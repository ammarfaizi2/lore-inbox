Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131743AbQK0O6J>; Mon, 27 Nov 2000 09:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131677AbQK0O6A>; Mon, 27 Nov 2000 09:58:00 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18441 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S131214AbQK0O5l>; Mon, 27 Nov 2000 09:57:41 -0500
Date: Mon, 27 Nov 2000 15:26:35 +0100
From: Kurt Garloff <garloff@suse.de>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.2.17] yes: oops again in /proc/scsi/scsi
Message-ID: <20001127152635.K18517@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux SCSI list <linux-scsi@vger.kernel.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org> <20001123010712.C32555@garloff.etpnet.phys.tue.nl> <20001127091005.A2973@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001127091005.A2973@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Mon, Nov 27, 2000 at 09:10:05AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2000 at 09:10:05AM +0100, Matthias Andree wrote:
> My previous mail was a tad too early. After I moved the bus back to the
> Tekram DC-390U (sym53c8xx driver), I caught an oops again, and
> rescan-scsi-bus.sh caught a SIGSEGV. There seems to be a kernel bug somew=
here
> in that SCSI handling stuff:
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
052
> current->tss.cr3 =3D 07106000, %%cr3 =3D 07106000
> *pde =3D 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[sr_finish+112/388]
> EFLAGS: 00010206
> eax: 00000000   ebx: 00000054   ecx: 00000005   edx: c7f9cc00
> esi: c629bd50   edi: c7f9cc40   ebp: 00000001   esp: c629bd3c
> ds: 0018   es: 0018   ss: 0018
> Process rescan-scsi-bus (pid: 2846, process nr: 23, stackpage=3Dc629b000)
> Stack: 00000000 c7f88340 c02a9960 c629bd4c 00307273 c01fedaf c7f88700 c75=
55de0
>        c629becc c01fedf3 00000000 00000000 c7f88340 00000000 c6e132c0 c02=
cb0e0
>        c6e132c8 c0132793 c6e132c0 c629bda4 c629bda4 c0001a00 00020000 c63=
532c0
> Call Trace: [scan_scsis+491/1076] [scan_scsis+559/1076] [get_new_inode+14=
7/312] [iget4+121/132] [vsprintf+720/764] [wake_up_process+64/76] [__wake_u=
p+59/68]
> Code: 80 48 52 20 a1 8c 99 2a c0 80 4c 18 16 08 a1 8c 99 2a c0 80
> Using defaults from ksymoops -t elf32-i386 -a i386

This time, I do not suspect the low-level driver. It mey very well be, that
there's a subtile bug WRT add/remove-single-device housekeeping in the SCSI
layer.
You told that you did parallel rescan-scsi-bus.sh calls. That may have
confused the kernel. Did the above oops happen without such abuse?

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Im8bxmLh6hyYd04RApGXAKCl2o0Qs3NdPNE9U9nfBQUGyZYpjQCgwh6o
Jg83qyxy1I8xqEWjfP3WbUQ=
=3OC2
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
