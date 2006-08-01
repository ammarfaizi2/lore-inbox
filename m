Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWHAEiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWHAEiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHAEiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:38:54 -0400
Received: from www.timetrex.com ([69.93.244.106]:24492 "EHLO
	mail.academyoflearning.ca") by vger.kernel.org with ESMTP
	id S1750722AbWHAEix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:38:53 -0400
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
	expressed by kernelnewbies.org regarding reiser4 inclusion]
From: Mike Benoit <ipso@snappymail.ca>
To: Theodore Tso <tytso@mit.edu>
Cc: David Masover <ninja@slaphack.com>, Nate Diller <nate.diller@gmail.com>,
       David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20060801030005.GA1987@thunk.org>
References: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
	 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	 <44CE7C31.5090402@gmx.de>
	 <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>
	 <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>
	 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
	 <20060801010215.GA24946@merlin.emma.line.org>
	 <44CEAEF4.9070100@slaphack.com>  <20060801030005.GA1987@thunk.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3glcH00JuqkOm2hATg1g"
Date: Mon, 31 Jul 2006 21:38:31 -0700
Message-Id: <1154407111.24208.26.camel@ipso.snappymail.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.90-1mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3glcH00JuqkOm2hATg1g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 at 23:00 -0400, Theodore Tso wrote:
> The problem is that many benchmarks (such as taring and untaring the
> kernel sources in reiser4 sort order) are overly simplistic, in that
> they don't really reflect how people use the filesystem in real life.
> (How many times can you guarantee that files will be written in the
> precise hash/tree order so that the filesystem gets the best possible
> time?)  A more subtle version of this problem happens for filesystems
> where their performance degrades dramatically over-time without a
> repacker.  If the benchmark doesn't take into account the need for
> repacker, or if the repacker is disabled or fails to run during the
> benchmark, the filesystem are in effect "cheating" on the benchmark
> because there is critical work which is necessary for the long-term
> health of the filesystem which is getting deferred until after the
> benchmark has finished measuring the performance of the system under
> test.

If the file system that requires a repacker can do X operations in 1/2
the time all week long, even if the repacker takes several hours once a
week to run, you're still ahead of the game. The load averages on the
vast majority of servers have significant peaks and valleys throughout
the day, and throughout the week, it wouldn't be hard to find a time
where a online repacker is virtually unnoticeable to users. Delaying
certain work until the server is less busy might be considered
"cheating" on benchmarks, but in the real world most people would
consider it good use of resources.=20

Just like RAID rebuilds, where you can set maximum IO speeds I could see
a repacker working in a similar fashion.=20

Obviously there are some servers where this is unacceptable and in such
cases, don't use Reiser4, but I would guess they are few and far
between. No file system is perfect for 100% of the work loads thrown at
it.

PostgreSQL and its vacuum process comes to mind as something similar to
a repacker. PostgreSQL puts off doing some work to later, and it has
proven itself over and over again, especially when it comes to
scalability. PostgreSQL has recently (v8.0 I believe) moved to a system
where it can automatically detect the need to vacuum specific tables, so
tables that need it are vacuumed more often, and tables that don't are
rarely touched. I don't see any reason why a repacker couldn't work in a
similar fashion, once it detects a file to be fragmented over some
value, it gets scheduled for repacking when there is idle disk IO
available.=20

The bottom line is once you have a online repacker you instantly open up
all sorts of doors. Its well known that disk drives have different
sustained read/write performance depending on if the data is on the
inside or outside tracks. Perhaps the repacker could also move files
around on the disk to get further gains, for instance larger or most
commonly used files could be moved to where the disk has the highest
sustained read/write performance, and smaller less used files could be
moved to the slowest sustained read/write performance areas.

--=20
Mike Benoit <ipso@snappymail.ca>

--=-3glcH00JuqkOm2hATg1g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEztrHMhKjsejwBhgRAqDEAJ4o50PFBSBT7CKKcOIHXsSDFWjhqwCdFvBl
sSGWVucfOd0ZJAtqbInUjJU=
=m6PB
-----END PGP SIGNATURE-----

--=-3glcH00JuqkOm2hATg1g--

