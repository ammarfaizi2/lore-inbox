Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTIQFOd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTIQFOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:14:31 -0400
Received: from dyn-ctb-203-221-73-208.webone.com.au ([203.221.73.208]:14853
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262064AbTIQFO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:14:26 -0400
Message-ID: <3F67EDAF.40608@cyberone.com.au>
Date: Wed, 17 Sep 2003 15:14:23 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] must fix list
Content-Type: multipart/mixed;
 boundary="------------060002060700040703020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060002060700040703020904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I don't know what happened to this, but I thought it was quite good.
Maybe I missed something?

Anyway I have removed AS from the list because it is done. I removed CFQ
as well because when the schedulers become runtime selectable (sometime
I hope), merging it becomes a non issue, even during the stable series I
think.

I updated the kernel/sched.c section a bit.

I moved 64-bit dev_t from should fix to must fix.

It looks like quite a bit can be struck off, but I'll leave it up to those
who actually did the work.

Maybe these should go in Documentation/must-fix/ to make patching and
syncing easier?


--------------060002060700040703020904
Content-Type: text/plain;
 name="must-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="must-fix.patch"

diff -Nrup old/must-fix-6.txt new/must-fix-6.txt
--- old/must-fix-6.txt	2003-09-17 14:58:13.000000000 +1000
+++ new/must-fix-6.txt	2003-09-17 15:03:49.000000000 +1000
@@ -270,28 +270,10 @@ o trond: NFS has a mmap-versus-truncate 
 kernel/sched.c
 ~~~~~~~~~~~~~~
 
-o "Persistent starvation"
+o Interactivity needs fixing. Con's patches are the most widely tested and
+  accepted.
 
-  http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
-
-  ingo: "basically by calling sleep(1) in an infinite loop you can end up
-  expiring yourself.  The testcode (test-starve.c) triggers this.  This is
-  solved by going to sub-timeslices.  Which i've got done a few weeks ago and
-  it has seen some testing by others as well.
-
-o Overeager affinity in presence of repeated yields
-
-  http://www.hpl.hp.com/research/linux/kernel/o1-openmp.php
-
-  ingo: this is valid.  fix is in progress.
-
-o The "thud.c" test app.  This is a exploit for the interactivity
-  estimator.  it's unlikely to bite in real-world cases.  Needs watching. 
-  Can be ameliorated by setting nice values.
-
-o generic interactivity problems need watching.  We've closed down a number
-  of items recently without introducing new ones, so i'm confident this is
-  heading in the right direction.
+o Starvation, general interactivity need close monitoring.
 
 kernel/
 ~~~~~~~
@@ -442,6 +424,10 @@ o rmk: need to complete ALSA-ification o
 global
 ~~~~~~
 
+o 64-bit dev_t.  Seems almost ready, but it's not really known how much
+  work is still to do.  Patches exist in -mm but with the recent rise of the
+  neo-viro I'm not sure where things are at.
+
 o Lots of 2.4 fixes including some security are not in 2.5
 
 o HZ=1000 caused lots of lost timer interrupts.  ACPI or SMM.  (andi,
diff -Nrup old/should-fix-6.txt new/should-fix-6.txt
--- old/should-fix-6.txt	2003-09-17 14:58:13.000000000 +1000
+++ new/should-fix-6.txt	2003-09-17 15:09:44.000000000 +1000
@@ -12,18 +12,11 @@ drivers/block/
 
 o Framework for selecting IO schedulers.  This is the main one really. 
   Once this is in place we can drop in new schedulers any old time, no risk.
+  Jens has much of this code in place, but it needs the sysfs implementation
+  done.
 
   PRI1
 
-o Anticipatory scheduler.  Working OK now, still has problems with seeky
-  OLTP-style loads.
-
-  PRI1
-
-o CFQ scheduler.  Seems to work but Jens planning significant rework.
-
-  PRI2
-
 o cryptoloop: jmorris: There's no cryptoloop in the 2.4 mainline kernel,
   but I think every distro ships some version.  It would probably be useful
   to have crypto natively supported in 2.6, with backward compatibility for
@@ -380,12 +373,6 @@ o Pat: There are already CPU device stru
 global
 ~~~~~~
 
-o 64-bit dev_t.  Seems almost ready, but it's not really known how much
-  work is still to do.  Patches exist in -mm but with the recent rise of the
-  neo-viro I'm not sure where things are at.
-
-  PRI1
-
 o We need a kernel side API for reporting error events to userspace (could
   be async to 2.6 itself)
 

--------------060002060700040703020904--

