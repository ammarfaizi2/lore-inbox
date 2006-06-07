Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWFGAdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWFGAdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFGAdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:33:12 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:33988
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751406AbWFGAdJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:33:09 -0400
Message-Id: <200606070033.k570X6Bu007481@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quick close of all the open files.
In-Reply-To: Your message of "Wed, 07 Jun 2006 03:32:58 +0530."
             <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com> <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
            <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149640386_5025P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jun 2006 20:33:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149640386_5025P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Jun 2006 03:32:58 +0530, vamsi krishna said:
> > For bonus points, how did you verify that all the open files were closed?
> >
> I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
> it prints 3

Which proves that file descriptor 3 was closed, so tmpfile() was able to
open it.  This certainly implies that fd 0, 1, 2 (connected to stdin,
stdout, and stderr streams of stdio) are still open, contrary to your
statement that *all* of them are closed.

If file descriptor 3 is closed, but 4 is open, what does tmpfile()
do? Hint - tmpfile() ends up invoking open(), and the manpage for that says:

       Given a pathname for a file, open() returns a file descriptor, a small,
       non-negative integer for  use  in  subsequent  system  calls  (read(2),
       write(2), lseek(2), fcntl(2), etc.).  The file descriptor returned by a
       successful call will be the lowest-numbered file  descriptor  not  cur-
       rently open for the process.

So.. explain why you think that "all files were closed"?  We know that 0..2
were open, and we know nothing about 4..1023.

This doesn't look like a kernel bug, you may want to continue the discussion
on one of the various "beginning Linux C programming" lists.

On Tue, 06 Jun 2006 23:03:38 BST, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= said:
> > (Hint - what does that fp->_chain = stderr *really* do? ;)
> 
> As it touches the innards of the FILE type, it invokes undefined
> behavior.  Nothing that follows can be considered a bug.

Invoking undefined behavior is often considered a bug itself.  And it's
certainly happening in userspace.. so there's a userspace bug. ;)

--==_Exmh_1149640386_5025P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhh7CcC3lWbTT17ARAkhpAKCOceijC264OaSPpMjVElPN7TnDiQCgwSuX
ntG8xYzTvYtcNj71g5XxLEA=
=kjBK
-----END PGP SIGNATURE-----

--==_Exmh_1149640386_5025P--
