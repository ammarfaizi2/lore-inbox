Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTKDAwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 19:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTKDAwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 19:52:39 -0500
Received: from smtp-out.gseis.ucla.edu ([149.142.5.25]:62123 "EHLO
	smtp-out.gseis.ucla.edu") by vger.kernel.org with ESMTP
	id S263580AbTKDAwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 19:52:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bill Akers <akers@gseis.ucla.edu>
Organization: UCLA GSE&IS
To: linux-kernel@vger.kernel.org
Subject: nfs NLM locks greater than 8 bytes
Date: Mon, 3 Nov 2003 16:52:35 -0800
User-Agent: KMail/1.4.3
X-First-Law: TANSTAAFL
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200311031652.36074.akers@gseis.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Has anyone looked at the NFS NLM byte lock size issue between the Linux kernel 
based NFS server and BSD 5 clients?  BSD 5 uses a large cookie for locking 
(16 or even 20 bytes).  Linux automatically rejects any lock attempts with a 
cookie over 8 bytes.  This issue has become important for us because of 
Apple's release of OS X 10.3 (Panther), which is based on BSD 5.

Jonathan Lennox summed it up pretty well on the Freebsd bug list:

> Linux's implementation of NFS NLM locks is buggy: it doesn't support lock
> cookies longer than 8 bytes in size.  See the comment in
> <http://lxr.linux.no/source/include/linux/lockd/xdr.h?v=2.6.0-test2> on the
> definition of 'struct nlm_cookie': "NLM cookies. Technically they can be 1K,
> Nobody uses over 8 bytes however."
>
> Unfortunately, this is actually "nobody" except FreeBSD 5.x, which uses
> 16-byte cookies.  As a result, any attempt by a FreeBSD client to lock an
> NFS-mounted file from a Linux server results in the process on the FreeBSD
> client hanging, unkillably.

His full original post is:
http://lists.freebsd.org/pipermail/freebsd-bugs/2003-September/003069.html

I have checked out every recent version of the kernel on kernel.org (2.4 and 
2.6) and haven't seen any modifications to xdr.h or xdr.c that might address 
this issue.  Nor have I been able to find any posts on Linux lists that 
discuss the issue.  There is a BSD patch to dumb down their client code and 
make the cookie size smaller.  The fear being that it will take a long time 
to get a linux patch into the kernel.  But if no one has even brought up the 
issue here, it will certainly take forever.  :-)

I can probably dust off enough of my old coding skills to up the check from 8 
bytes to some higher number (16, 20, 1024 bytes?).  But I certainly don't 
know enough about the Linux kernel to know what ramifications that will have.

Thanks,

- -- 
Bill Akers
Director of Network Operations
UCLA Graduate School of Education and Information Studies
akers@gseis.ucla.edu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/pvhUHuBhMoY9pyIRAn5iAKCpWedBMVY4c41vz1/dNicIx1WJNACcClN2
jf6yR5yyOxTD0i1kx91Tyiw=
=+5DB
-----END PGP SIGNATURE-----


