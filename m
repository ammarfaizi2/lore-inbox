Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTBJF4z>; Mon, 10 Feb 2003 00:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBJF4z>; Mon, 10 Feb 2003 00:56:55 -0500
Received: from h80ad26eb.async.vt.edu ([128.173.38.235]:16525 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S263039AbTBJF4y>; Mon, 10 Feb 2003 00:56:54 -0500
Message-Id: <200302100606.h1A66SOf023514@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest] 
In-Reply-To: Your message of "Mon, 10 Feb 2003 06:10:08 +0100."
             <20030210051007.GE1109@unthought.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au>
            <20030210051007.GE1109@unthought.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-154650848P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Feb 2003 01:06:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-154650848P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2003 06:10:08 +0100, Jakob Oestergaard said:

> In stock 2.4.20 the interaction is horrible - whatever was done there i=
s
> not optimal.    A 'tar xf' on the client will neither load the network
> nor the server - it seems to be network latency bound (readahead not
> doing it's job - changing min-readahead and max-readahead on the client=

> doesn't seem to make a difference). However, my desktop (running on the=


This sounds like the traditional NFS suckage that has been there for deca=
des.
The problem is that 'tar xf' ends up doing a *LOT* of NFS calls - a huge
stream of stat()/open()/chmod()/utime() calls.  On a local disk, most of
this gets accelerated by the in-core inode cache, but on an NFS mount, yo=
u're
looking at lots and lots of synchronous calls.

In 'man 5 exports':

       async  This option allows the NFS server to violate  the  NFS  pro=
tocol
              and  reply  to  requests before any changes made by that re=
quest
              have been committed to stable storage (e.g. disc drive).

              Using this option usually improves performance, but at the =
 cost
              that  an unclean server restart (i.e. a crash) can cause da=
ta to
              be lost or corrupted.

              In releases of nfs-utils upto and including 1.0.0,  this  o=
ption
              was  the  default.   In  this  and  future releases, sync i=
s the
              default, and async must be explicit  requested  if  needed.=
   To
              help  make system adminstrators aware of this change, 'expo=
rtfs'
              will issue a warning if neither sync nor async is specified=
=2E

Does this address your NFS issue?
-- =

				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-154650848P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+R0FjcC3lWbTT17ARAjYrAKDF/UowtexBnAueVAWK6eR+i4co2QCgmL4s
PTmZ//OGP2umXwV5s5yLhpU=
=dK1Q
-----END PGP SIGNATURE-----

--==_Exmh_-154650848P--
