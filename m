Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTGDCVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTGDCTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:19:49 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.5.4]:22715 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265691AbTGDCSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:18:23 -0400
Date: Thu, 03 Jul 2003 22:32:37 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH - RFC] [5/5] 64-bit network statistics - documentation
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200307032232.45830.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_FYny75bNLkjZXnh/XElm0A)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_FYny75bNLkjZXnh/XElm0A)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

64-bit network statistics:
	Part 5 of 5 - documentation

- -- 
Only two things are infinite, the universe and human stupidity, and I'm 
not sure about the former.
		- Albert Einstein


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BOdIwFP0+seVj/4RAq5jAKC5Aa8nif2ipuxbq5tnthmi9XtYuACfYQbb
gqrGGiaOR6u92+zDISWJxeY=
=shpM
-----END PGP SIGNATURE-----

--Boundary_(ID_FYny75bNLkjZXnh/XElm0A)
Content-type: text/x-diff; charset=us-ascii; name=doc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=doc.diff

diff -X dontdiff -Naur linux-2.5.74-vanilla/Documentation/networking/00-INDEX linux-2.5.74-nx/Documentation/networking/00-INDEX
--- linux-2.5.74-vanilla/Documentation/networking/00-INDEX	2003-07-02 16:53:01.000000000 -0400
+++ linux-2.5.74-nx/Documentation/networking/00-INDEX	2003-07-03 15:10:59.000000000 -0400
@@ -2,6 +2,8 @@
 	- this file
 3c505.txt
 	- information on the 3Com EtherLink Plus (3c505) driver.
+64bitstats.txt
+	- information about 64bit network statistics
 6pack.txt
 	- info on the 6pack protocol, an alternative to KISS for AX.25
 8139too.txt
diff -X dontdiff -Naur linux-2.5.74-vanilla/Documentation/networking/64bitstats.txt linux-2.5.74-nx/Documentation/networking/64bitstats.txt
--- linux-2.5.74-vanilla/Documentation/networking/64bitstats.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.5.74-nx/Documentation/networking/64bitstats.txt	2003-07-03 15:10:59.000000000 -0400
@@ -0,0 +1,77 @@
+The New API:
+------------
+
+net_stats_inc(<variable name>, <pointer to statistics struct>)
+	<pointer to statistics struct> -> <variable name> ++;
+
+net_stats_add(<variable name>, <up to u_int64_t>, <pointer to statistics struct>)
+	<pointer to statistics struct> -> <variable name> += <up to u_int64_t>;
+
+net_stats_set(<variable name>, <up to u_int64_t>, <pointer to statistics struct>)
+	<pointer to statistics struct> -> <variable name> = <up to u_int64_t>;
+
+net_stats_get(<variable name>, <pointer to statistics struct>)
+	return <pointer to statistics struct> -> <variable name>;
+
+
+Supported Drivers:
+------------------
+
+  - 8139too
+  - 8390
+  - dummy
+  - eepro100
+  - loopback
+  - ne2k-pci
+  - pcnet32
+
+
+How To Test:
+------------
+
+You want to flood the interface with as many packets/bytes/etc. as possible,
+so, you can either attach it to a very busy network (with a lot of broadcast
+traffic) or you can simulate this traffic using netcat in this fashion:
+
+host1$ netcat -l -p port > /dev/null < /dev/zero
+host2$ netcat host1 port > /dev/null < /dev/zero
+
+*WARNING* Running these commands will saturate the network, use them only if
+you know what you are doing. I cannot be held responsible for damages caused
+by the usage of these commands.
+
+
+Supported Architectures:
+-----------------------
+
+arch		reg. size	addr. space	support
+
+asm-alpha
+asm-arm		32 bit		32 bit		X
+asm-arm26	32 bit		26 bit		X
+asm-cris
+asm-h8300
+asm-i386	32 bit		32 bit		X
+asm-ia64	64 bit		64 bit		N
+asm-m68k
+asm-m68knommu
+asm-mips
+asm-mips64
+asm-parisc	64 bit				*1
+asm-ppc
+asm-ppc64
+asm-s390
+asm-sh
+asm-sparc					X
+asm-sparc64	64 bit		64 bit		N
+asm-um
+asm-v850
+asm-x86_64	64 bit		64 bit		N
+
+legend:
+--------
+	X  = full net_stats_* support
+	N  = native support
+	*1 - #error in 32-bit environment
+	-  = pseudo-support (using non-atomic instructions)
+	   = no support (doesn't compile)

--Boundary_(ID_FYny75bNLkjZXnh/XElm0A)--
