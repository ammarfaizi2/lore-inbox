Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143465AbRA1QWy>; Sun, 28 Jan 2001 11:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143435AbRA1QWn>; Sun, 28 Jan 2001 11:22:43 -0500
Received: from fungus.teststation.com ([212.32.186.211]:28887 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S143465AbRA1QWf>; Sun, 28 Jan 2001 11:22:35 -0500
Date: Sun, 28 Jan 2001 17:22:32 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <linux-kernel@vger.kernel.org>
cc: Rainer Mager <rmager@vgkk.com>, "Scott A. Sibert" <kernel@hollins.edu>
Subject: [patch] smbfs cache rewrite - 2nd try
Message-ID: <Pine.LNX.4.30.0101242116520.30884-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again

This patch is more complete than the version posted earlier. It implements
support for OS/2 (and possibly things even older than that :) and have
been more tested. This borrows a lot from the ncpfs dircache code.

Smbfs testers wanted, with or without highmem boxes.


Bugs (believed) fixed vs 2.4.1-pre10:
+ cache code would oops/lockup on highmem machines (too many kmap'ed pages
  and possibly a few other things)
+ readpage/writepage could oops on highmem machines (missing kmap)
+ listing long directories would fail on some dirs on some types of servers
  (from 2.2.18, has nothing to do with the cache code)

Improvements:
+ new cache code creates dentries and inodes from the "findfirst" data,
  reducing the number of smb requests needed to list a directory (ls -l)
  from n/x + n to n/x (where x is the number of entries that fit in one
  request).
+ new mount option, ttl, allows control over how long the cache is
  considered valid, default ttl=1000 (1 second).

Bugs introduced:
- date conversion may need to do timezone conversion in smbfs
- 'd; touch dd; d; rm DD; d', where d is an alias for ls -alF, will crash
  on the rm if the server is "old", tested vs a samba server configured to
  talk "LANMAN1". Does not crash when using "NT1".
  Don't know if this is a new or old bug yet.
- more?
  (this is where you come in ...)


Download ~57k from:
http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.1-pre10-cache-2.patch
(Apply using 'patch -p1' from the linux directory.)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
