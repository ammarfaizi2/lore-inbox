Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTJUFqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbTJUFqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 01:46:52 -0400
Received: from dyn-ctb-210-9-241-130.webone.com.au ([210.9.241.130]:24838 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262942AbTJUFqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 01:46:47 -0400
Message-ID: <3F94C833.8040204@cyberone.com.au>
Date: Tue, 21 Oct 2003 15:46:27 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC] must fix lists
Content-Type: multipart/mixed;
 boundary="------------060403050801090400010303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403050801090400010303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following people have their names in Documentation/must-fix.txt. Lots
of others in should-fix.txt in 2.6.0-test8-mm1. Please review your entries.
Also, please add any other substantial changes you need before 2.6. Thanks.

Al Viro
Alan
Albert Cahalan
Andi
Badari Pulavarty
brodo
Dave M
Dipankar
hch
hollisb
Ingo
James B
Jens
lmb
Mike Anderson
Patrick Mansfield
rmk
Rusty
Trond

(Maybe missed a couple)


--------------060403050801090400010303
Content-Type: text/plain;
 name="mustfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mustfix.patch"

 linux-2.6-npiggin/Documentation/must-fix.txt   |   44 -------------------------
 linux-2.6-npiggin/Documentation/should-fix.txt |   20 -----------
 2 files changed, 64 deletions(-)

diff -puN Documentation/must-fix.txt~mustfix Documentation/must-fix.txt
--- linux-2.6/Documentation/must-fix.txt~mustfix	2003-10-20 19:37:24.000000000 +1000
+++ linux-2.6-npiggin/Documentation/must-fix.txt	2003-10-20 20:06:26.000000000 +1000
@@ -13,17 +13,9 @@ o TTY locking is broken.
 
   o somebody will have to document the tty driver and ldisc API
 
-o Lack of test cases and/or stress tests is a problem.  Contributions and
-  suggestions are sought.
-
-o Lots of drivers are using cli/sti and are broken.
-
 drivers/tty
 ~~~~~~~~~~~
 
-o viro: we need to fix refcounting for tty_driver (oopsable race, must fix
-  anyway, hopefully about a week until it's merged) then we can do
-  tty/misc/upper levels of sound.
 
 drivers/block/
 ~~~~~~~~~~~~~~
@@ -33,16 +25,6 @@ o ideraid hasn't been ported to 2.5 at a
   We need to understand whether the proposed BIO split code will suffice
   for this.
 
-o CD burning.  There are still a few quirks to solve wrt SG_IO and ide-cd.
-
-  Jens: The basic hang has been solved (double fault in ide-cd), there still
-  seems to be some cases that don't work too well.  Don't really have a
-  handle on those :/
-
-o lmb: Last time I looked at the multipath code (2.5.50 or so) it also
-  looked pretty broken; I plan to port forward the changes we did on 2.4
-  before KS.
-
 drivers/input/
 ~~~~~~~~~~~~~~
 
@@ -55,20 +37,6 @@ o viro: parport is nearly as bad as that
   IMO parport is more of "figure out what API changes are needed for its
   users, get them done ASAP, then fix generic layer at leisure"
 
-o (Albert Cahalan) Lots of people (check Google) get this message from the
-  kernel:
-
-  psmouse.c: Lost synchronization, throwing 2 bytes away.
-
-  (the number of bytes will be 1, 2, or 3)
-
-  At work, I get it when there is heavy NFS traffic.  The mouse goes crazy,
-  jumping around and doing random cut-and-paste all over everything.  This
-  is with a decently fast and modern PC.
-
-o There seem to be too many reports of keyboards and mice failing or acting
-  strangely.
-
 
 drivers/misc/
 ~~~~~~~~~~~~~
@@ -84,14 +52,6 @@ o viro: actually, misc.c has a good chan
 drivers/net/
 ~~~~~~~~~~~~
 
-o rmk: network drivers.  ARM people like to add tonnes of #ifdefs into
-  these to customise them to their hardware platform (eg, chip access
-  methods, addresses, etc.) I cope with this by not integrating them into my
-  tree.  The result is that many ARM platforms can't be built from even my
-  tree without extra patches.  This isn't sane, and has bred a culture of
-  network drivers not being submitted.  I don't see this changing for 2.6
-  though.
-
 drivers/net/irda/
 ~~~~~~~~~~~~~~~~~
 
@@ -348,7 +308,3 @@ o A couple of hundred real looking bugzi
 o viro: cdev rework.  Main group is pretty stable and I hope to feed it to
   Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff
 
-o Athlon prefetch oopses sometimes.  It is currently disabled, and needs to
-  be fixed.
-
-
diff -puN Documentation/should-fix.txt~mustfix Documentation/should-fix.txt
--- linux-2.6/Documentation/should-fix.txt~mustfix	2003-10-20 19:37:27.000000000 +1000
+++ linux-2.6-npiggin/Documentation/should-fix.txt	2003-10-20 20:21:24.000000000 +1000
@@ -10,12 +10,6 @@ PRI3:	Not very important
 drivers/block/
 ~~~~~~~~~~~~~~
 
-o Framework for selecting IO schedulers.  This is the main one really. 
-  Once this is in place we can drop in new schedulers any old time, no risk.
-  Nick Piggin has code for this.
-
-  PRI1
-
 o viro: paride drivers need a big cleanup
 
   PRI2
@@ -145,13 +139,6 @@ o (Trond:) Yes: I'm still working on an 
 
    PRI2 (?)
 
-o (Chuck Lever <cel@citi.umich.edu>): NFS O_DIRECT support must be
-  completed.  The best approach is to fall back to something like the 2.4 NFS
-  O_DIRECT support, which issues RPCs synchronously and uses the RPC
-  completion mechanism to wait for I/O completion.
-
-  PRI2
-
 o viro: cleaning up options-parsers in filesystems.  (patch exists, needs
   porting).
 
@@ -200,9 +187,6 @@ o klibc merge?
 mm/
 ~~~
 
-o objrmap: concerns over page reclaim performance at high sharing levels,
-  and interoperation with nonlinear mappings is hairy.
-
 o oxymoron's async write-error-handling patch
 
   PRI1
@@ -514,10 +498,6 @@ o NMI watchdog seems to tick too fast
 
   PRI2
 
-o not very well tested. probably more bugs lurking.
-
-  PRI1
-
 o need to coredump 64bit vsyscall code with dwarf2
 
   PRI2

_

--------------060403050801090400010303--

