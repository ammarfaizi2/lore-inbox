Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTHBFvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbTHBFvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 01:51:38 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:14827
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S270997AbTHBFvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 01:51:35 -0400
Date: Sat, 2 Aug 2003 01:53:24 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030802055323.GB3613@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20030801144455.450d8e52.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.6.0-test2-mm2
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2003 at 02:44:55PM -0700, Andrew Morton wrote:
>=20
> This patch should fix the oops.
>=20
> As for why the proc reading code was unable to locate the HBA: dunno, but
> this is a first step.
>=20
> Or maybe you don't have any adaptec controllers in the machine?
>=20
> (jejb, please apply..)
>=20
>=20
>  25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff -puN drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix dr=
ivers/scsi/aic7xxx_old/aic7xxx_proc.c
> --- 25/drivers/scsi/aic7xxx_old/aic7xxx_proc.c~aic7xxx_old-oops-fix	Fri A=
ug  1 14:41:14 2003
> +++ 25-akpm/drivers/scsi/aic7xxx_old/aic7xxx_proc.c	Fri Aug  1 14:41:20 2=
003
> @@ -92,7 +92,7 @@ aic7xxx_proc_info ( struct Scsi_Host *HB
> =20
>    HBAptr =3D NULL;
> =20
> -  for(p=3Dfirst_aic7xxx; p->host !=3D HBAptr; p=3Dp->next)
> +  for(p=3Dfirst_aic7xxx; p && p->host !=3D HBAptr; p=3Dp->next)
>      ;
> =20
>    if (!p)
>=20
> _
>=20
>

Andrew,

I will test the patch shortly :). I do have Adaptec AHA-2940U2W
controller installed in my machine, http://www.blazebox.homeip.net:81/diffi=
e/images/comp/amd_box8.png.

=46rom dmesg:

(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.6/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
sda: Spinning up disk......<5>Attached scsi disk sda at scsi0, channel 0, i=
d 3, lun 0
(scsi0:0:6:0) Synchronous at 80.0 Mbyte/sec, offset 63.
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host0/bus0/target6/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >

=46rom lspci:

01:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W

Regards,

Paul

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/K1HTIymMQsXoRDARAidAAKCJLow5aLvT0pdrBsw2DyGMlbwQUwCggHgV
RGVyk0dlDUfLXoL5UGCv2tw=
=qFvX
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
