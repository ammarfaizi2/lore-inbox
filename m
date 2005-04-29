Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVD2OdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVD2OdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVD2Ocs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:32:48 -0400
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:49323 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262729AbVD2OcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:32:19 -0400
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
To: Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Date: Fri, 29 Apr 2005 15:32:09 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt> <1114779578.497.15.camel@localhost.localdomain>
In-Reply-To: <1114779578.497.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1374378.kQgO4ZdC8P";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504291532.09928.pjvenda@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1374378.kQgO4ZdC8P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 April 2005 13:59, Alexander Nyberg wrote:
> > We've made some changes on our ftp server, and since that it's been
> > crashing frequently (everyday) with a kernel panic.
> >
> > We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM on
> > top of that. All filesystems are reiserfs. The other change we made to
> > the server was changing from a patched 2.6.10-ac12 kernel into a newer
> > 2.6.11.7.
> >
> > Not being able to see the whole stacktrace on screen, we've started a
> > netconsole to investigate. Started the server and loaded it pretty bad
> > with rsyncs and such... until it crashed after just 20 minutes.
> >
> > The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"
> >
> > Any help would be GREATLY appreciated.
>
> 5 IDE disks into one MD raid5 into one LVM volume with reiserfs on top
> of it? Could you give me some way to reproduce the specific load you put
> on the machine plus your .config and I'll see what I can do.

ok, current setup is:

5 160GB IDE drives spread across 2 controller cards, one onboard and a PCI=
=20
promise ultra133 (Promise Technology, Inc. 20269 (rev 02)). All but two of=
=20
the drives are alone in an IDE channel.

boot and system partitions are mirrored [raid1] across all drives (not that=
=20
silly because of uniform partitioning scheme for raid5 array).

About 150GB of each drive belong to a RAID5 array with total size of 576.73=
=20
GB.

that raid5 array supports two LVM volumes of 320 and 256GB.

df -h:
=46ilesystem            Size  Used Avail Use% Mounted on
/dev/md5               19G  2.6G   17G  14% /
/dev/big/ftp          320G  260G   61G  82% /home/ftp
/dev/big/other        257G  149G  108G  58% /home/other
none                  252M     0  252M   0% /dev/shm
/dev/md1               69M  8.7M   57M  14% /boot

lvscan:
  ACTIVE            '/dev/big/ftp' [320.00 GB] inherit
  ACTIVE            '/dev/big/other' [256.73 GB] inherit

pvscan:=20
PV /dev/md6   VG big   lvm2 [576.73 GB / 0    free]
Total: 1 [576.73 GB] / in use: 1 [576.73 GB] / in no VG: 0 [0   ]

mdstat:
Personalities : [raid1] [raid5]=20
md2 : active raid1 hdc2[1] hda2[0]
      136448 blocks [2/2] [UU]     =20
md7 : active raid1 hdg2[1] hde2[0]
      136448 blocks [2/2] [UU]     =20
md1 : active raid1 hdh1[4] hdg1[3] hde1[2] hdc1[1] hda1[0]
      72192 blocks [5/5] [UUUUU]     =20
md5 : active raid5 hdh5[4] hdg5[3] hde5[2] hdc5[1] hda5[0]
      19566592 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]   =20
md6 : active raid5 hdh6[4] hdg6[3] hde6[2] hdc6[1] hda6[0]
      604750336 blocks level 5, 64k chunk, algorithm 2 [5/5] [UUUUU]     =20
unused devices: <none>

hope it helps.

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administra=E7=E3o de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior T=E9cnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt

--nextPart1374378.kQgO4ZdC8P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCckVpeRy7HWZxjWERAgLXAKCxHX3SvrG3W1V4hQXpksng3I2R6ACePF+W
zPJtv9Owuc6VC86xFpDkcW8=
=ko7a
-----END PGP SIGNATURE-----

--nextPart1374378.kQgO4ZdC8P--
