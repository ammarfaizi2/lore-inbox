Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUASQVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUASQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:21:10 -0500
Received: from h80ad2484.async.vt.edu ([128.173.36.132]:56492 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265282AbUASQVH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:21:07 -0500
Message-Id: <200401191620.i0JGKqKe012285@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Hans Reiser <reiser@namesys.com>
Cc: raymond jennings <highwind747@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers 
In-Reply-To: Your message of "Mon, 19 Jan 2004 13:45:29 +0300."
             <400BB549.3040904@namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu> <40084DFB.5040106@namesys.com> <200401162238.i0GMcxT3004785@turing-police.cc.vt.edu>
            <400BB549.3040904@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1047083659P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jan 2004 11:20:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1047083659P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Jan 2004 13:45:29 +0300, Hans Reiser said:

> >Does the extent-based disk allocation used by OS/360 in 1964 count? :)
> >  
> >
> Probably.  Tell me more about it.

Well, basically, a dataset was described by an entry in the Volume Table of
Contents (VTOC) with a something conceptually similar to an inode.  The actual
data area was described with a initial allocation, and up to 15 additional
"extents" (yes, hard limit of 15 extents per volume, although a dataset could
span volumes).  Each extent was described with start/end cylinder/track pairs.
You could allocate space by absolute tracks, by tracks, or by cylinders (of
course, space actually allocated was dependent on the device).  So you could
code in the JCL something like SPACE=(CYL,(10.5)) which would allocate 10
cylinders and up to 15 additional 5-cylinder spaces.  And yes, it was quite
possible to get hosed on fragementation.

The first 3 allocations were contained in the 'format 1' DSCB (Data Set
Control Block), and additional extents were in a 'format 3' DSCB.  Free
space was described in extents in a series of chained 'format 4' DSCB's.
(A single DSCB was only 140 bytes, so there's a lot of chaining;).

I don't know how IBM did disk space management on the earlier systems
such as the 1401, 7040, and 7090 series, but I'd suspect it was a similar
extent-based method.


--==_Exmh_-1047083659P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADAPjcC3lWbTT17ARAmJGAJoCyy0WLle98zqxUQaBXC6F2xxXZgCgl7Uj
eQkKExfOQB+GmKEETnHLYWA=
=Afdm
-----END PGP SIGNATURE-----

--==_Exmh_-1047083659P--
