Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUEJXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUEJXLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUEJXLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:11:33 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:20868 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S263028AbUEJXKI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:10:08 -0400
Message-Id: <200405102310.i4ANA7Eh022394@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement 
In-Reply-To: Your message of "Mon, 10 May 2004 15:52:58 PDT."
             <Pine.LNX.4.58.0405101548230.1156@bigblue.dev.mdolabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com> <1084228900.28903.2.camel@vertex>
            <Pine.LNX.4.58.0405101548230.1156@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1248512030P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 May 2004 19:10:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1248512030P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 15:52:58 PDT, Davide Libenzi said:

> And it should not even be that much hard to do, since you can just 
> backtrace the the point where the change happened to see if there are 
> watchers on the parent directories.

Umm.. can you?  That sounds suspiciously like "given an inode, how
do I find the pathname?".

How do you handle the case of a file that's hard-linked into 2 different
directories a "long way" apart in the heirarchy?  It's easy enough to
backtrack and find *A* path - the problem is if the watcher was on
some *other* directory:

mkdir -p /tmp/a/foo/bar/baz
mkdir -p /tmp/b/que/er/ty
touch /tmp/a/foo/bar/baz/flag
ln /tmp/a/foo/bar/baz/flag /tmp/b/qu/er/ty/flag

If you modify 'flag' again, how do you ensure that you find a watcher on
/tmp/a/foo or /tmp/b/qu, given that either or both might be there?


--==_Exmh_1248512030P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoAvPcC3lWbTT17ARAkGvAKDyyDdHWIIojh3kUgfZVJka1pE3RQCfdCnA
eEyX48B7ZwTjRNFlBRNBcRo=
=lGeO
-----END PGP SIGNATURE-----

--==_Exmh_1248512030P--
