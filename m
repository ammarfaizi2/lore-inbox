Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTJWXsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJWXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:48:22 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:45028 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261899AbTJWXrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:47:49 -0400
Message-ID: <3F986859.2000101@cyberone.com.au>
Date: Fri, 24 Oct 2003 09:46:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: "viro@parcelfarce.linux.theplanet.co.uk" 
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
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] must fix lists
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------090805050809040807040205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090805050809040807040205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Alan Cox wrote:

>On Maw, 2003-10-21 at 06:46, Nick Piggin wrote:
>
>>The following people have their names in Documentation/must-fix.txt. Lots
>>
>
>Someone also needs to go fix all the 2.4 security holes still in 2.6
>last time I checked - things like the execve holes and execve versus
>proc races.
>
>

I put your name down for that entry Alan. I don't know who else is
aware of all the problems.

OK, a new patch. Includes everyone's suggestions. If anyone wants to
be removed from the CC list please email me privately.


--------------090805050809040807040205
Content-Type: text/plain;
 name="mustfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mustfix.patch"

 linux-2.6-npiggin/Documentation/must-fix.txt   |   37 ++++---------------------
 linux-2.6-npiggin/Documentation/should-fix.txt |   23 ---------------
 2 files changed, 7 insertions(+), 53 deletions(-)

diff -puN Documentation/must-fix.txt~mustfix Documentation/must-fix.txt
--- linux-2.6/Documentation/must-fix.txt~mustfix	2003-10-24 09:28:12.000000000 +1000
+++ linux-2.6-npiggin/Documentation/must-fix.txt	2003-10-24 09:38:22.000000000 +1000
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
 
@@ -84,14 +66,6 @@ o viro: actually, misc.c has a good chan
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
 
@@ -333,11 +307,16 @@ o rmk: need to complete ALSA-ification o
 global
 ~~~~~~
 
+o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
+  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?
+
 o 64-bit dev_t.  Seems almost ready, but it's not really known how much
   work is still to do.  Patches exist in -mm but with the recent rise of the
   neo-viro I'm not sure where things are at.
 
-o Lots of 2.4 fixes including some security are not in 2.5
+o alan: Forward port 2.4 fixes
+  - Security fixes including execve holes, execve vs proc races
+  - SiS IRQ routing for newer SiS and older Intel
 
 o There are about 60 or 70 security related checks that need doing
   (copy_user etc) from Stanford tools.  (badari is looking into this, and
@@ -348,7 +327,3 @@ o A couple of hundred real looking bugzi
 o viro: cdev rework.  Main group is pretty stable and I hope to feed it to
   Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff
 
-o Athlon prefetch oopses sometimes.  It is currently disabled, and needs to
-  be fixed.
-
-
diff -puN Documentation/should-fix.txt~mustfix Documentation/should-fix.txt
--- linux-2.6/Documentation/should-fix.txt~mustfix	2003-10-24 09:28:12.000000000 +1000
+++ linux-2.6-npiggin/Documentation/should-fix.txt	2003-10-24 09:29:55.000000000 +1000
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
@@ -145,15 +139,7 @@ o (Trond:) Yes: I'm still working on an 
 
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
 
@@ -200,9 +186,6 @@ o klibc merge?
 mm/
 ~~~
 
-o objrmap: concerns over page reclaim performance at high sharing levels,
-  and interoperation with nonlinear mappings is hairy.
-
 o oxymoron's async write-error-handling patch
 
   PRI1
@@ -514,10 +497,6 @@ o NMI watchdog seems to tick too fast
 
   PRI2
 
-o not very well tested. probably more bugs lurking.
-
-  PRI1
-
 o need to coredump 64bit vsyscall code with dwarf2
 
   PRI2

_

--------------090805050809040807040205--

