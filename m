Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUDHPo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUDHPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:44:25 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:29315 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261915AbUDHPoX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:44:23 -0400
Message-Id: <200404081544.i38FiNdf014220@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Wed, 07 Apr 2004 21:07:56 PDT."
             <20040408040756.95337.qmail@web40508.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040408040756.95337.qmail@web40508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1660943824P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Apr 2004 11:44:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1660943824P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Apr 2004 21:07:56 PDT, Sergiy Lozovsky said:

> Actually one 'dynamic' feature is implemented in VXE.
> In ordinary system resource has permissions which
> allows access or not. For higher security VXE can
> count number of allowed accesses. For example, we are
> securing POP server. We allow it to open /etc/passwd,
> /etc/shadow for reading only once (counter is 1). So,
> if hacker breaks to POP server after it opened
> /etc/passwd - there is no way hacker can open this
> file.

Unless he finds an already open file descriptor for it and uses
read()/write()/mmap()/etc - did you audit your POP server
to make *really* sure that endpwent() is called at all the right
times, and that said function actually is guaranteed to close()
the file descriptor, and can't be forced into failing? (Note that
this can be caused by either close() syscall failing, or the attacker
managing to hijack the function entry point for either endpwent()
or close()....)

Unless he finds a copy of the file on the process heap (more than
one information leakage issue has come from THAT sort of problem)

Unless he opens a new file on the system, and writes a binary into
it, chmod's it to executable, and does a pipe/fork/exec and use
that program's quota of opens to read it...

And that's just the *obvious* end runs.  As somebody else noted,
writing the code is the easy part....

--==_Exmh_1660943824P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdXNWcC3lWbTT17ARAvb6AKCWaOTyw+qocfdVdMCyTFrXkQ1zHgCZAZX1
cGPcINBZMmx9fnycPjKkd6M=
=Cc74
-----END PGP SIGNATURE-----

--==_Exmh_1660943824P--
