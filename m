Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUFQQ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUFQQ1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUFQQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:27:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:28860 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266560AbUFQQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:26:58 -0400
Date: Thu, 17 Jun 2004 10:26:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Petter Larsen <pla@morecom.no>
Cc: Phil White <ext3@philwhite.org>, ext3 <ext3-users@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mode data=journal in ext3. Is it safe to use?
Message-ID: <20040617162656.GB14915@schnapps.adilger.int>
Mail-Followup-To: Petter Larsen <pla@morecom.no>,
	Phil White <ext3@philwhite.org>, ext3 <ext3-users@redhat.com>,
	linux-kernel@vger.kernel.org
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com> <1805.216.148.213.196.1087426691.squirrel@www.code-visions.com> <1087471412.2765.209.camel@pla.lokal.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <1087471412.2765.209.camel@pla.lokal.lan>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 17, 2004  13:23 +0200, Petter Larsen wrote:
> But think of your scenario  of copy, delete and make a new file with the
> new content. First we copy the contents of the file, then we do our
> modifications. When we are done  we delete the original file. Then we hit
> a crash. The content we had of the file in our process are  gone, the
> original file is deleted. This is not a good idea. But if we write the ne=
w=20
> file first as fileX.new and den delete fileX, hit a crash then we would
> have at least the  correct file written as fileX.new.

The rename operation is guaranteed to be atomic.  You implement updates as:
1) create new file
2) write data to new file
3) rename new file over old filename

If the system crashes at any time you are guaranteed that the old filename
has valid data in it.  Even if you use data=3Djournal mode while overwriting
the old filename directly you wouldn't be guaranteed to have valid data
unless your application was only e.g. writing aligned records to fixed file
offsets, and those records were <=3D 4kB in size.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA0cZPpIg59Q01vtYRAgukAKCfQKxMiDmcBdiQbsE6feh5NZ2CngCdFrmW
EUag92uHYajPVHPPZ8ffVRc=
=tdYj
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
