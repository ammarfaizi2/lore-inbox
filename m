Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTESLZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTESLZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:25:01 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:232 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262403AbTESLY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:24:59 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16072.49680.630299.103453@laputa.namesys.com>
Date: Mon, 19 May 2003 15:37:52 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <3EC8B1FC.9080106@aitel.hist.no>
References: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
	<3EC8B1FC.9080106@aitel.hist.no>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
Emacs: an inspiring example of form following function... to Hell.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting writes:
 > Peter T. Breuer wrote:
 > 
 > > Hey, that's not bad for a small change! 50% of potential programming
 > > errors sent to the dustbin without ever being encountered.
 > 
 > Then you replace errors with inefficiency - nobody discovers that
 > you needlessly take a lock twice.  They notice OOPSes though, the
 > lock gurus can then debug it.
 > 
 > Trading performance for simplicity is ok in some cases, but I have a strong
 > felling this isn't one of them.  Consider how people optimize locking
 > by shaving off a single cycle when they can, and try to avoid
 > locking as much as possible for that big smp scalability.
 > 
 > This is something better done right - people should just take the
 > trouble.

There, however, are cases when recursive locking is needed. Take, for
example, top-to-bottom insertion into balanced tree with per-node
locking. Once modifications are done at the "leaf" level, parents should
be locked and modified, but one cannot tell in advance whether different
leaves have the same or different parents. Simplest (and, sometimes, the
only) solution here is to lock parents of all children in turn, even if
this may lock the same parent node several times---recursively.

 > 
 > Helge Hafting
 > 

Nikita.

