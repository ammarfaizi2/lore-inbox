Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUI2QIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUI2QIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUI2QIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:08:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:47843 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268686AbUI2QG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:06:56 -0400
Message-ID: <415ADDA4.4050309@comcast.net>
Date: Wed, 29 Sep 2004 12:07:00 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compressed filesystems:  Better compression?
References: <415A302E.5090402@comcast.net> <20040929121846.GT19844@mea-ext.zmailer.org>
In-Reply-To: <20040929121846.GT19844@mea-ext.zmailer.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Matti Aarnio wrote:
| On Tue, Sep 28, 2004 at 11:46:54PM -0400, John Richard Moser wrote:
|
|>I wonder what compression Squashfs, cramfs, and zisofs use.  I think
|>cramfs uses zlib compression; I don't know of any other compression in
|>the kernel tree, so I assume zisofs uses the same, as does squashfs.  Am
|>I mistaken?
|
|
| Compression algorithms are a bit tough to be used in a random access
| smallish blocks environments.  In long streams where you can use megabytes
| worth of buffer spaces there is no problem is achieving good performance.
| But do try to do that in an environment where your maximum block size
| is, say: 4 kB, and you have to start afresh at every block boundary.

Yes of course.  I've seen the compressed page cache patch do this and
get fair peformance (10-20%), though on double size blocks (8KiB) it
manages almost twice as good (20-50%, averaged around 30% IIRC).  Not
great, but not bad.

On compressed filesystems you can work with 64k or 128k blocks.
Somewhere around 32-64k is usually optimal; you're not going to see
great improvements using 1M blocks instead of 512k blocks.

|
| Whatever algorithms you use, there will always be data sequences that
| are of maximum entropy, and won't compress.  Rather they will be
| presented in streams as is with a few bytes long wrappers around
| them.
|

Yes, an intelligent algorithm decides that if the underlying compression
algorithm used produces no results, it just marks the block as
uncompressed and stores it as such.  ZLIB does this if the block gets
bigger.  LZMA might not; but higher level intrinsics (block headers)
could handle that easy (as you said).

[...]

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWt2jhDd4aOud5P8RAofRAJ9yYBcTSNeQgtdpCxnAAyHZfzdt1QCdGHS8
ZBxqzmruMQoOwtjBqIxACKw=
=qEDJ
-----END PGP SIGNATURE-----
