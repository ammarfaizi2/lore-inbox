Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUBPR6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbUBPR6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:58:52 -0500
Received: from h80ad244c.async.vt.edu ([128.173.36.76]:34075 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265833AbUBPR6t (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:58:49 -0500
Message-Id: <200402161758.i1GHwfek031651@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: Your message of "Mon, 16 Feb 2004 18:26:47 +0100."
             <E1AsmW7-0000bV-DM@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <1pvrI-8bq-29@gated-at.bofh.it> <1pvrI-8bq-31@gated-at.bofh.it> <1pvrJ-8bq-33@gated-at.bofh.it> <1pvrJ-8bq-35@gated-at.bofh.it> <1pvrJ-8bq-37@gated-at.bofh.it> <1pvrJ-8bq-39@gated-at.bofh.it> <1pvrJ-8bq-41@gated-at.bofh.it> <1pvrJ-8bq-43@gated-at.bofh.it> <1pTay-3hc-13@gated-at.bofh.it> <1pTay-3hc-15@gated-at.bofh.it> <1pTay-3hc-11@gated-at.bofh.it> <1pTu7-3Ce-7@gated-at.bofh.it>
            <E1AsmW7-0000bV-DM@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2028654288P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Feb 2004 12:58:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2028654288P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Feb 2004 18:26:47 +0100, Pascal Schmidt said:
> On Mon, 16 Feb 2004 17:10:23 +0100, you wrote in linux.kernel:
> 
> >> file and created another with the same name between you calling creat()
> >> and doing the readdir(). What would be the use of this, anyway?
> > How does the shell do 'echo foo*'?
> 
> I fail to see the connection with creat() followed by readdir(). The shell
> is surely not expecting the names that follow from the glob expansion to
> have any relationship with previous shell operations

Oh?

% rm *
% touch foo1 bar1    # this calls creat() or open() or similar
% touch foo2 bar2	# as will this...
% echo foo*	# and this will do a readdir(), presumably

Do you have any expectations what the echo will do?  Obviously the glob
DOES have a relationship with previous shell operations.

The point is that *if* we assume that glibc is going to do some magic
conversion when creating a file, we are assuming that glibc will *always* keep
the conversion hidden. No matter what.  Because the user now has expectations
of what that file was called when he created it - the string he passed to
open()/creat().  If what gets handed to the kernel is something different, we
have to make sure that the user never finds out about it.

And if there's special iso8859-* chars in the filename, this means that the magic
handwave to convert to utf-8 inside glibc will either have to do it in-place (mangling
the user-supplied filename, and bad karma) or it gets to call malloc() to get a work
space (can't use a 'static char[MAXPATHLEN]', that's not thread-safe.

This gets *very* interesting if the malloc() fails.. ;)

--==_Exmh_2028654288P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMQTQcC3lWbTT17ARAqxCAKCRijGqLDQqozKdBRF31W7WX3fDdwCfT72f
v9NGPCsJlBgrLr2ygRK2/Tw=
=2DBH
-----END PGP SIGNATURE-----

--==_Exmh_2028654288P--
