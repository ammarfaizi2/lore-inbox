Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTEUIG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTEUIG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 04:06:27 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:42157 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261869AbTEUIFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 04:05:52 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16075.4932.688157.313542@laputa.namesys.com>
Date: Wed, 21 May 2003 09:48:52 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: root@chaos.analogic.com
Cc: Robert White <rwhite@casabyte.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <Pine.LNX.4.53.0305201709440.1074@chaos>
References: <PEEPIDHAKMCGHDBJLHKGKEGCCMAA.rwhite@casabyte.com>
	<Pine.LNX.4.53.0305201709440.1074@chaos>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Drdoom-Fodder: CERT drdoom satan crash crypt passwd root
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
 > On Tue, 20 May 2003, Robert White wrote:
 > 
 > >
 > >
 > > -----Original Message-----
 > > From: Richard B. Johnson [mailto:root@chaos.analogic.com]
 > > Sent: Tuesday, May 20, 2003 5:23 AM
 > > To: Helge Hafting
 > >
 > > > Recursive locking is a misnomer. It does during run-time that which
 > > > should have been done during design-time. In fact, there cannot
 > > > be any recursion associated with locking. A locking mechanism that
 > > > allows reentry or recursion is defective, both in design, and
 > > > implementation.
 > >
 > > Amusing... but false...
 > >
 > > A lock serves, and is defined by, exactly _ONE_ trait.  A lock asserts and
 > > guarantees exclusive access to a domain (group of data or resources etc).
 > >
 > 
 > The "ONE" trait is incorrect.
 > 
 > The lock must guarantee that recursion is not allowed. Or to put
 > it more bluntly, the lock must result in a single thread of execution
 > through the locked object.
 > 

Suppose you have a set of objects X, each containing pointer to object
from set Y, each y in Y being protected by a lock. To update pointer in
x from y to y' one has to take lock on y, and global lock G in this
order. To read pointer, it is enough to take G. Several x's may point to
the same y.

How to lock all y's pointed to by elements of X?

If you have recursive locking one may just: 

1. take each x from X in turn
2.     lock G
3.     take y pointed to by x
4.     unlock G
5.     lock y
6.     lock G
7.     re-check that y is still pointed to by x, and if not unlock y and go to 3
8.     unlock G

Without recursive locking what would one do, but emulate it?

Nikita.

