Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbREHPlt>; Tue, 8 May 2001 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbREHPlj>; Tue, 8 May 2001 11:41:39 -0400
Received: from ns.suse.de ([213.95.15.193]:43269 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132760AbREHPlb>;
	Tue, 8 May 2001 11:41:31 -0400
Date: Tue, 8 May 2001 17:38:47 +0200
From: Kurt Garloff <garloff@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010508173847.I22739@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010508160050.F543@athlon.random> <shs3dafvpcx.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shs3dafvpcx.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, May 08, 2001 at 05:21:02PM +0200
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2001 at 05:21:02PM +0200, Trond Myklebust wrote:
> Could you instead detail exactly which corruption problem you are
> trying to fix?

int fd =3D open (name, O_RDWR);
char* adr =3D (char*) mmap (0, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd,=
 0);
/* write to *adr through *(ard+len-1) */
/* Try adding here: msync (adr, len, MS_SYNC); */
munmap (adr, len);
close (fd);

The code works on files on local harddisks and on NFS volumes on a 2.2
kernel, but breaks on NFS drives on a 2.4.4 kernel.
msync() works around the bug.
Andrea's patch did help as well.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6+BMHxmLh6hyYd04RAq/2AKCtQoHAHzl17ZJ3JOTL5laxaWaPUQCggimi
ADLfWw60xcFjTIHEiA7s6RI=
=aHxK
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
