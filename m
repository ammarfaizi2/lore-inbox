Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUI2Rem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUI2Rem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUI2ReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:34:07 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19657 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268706AbUI2RdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:33:21 -0400
Message-ID: <415AF1E5.6010101@comcast.net>
Date: Wed, 29 Sep 2004 13:33:25 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compressed filesystems:  Better compression?
References: <415A302E.5090402@comcast.net> <20040929123637.GA17952@wohnheim.fh-wedel.de>
In-Reply-To: <20040929123637.GA17952@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jörn Engel wrote:
| On Tue, 28 September 2004 23:46:54 -0400, John Richard Moser wrote:
|
|>In my own personal tests, I've gotten a 6.25% increase in compression
|>ratio over bzip2 using the above lzma code.  These were very weak tests
|>involving simply bunzipping a 32MiB tar.bz2 of the Mozilla 1.7 source
|>tree and recompressing it with lzma, which produced a 30MiB tar.lzma.  I
|>tried, but could not get it to compress much better than that (I think I
|>touched 29.5 at some point but not sure, it was a while ago).
|
|
| Sounds sane.  bzip2 is really hurt by the hart limit of 900k for block
| sorting.
|
| Inside the kernel, other things start to matter, though.  If you
| really want to impress me, take some large test data (your mozilla.tar
| or whatever), cut it up into chunks of 4k and compress each chunk
| individually.  Does lzma still beat gzip?
|

I'll try that.  I'm more interested in 32-128k chunks, however.  Based
on prior experience, I've come to rely on 32-64k being "optimal" for
compression; bigger block sizes don't seem to produce much of a gain
(some, but nothing amazing).  These are also the ranges that would be
used for compressed filesystems such as squashfs.  For filesystems such
as zisofs, it would be possible to split files up into blocks as well,
to lower the memory footprint and increase seek speed through the file.

[BlkSz][DictSz][CompressedData...........]

By placing an indicator of block size (compressed) on each block, and
indicating the size of uncompressed blocks elsewhere (in the file header
etc), compressed data can be quickly seeked through without
decompressing the entire stream (at max 1 block).

| If you can at least get it to compress better for 64k chunks, that's
| already quite interesting.  But excellent compression with infinite
| chunk-size and infinite memory is quite pointless inside the kernel.
| Such things should be left in userspace where they belong.
|

Yes, this needs to be practically useful; compressing 800M files in the
kernel using 16G of memory is NOT practical.  :)


| Jörn
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWvHlhDd4aOud5P8RAjkLAJ9YQa4dAA8cbEJZwOSm1AqDho24bQCeNsqA
eTvya0mNXt2JJb4Fi95IeEY=
=pe0m
-----END PGP SIGNATURE-----
