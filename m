Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268077AbTBMSK5>; Thu, 13 Feb 2003 13:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268081AbTBMSK4>; Thu, 13 Feb 2003 13:10:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33154 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268077AbTBMSKz>; Thu, 13 Feb 2003 13:10:55 -0500
Message-Id: <200302131820.h1DIKfFT007758@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to bypass buffer caches? 
In-Reply-To: Your message of "Thu, 13 Feb 2003 12:51:19 EST."
             <1045158671.4767.138.camel@urca.rutgers.edu> 
From: Valdis.Kletnieks@vt.edu
References: <1045157351.21195.134.camel@urca.rutgers.edu> <200302131737.h1DHbIFT007308@turing-police.cc.vt.edu>
            <1045158671.4767.138.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1849248114P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Feb 2003 13:20:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1849248114P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Feb 2003 12:51:19 EST, Bruno Diniz de Paula said:

> But what if "/dev/hda7" already has an ext2 fs set up. How am I supposed
> to know which phisical blocks in the disk correspond to each of my files
> in the ext2 mapping, that is, "/var/somefile" or "/usr/local/otherfile"?

The quick answer:  Don't do that. ;)

Usually, this would be done by using /dev/hda7 as somefile and hda8 as
otherfile, or you'd create your own "filesystem" by saying "data for
somefile is in the first 2,000 blocks and otherfile is in blocks 2001+"
or so on. In other words, if you want a *raw partition*, you use one,
with *NO* filesystem involved.

Consider a product like Oracle (yes, I know I'm oversimplifying here).
If you have a database that takes 250M, it doesn't really care if it's
a 250M disk partition called /dev/hdc4 or a 250M file in a filesystem -
it just wants 250M of disk that *it* will worry about what goes in what
block.

The whole point of using a raw disk partition instead of a file is so that
you *DONT* have to worry about what the in-kernel filesystem cache is doing
to you, or what other files on the partition are doing, etc.  Note that most
of the problems (such as "do we need to fsync() here because of fs dain bramage"
or "do we need to worry about flushing the cache") arise because your code
is trying to second guess the filesystem - so if you scribble directly
on the partition and bypass the filesystem life gets easier (or at least then
all the bugs are self-inflicted, anyhow..)

So conceptually, you have an ext2/ext3 partition where allocation/management is done
by the ext2/3 filesystem code, a swap partition handled by the VM code,
a database partition that's run by the database code... and so on.

--==_Exmh_1849248114P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+S+H5cC3lWbTT17ARAh+BAKDyiCMfA/lz7I/xm+blSLfQTr0lNACg5YKg
DdpuP5qSSK7dkfEkVEFCfG0=
=hdkb
-----END PGP SIGNATURE-----

--==_Exmh_1849248114P--
