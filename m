Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266056AbUF2VLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUF2VLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUF2VLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:11:03 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:42228 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266056AbUF2VK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:10:59 -0400
Date: Tue, 29 Jun 2004 17:10:21 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: per-process namespace?
In-reply-to: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Message-id: <40E1DABD.9000202@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ram Pai wrote:
> Is there a way for an application to
> 1. fork its own namespace and modify it, and
> 2. still be able to see changes to the system namespace?
>
> Al Viro's Per-process namespace implementation provides the first
> feature.  But is there any work done to do the second part? Is it worth
> doing?
>
> RP

In what sense?

The current model has no definition for a 'system namespace'.

Accessing /proc/<pid>/mounts where <pid> is running in a different
namespace appears to work.  As well, you can always fchdir back into
another namespace temporarily.  As long as you don't reference any
file/directories using absolute paths (including following symlinks),
then you can already navigate the entire namespace.

This falls apart though when there are no longer any processes keeping
that namespace alive.  When this happens, the vfsmount's are unstitched
and you end up 'stuck' on a given mount :(.

Another caveat is that the current system disallows you from doing any
mount/umount's in another namespace (bogus security?).

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

iD8DBQFA4dq9dQs4kOxk3/MRApkaAKCPe0Nw9QBZH425SZeOIvIzSzksUACfQk5D
xLgBDN/dsmVMkAAD73mugiY=
=8OEy
-----END PGP SIGNATURE-----
