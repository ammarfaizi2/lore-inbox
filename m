Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUAPTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUAPTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:55:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50816 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265799AbUAPTzQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:55:16 -0500
Message-Id: <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: raymond jennings <highwind747@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers 
In-Reply-To: Your message of "Fri, 16 Jan 2004 11:38:59 PST."
             <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_788253566P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jan 2004 14:54:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_788253566P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Jan 2004 11:38:59 PST, raymond jennings <highwind747@hotmail.com>  said:
> Is there any value in creating a new filesystem that encodes long contiguous 
> blocks as a single block run instead of multiple block numbers?  A long file 
> may use only a few block runs instead of many block numbers if there is 
> little fragmentation (usually the case).  Also dynamic allocation of 
> inodes...etc.  The details are long; anyone interested can e-mail me 
> privately.

Only question I have is how you make an efficient scheme for finding the block
number for an offset several gigabytes into the file.  You either get to run
through the list linearly (gaak) or you need to stick a tree or hash on the
front to allow semi-random access to a starting point to scan linearly from, at
which point you've probably blown any space savings unless you have a VERY low
fragmentation rate...

On the other hand, dynamic allocation of inodes is interesting, as it means
you're not screwed if over time, the NBPI value for the filesystem changes (or
if you simply guessed wrong at mkfs time) and you run out of inodes when you
still have space free.  Reiserfs V3 already does this, in fact...


--==_Exmh_788253566P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFACEFmcC3lWbTT17ARAtEOAKCaSGbS1hTvZ7wjXRM6wG5bW727BQCghzaR
LG+6NLmRY2uCdI1xWcKMh74=
=yjWc
-----END PGP SIGNATURE-----

--==_Exmh_788253566P--
