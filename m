Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUGZVen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUGZVen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGZVen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:34:43 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:56767 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S265724AbUGZVej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:34:39 -0400
Date: Mon, 26 Jul 2004 17:33:07 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: bug with multiple mounts of filesystems in 2.6
In-reply-to: <1090870651.6809.62.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John S J Anderson <jacobs@genehack.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk,
       Herbert Poetzl <herbert@13thfloor.at>
Message-id: <41057893.1030006@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <86oem2hgv8.fsf@mendel.genehack.org>
 <1090870651.6809.62.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trond Myklebust wrote:
> På må , 26/07/2004 klokka 12:29, skreiv John S J Anderson:
>
>>  Hi --
>>
>>  We're working on migrating to the 2.6 kernel series, and one big
>>  problem has popped up: we have a number of NFS mounts that are
>>  mounted read-only in one location and read-write in a distinct
>>  location (on the same machine). With 2.4 series kernels, this worked
>>  without issue, but with 2.6, it doesn't: it's not possible to mount
>>  the same filesystem twice with different options for each mount; the
>>  two mount points have to share the same mount options.
>
>
> That behaviour is no longer supported as it meant that you would have
> different superblocks (and hence different out-of-sync caches) between
> the 2 mountpoint. It is in any case not a behaviour that is supported on
> any other Linux filesystems.
>

How is this any different than having two seperate nfs clients accessing
the same nfs export?

> If you want readonly to be an exception, then you will have to move the
> MS_RDONLY flag from being a superblock option to being a vfsmount
> option, then propagate that vfsmount information down to all the tests
> of IS_RDONLY(inode). Not a trivial task, and not one that looms high on
> my list of priorities...
>

What ever happened to the bind ro patches that were floating around a
couple months ago?
(http://marc.theaimsgroup.com/?t=107932320200005&r=1&w=2)

What is left in getting this done?  Just the touch_file bit Viro
commented on?

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

iD4DBQFBBXiTdQs4kOxk3/MRAp2CAJ9hLA43GX7breEAuFJp++noSX7hAQCYn7yw
FXXelAMC/NCetjqwC8Q67g==
=rQRx
-----END PGP SIGNATURE-----
