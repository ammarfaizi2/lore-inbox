Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUF2WrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUF2WrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUF2Wqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:46:37 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:1432 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266131AbUF2Wq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:46:26 -0400
Date: Tue, 29 Jun 2004 16:46:22 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block Device Caching
Message-ID: <20040629224622.GQ15166@schnapps.adilger.int>
Mail-Followup-To: Markus Schaber <schabios@logi-track.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XLsjFikA86nwwlhe"
Content-Disposition: inline
In-Reply-To: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XLsjFikA86nwwlhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 30, 2004  00:20 +0200, Markus Schaber wrote:
> During our application testing, we noticed that our application (that
> operates directly on a LVM volume) we noticed that it seems the read
> data does not go into any cache.
>=20
> Now we did some tests using dd blocksize=3D1M count=3D1000:
>=20
> Using dd directly on the /dev/daten/testing lvm volume, we read about 95
> MBytes/Seconds. Issuing multiple dds in sequence gives little variance in=
 IO
> speed (between 90 and 100 MB/sec).
>=20
> When we create a file system on this volume, and mount it, and we create
> a 1G file there, the dd gives us the same 95 MB/sec on the first read
> after the mount, and approx. 480 MB/Sec on subsequent reads.
>=20
> This lead us to the conclusion that block devices do not cache, but the
> filesystem does. But subsequently, I ran some tests on my developer
> machine (Pentium 4 Mobile Laptop).
>=20
> When dd'ing 100MB from /dev/hda5, the first read gives about
> 22MBytes/Sek (which seems okay for a 2.5" IDE Disk), but subsequend
> reads give about 389MBytes/sek (which is impossible to achieve using
> such hardware). Interestingly, this happens on a mounted partition,
> while when unmounting the partition, caching does not work. But for the
> /dev/daten/testing above, mounting a filesystem on the partition does
> not help in caching.

When you close the block device it flushes the cache for that device (inode=
).
If you kept the device open in some way (e.g. "sleep 10000000 < /dev/hda5")
then it should start caching the data between dd runs.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--XLsjFikA86nwwlhe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA4fE+pIg59Q01vtYRAj6DAJ4xS79Yf3TP+V4FS6HdLypfSRE9QwCdHGGe
X57hB0sB/yBDtanKO3JTlKQ=
=Njc/
-----END PGP SIGNATURE-----

--XLsjFikA86nwwlhe--
