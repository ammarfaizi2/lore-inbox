Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTJFUqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTJFUqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:46:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62082 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261644AbTJFUqD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:46:03 -0400
Message-Id: <200310062045.h96KjxJP008005@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Daniel B." <dsb@smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Why not re-do failed op? 
In-Reply-To: Your message of "Mon, 06 Oct 2003 16:20:42 EDT."
             <3F81CE9A.851806B8@smart.net> 
From: Valdis.Kletnieks@vt.edu
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
            <3F81CE9A.851806B8@smart.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1803511882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Oct 2003 16:45:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1803511882P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Oct 2003 16:20:42 EDT, "Daniel B." said:

> Are you sure?  If you issue a write to block 1 and then issue another
> write to block 1, it would have to guarantee the relative order of those 
> writes (or equivalent optimization in the write cache), wouldn't it?

If the old 'block 1' data is still in the write cache, then another write
should overlay it - that's a very basic optimization.  Consider the case of a
very active block that has a popular inode that's being atime-updated a lot (or
whatever causes a lot of activity - ignore the in-memory cache and sync/fsync
for the moment). You really don't want 34 writes to the same block taking up 34
blocks of space in the write cache....

The ordering issue comes when the following type of thing happens:

1) a write for block 993 is issued (metadata, perhaps)
2) a write for block 10934 is issued - actual file contents or something that
depends on 993 being written.
3) Disk writes 10934 out.
4) Things go bad  (power hit, whatever) before 993 gets written out.
5) fsck. ;)

--==_Exmh_1803511882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/gdSHcC3lWbTT17ARAidbAKDbKFe8zm+x23LIyKXxsfLljAsesQCfRALV
JmLrDygmSc7F9JH6xlNzWao=
=9Xp3
-----END PGP SIGNATURE-----

--==_Exmh_1803511882P--
