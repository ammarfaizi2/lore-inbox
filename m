Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUG0A63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUG0A63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUG0A63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:58:29 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:51917 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S266196AbUG0A60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:58:26 -0400
Date: Mon, 26 Jul 2004 20:56:56 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: bug with multiple mounts of filesystems in 2.6
In-reply-to: <1090881327.6809.111.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John S J Anderson <jacobs@genehack.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Herbert Poetzl <herbert@13thfloor.at>
Message-id: <4105A858.7090209@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <86oem2hgv8.fsf@mendel.genehack.org>
 <1090870651.6809.62.camel@lade.trondhjem.org> <41057893.1030006@sun.com>
 <1090881327.6809.111.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trond Myklebust wrote:
> På må , 26/07/2004 klokka 17:33, skreiv Mike Waychison:
>
>
>>How is this any different than having two seperate nfs clients accessing
>>the same nfs export?
>
>
> It isn't, but why do you think that should be a reason for allowing it?
>
> By all means feel free to add "mount --bind -oro" capabilities, but it
> is neither useful nor is it necessary to break the NFS caching model in
> order to do so.
>

Agreed.  The two problems are orthogonal. [1]

As an example where sharing the super_block is wrong (albeit probably
just an oversight) is that the protocols (udp vs tcp) are not compared
in nfs_compare_super.  You could argue that the client fhandles should
be different though, I'm not sure..

Another 'bind mount extension' that would be nice to change at the
vfsmount level may be w/rsize, but that is probably a very intrusive
change for nfs and probably not possible.  Thoughts?

[1] - I haven't tested mounting nfs ro, and then mounting nfs rw using
the bind extensions.  Does nfs make any assumptions about the mount
being ro?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBahXdQs4kOxk3/MRAhTCAKCJGOaemEdeDrmtp/tG5Y6fHe+BTgCgkh8v
312wdekZsxms1ShJciogYRQ=
=7Hm7
-----END PGP SIGNATURE-----
