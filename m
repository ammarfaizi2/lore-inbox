Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTJ0M4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTJ0M4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:56:42 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:3486 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261699AbTJ0M4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:56:35 -0500
Message-ID: <3F9D1557.4050404@cyberone.com.au>
Date: Mon, 27 Oct 2003 23:53:43 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
CC: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [RFC][PATCH] must fix lists
References: <3F94C833.8040204@cyberone.com.au>	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>	 <20031023172323.A10588@osdlab.pdx.osdl.net> <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------070907000208060905050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907000208060905050804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OK, I have incorporated comments. If everyone could try to keep your entries
on the list up to date it would be nice. It might give you a bit more
bargaining power to get things in.

I'll continue to try to keep things together until people get sick of it,
but its not easy working out exactly where people are up to with most 
things.

Everyone has to work extra hard to clear this list for 2.6.0, but that
doesn't look realistic. Hopefully it can be done before 2.7 branches. I
guess the security fixes audit is the most important thing for 2.6.0.


--------------070907000208060905050804
Content-Type: text/plain;
 name="mustfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mustfix.patch"

 l-2.6-npiggin/Documentation/must-fix.txt   |   49 +++++++----------------------
 l-2.6-npiggin/Documentation/should-fix.txt |   26 +--------------
 2 files changed, 16 insertions(+), 59 deletions(-)

diff -puN Documentation/must-fix.txt~mustfix Documentation/must-fix.txt
--- l-2.6/Documentation/must-fix.txt~mustfix	2003-10-27 23:33:03.000000000 +1100
+++ l-2.6-npiggin/Documentation/must-fix.txt	2003-10-27 23:39:48.000000000 +1100
@@ -13,17 +13,11 @@ o TTY locking is broken.
 
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
+o viro: tty_driver refcounting, tty/misc/upper levels of sound still not
+  completely fixed.
 
 drivers/block/
 ~~~~~~~~~~~~~~
@@ -33,16 +27,6 @@ o ideraid hasn't been ported to 2.5 at a
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
 
@@ -84,14 +68,6 @@ o viro: actually, misc.c has a good chan
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
 
@@ -176,6 +152,8 @@ o rmk: I have a pending todo: I need to 
 
 o James B: USB hot-removal crash: "It's a known scsi refcounting issue."
 
+o James B: refcounting issues in SCSI and in the block layer.
+
 fs/
 ~~~
 
@@ -333,11 +311,15 @@ o rmk: need to complete ALSA-ification o
 global
 ~~~~~~
 
-o 64-bit dev_t.  Seems almost ready, but it's not really known how much
-  work is still to do.  Patches exist in -mm but with the recent rise of the
-  neo-viro I'm not sure where things are at.
+o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
+  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?
+
+o viro: 64-bit dev_t (not a mustfix for 2.6.0). 32-bit dev_t is done, 64-bit
+  means extra work on nfsd/raid/etc.
 
-o Lots of 2.4 fixes including some security are not in 2.5
+o alan: Forward port 2.4 fixes
+  - Security fixes including execve holes, execve vs proc races
+  - SiS IRQ routing for newer SiS and older Intel
 
 o There are about 60 or 70 security related checks that need doing
   (copy_user etc) from Stanford tools.  (badari is looking into this, and
@@ -345,10 +327,5 @@ o There are about 60 or 70 security rela
 
 o A couple of hundred real looking bugzilla bugs
 
-o viro: cdev rework.  Main group is pretty stable and I hope to feed it to
-  Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff
-
-o Athlon prefetch oopses sometimes.  It is currently disabled, and needs to
-  be fixed.
-
+o viro: cdev rework. Mostly done.
 
diff -puN Documentation/should-fix.txt~mustfix Documentation/should-fix.txt
--- l-2.6/Documentation/should-fix.txt~mustfix	2003-10-27 23:33:03.000000000 +1100
+++ l-2.6-npiggin/Documentation/should-fix.txt	2003-10-27 23:36:43.000000000 +1100
@@ -10,13 +10,8 @@ PRI3:	Not very important
 drivers/block/
 ~~~~~~~~~~~~~~
 
-o Framework for selecting IO schedulers.  This is the main one really. 
-  Once this is in place we can drop in new schedulers any old time, no risk.
-  Nick Piggin has code for this.
-
-  PRI1
-
-o viro: paride drivers need a big cleanup
+o viro: paride drivers need a big cleanup. Partially done, but ATAPI drivers
+  need serious work and bug fixing.
 
   PRI2
 
@@ -145,15 +140,7 @@ o (Trond:) Yes: I'm still working on an 
 
    PRI2 (?)
 
-o (Chuck Lever <cel@citi.umich.edu>): NFS O_DIRECT support must be
-  completed.  The best approach is to fall back to something like the 2.4 NFS
-  O_DIRECT support, which issues RPCs synchronously and uses the RPC
-  completion mechanism to wait for I/O completion.
-
-  PRI2
-
-o viro: cleaning up options-parsers in filesystems.  (patch exists, needs
-  porting).
+o viro: convert more filesystems to use lib/parser.c for options.
 
   PRI2
 
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

--------------070907000208060905050804--

