Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVCAXqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVCAXqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAXqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:46:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5643 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262135AbVCAXnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:43:32 -0500
Date: Wed, 2 Mar 2005 00:43:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.11-rc5-mm1 patch] reiser4 Kconfig help cleanup
Message-ID: <20050301234324.GJ4845@stusta.de>
References: <20050301012741.1d791cd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current reiser4 help texts have two disadvantages:
1. they are more marketing speech than technical speech with
   some debatable statements
2. they are too long


Examples for what I call "debatable statements":


          ReiserFS V3 is the stablest Linux filesystem, and V4 is the fastest.


All people I know who talked about serious data loss due to a filesystem 
damage were using reiser3.

That's not an objective measurement, but I have yet to see the proof 
that reiserfs plus reiserfs fsck is able to beat ext2 plus ext2 fsck
in terms of stability.


          In regards to claims by ext2 that they are the de facto
          standard Linux filesystem, the most polite thing to say is that
          many persons disagree, and it is interesting that those persons
          seem to include the distros that are growing in market share.
          See http://www.namesys.com/benchmarks.html for why many disagree.


ext2 was the de facto standard Linux filesystem at the time when this 
was written into the ext2 help text. I just checked kernel 2.0 (released 
more than eight and a half years ago) and this text was already there at 
that time (and it was accurate at that time). It was simply a leftover.

Unfortunately, most people will no longer be able to understand this 
"joke" in the reiser4 help text since my patch removing this from the 
ext2 help text because it's no longer accurate was included in kernel 
2.6.8 released more than half a year ago.




This patch shortens the help texts to include only the interesting 
technical information and to bring the help text to a lenght that is 
comparable to the help texts of other filesystems.

The pointer to http://www.namesys.com is still there, and people can 
get all the other information formerly in the help text from there 
of they are interested in more details.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/Kconfig |   81 +++++----------------------------------------
 1 files changed, 10 insertions(+), 71 deletions(-)

--- linux-2.6.11-rc5-mm1-full/fs/reiser4/Kconfig.old	2005-03-01 23:49:13.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/fs/reiser4/Kconfig	2005-03-02 00:31:02.000000000 +0100
@@ -1,27 +1,11 @@
 config REISER4_FS
-	tristate "Reiser4 (EXPERIMENTAL very fast general purpose filesystem)"
+	tristate "Reiser4 (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && !4KSTACKS
 	help
-	  Reiser4 is more than twice as fast for both reads and writes as
-	  ReiserFS V3, and is the fastest Linux filesystem, by a lot,
-	  for typical IO intensive workloads.  [It is slow at fsync
-	  intensive workloads as it is not yet optimized for fsync
-	  (sponsors are welcome for that work), and it is instead
-	  optimized for atomicity, see below.]  Benchmarks that define
-	  "a lot" are at http://www.namesys.com/benchmarks.html.
-
-	  It is the storage layer of what will become a general purpose naming
-	  system --- like what Microsoft wants WinFS to be except designed with a
-	  clean new semantic layer rather than being SQL based like WinFS.
-	  For details read http://www.namesys.com/whitepaper.html
-
-	  It performs all filesystem operations as atomic transactions, which
-	  means that it either performs a write, or it does not, and in the
-	  event of a crash it does not partially perform it or corrupt it.
-	  Many applications that currently use fsync don't need to if they use
-	  reiser4, and that means a lot for performance.  An API for performing
-	  multiple file system operations as one high performance atomic write
-	  is almost finished.
+	  Reiser4 is a filesystem that performs all filesystem operations
+	  as atomic transactions, which means that it either performs a
+	  write, or it does not, and in the event of a crash it does not
+	  partially perform it or corrupt it.
 
 	  It stores files in dancing trees, which are like balanced trees but
 	  faster.  It packs small files together so that they share blocks
@@ -30,45 +14,9 @@
 	  hassling you with anachronisms like having a maximum number of
 	  inodes, and wasting space if you use less than that number.
 
-	  It can handle really large directories, because its search
-	  algorithms are logarithmic with size not linear.  With Reiser4 you
-	  should use subdirectories because they help YOU, not because they
-	  help your filesystem's performance, or because your filesystem won't
-	  be able to shrink a directory once you have let it grow.  For squid
-	  and similar applications, everything in one directory should perform
-	  better.
-
-	  It has a plugin-based infrastructure, which means that you can easily
-	  invent new kinds of files, and so can other people, so it will evolve
-	  rapidly.
-
-	  We will be adding a variety of security features to it that DARPA has
-	  funded us to write.
-
-	  "reiser4" is a distinct filesystem mount type from "reiserfs" (V3),
-	  which means that "reiserfs" filesystems will be unaffected by any
-	  reiser4 bugs.
-
-	  ReiserFS V3 is the stablest Linux filesystem, and V4 is the fastest.
-
-	  In regards to claims by ext2 that they are the de facto
-	  standard Linux filesystem, the most polite thing to say is that
-          many persons disagree, and it is interesting that those persons
-	  seem to include the distros that are growing in market share.
-	  See http://www.namesys.com/benchmarks.html for why many disagree.
-
-          If you'd like to upgrade from reiserfs to reiser4, use tar to a
-	  temporary disk, maybe using NFS/ssh/SFS to get to that disk, or ask
-	  your favorite distro to sponsor writing a conversion program.
-
-	  Sponsored by the Defensed Advanced Research Projects Agency (DARPA)
-	  of the United States Government.  DARPA does not endorse this
-	  project, it merely sponsors it.
-	  See http://www.darpa.mil/ato/programs/chats.htm
-
-	  If you would like to learn about our plans to add
-	  military grade security to reiser4, please read
-	  http://www.namesys.com/blackbox_security.html.
+	  Reiser4 is a distinct filesystem type from reiserfs (V3).
+	  It's therefore not possible to use reiserfs file systems
+	  with reiser4.
 
 	  To learn more about reiser4, go to http://www.namesys.com
 
@@ -76,15 +24,6 @@
 	bool "Enable reiser4 debug mode"
 	depends on REISER4_FS
 	help
-	  Don't use this unless you are a developer debugging reiser4.  If
-	  using a kernel made by a distro that thinks they are our competitor
-	  (sigh) rather than made by Linus, always check each release to make
-	  sure they have not turned this on to make us look slow as was done
-	  once in the past.  This checks everything imaginable while reiser4
-	  runs.
+	  Don't use this unless you are debugging reiser4.
 
-	  When adding features to reiser4 you should set this, and then
-	  extensively test the code, and then send to us and we will test it
-	  again.  Include a description of what you did to test it.  All
-	  reiser4 code must be tested, reviewed, and signed off on by two
-	  persons before it will be accepted into a stable kernel by Hans.
+	  If unsure, say N.

