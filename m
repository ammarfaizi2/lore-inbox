Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVEDRaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVEDRaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVEDRZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:25:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64530 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261256AbVEDRNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:13:49 -0400
Message-Id: <200505041713.j44HDe9Y016718@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Serge van den Boom <svdb@stack.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/$PID/mem rationale 
In-Reply-To: Your message of "Wed, 04 May 2005 17:40:31 +0200."
             <20050504170503.L89175@toad.stack.nl> 
From: Valdis.Kletnieks@vt.edu
References: <20050504170503.L89175@toad.stack.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115226820_4721P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 13:13:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115226820_4721P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 May 2005 17:40:31 +0200, Serge van den Boom said:

> Could someone explain the reasoning behind these two design decisions
> regarding /proc/$PID/mem?
> - You can only read() from this file from a process which is attached to
>   the file's process through ptrace(). Why this requirement?
>   The following command line could be rather useful, but the ptrace()
>   requirement prevents this from working:
>       dd if=/proc/$SOME_PID/mem bs=1 seek=$ADDRESS

It's prohibited *because* it could be rather useful - to a hacker.  It's an
issue of information leakage - there are some corner cases where the permissions
on /proc/PID/mem would appear to allow a read, but you don't in fact want to
allow it (for the full list, look at the ptrace() code and the tests it makes
for things like euid != uid and so on).  There's a bunch of race conditions
in there too.

> - You can only read() from the mem file from the process that open()ed it.
>   Even if the ptrace() requirement were dropped, you wouldn't be able
>   to do something like the following command because of this:
>       dd bs=1 seek=$ADDRESS < /proc/$SOME_PID/mem

Same reasons.  ptrace() is able to make some checks and set some bits that
read() isn't allowed anywhere near (in particular, ptrace() can *stop* a process
so it can't race - read() can't do that.)



--==_Exmh_1115226820_4721P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCeQLEcC3lWbTT17ARAsidAKDtBsDcH/SoPrwPAyYA5OeFbYLlbQCg327s
p7VKmPkg1zqoas7M2WviWrE=
=1/JU
-----END PGP SIGNATURE-----

--==_Exmh_1115226820_4721P--
