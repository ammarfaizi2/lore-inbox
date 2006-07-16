Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWGPPyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGPPyj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWGPPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:54:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:8087 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751279AbWGPPyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:54:38 -0400
Message-ID: <44BA61A2.5090404@suse.com>
Date: Sun, 16 Jul 2006 11:56:18 -0400
From: Jeffrey Mahoney <jeffm@suse.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com>
In-Reply-To: <44B9E6D5.2040704@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> So the Plan 9 and Unix way would be to let the driver parse the number
> part of the name after the last slash.  What I don't understand is why
> reiserfs is getting involved here, rather than recognizing the driver as
> an extension of the namespace, seeing the driver as a mountpoint, and
> just passing number to the driver.  There must be something I don't
> grasp here, can you help me?

The name used in procfs isn't parsed anywhere, it could just as easily
be fs0, fs1, fs2, etc, but that wouldn't be a very user friendly way of
indicating which file system's statistics are described in that
directory. It's just presented to the user as a pathname to identify a
particular file system. The problem is that reiserfs is attempting to
use a name from a separate name space that doesn't follow the same rules
as the standard file system name space. Block device names, initially,
weren't intended for use as self-contained path components and aren't
part of the file system name space. If we wish to use those names, we
need to sanitize them to conform to the rules of the file system name
space by removing/replacing the path separator character.

It's unfortunate that some drivers use a slash rather than sticking with
the <type><letter> convention. I don't expect new drivers to be added
with slashes in them. If at some point the existing drivers are changed
to remove the slash, then this patch can be removed again.


- -Jeff
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEumGhLPWxlyuTD7IRAvuOAJ4yYUYp9TsUervYGBERSinPyOeAJQCgn7Wm
lgYoPKKUElaKkWcoECN9e+4=
=Rp8I
-----END PGP SIGNATURE-----
