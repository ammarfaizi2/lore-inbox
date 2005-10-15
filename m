Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVJOSiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVJOSiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJOSiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:38:06 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:1850 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751195AbVJOSiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bW1mYH7oE8wtW2xaOYMeKBLTBr0kUsE96QHlVIQ0xC77gN3R579Uo//6sUqbLVXYTuFyg3r8lxisXZ+QK0FQmkM/C1/FQhYb7W6o/p+c8W+UKQpNm+ijuKWzBSnJ3rZxgcgBPs3d3v2kv/GSvTljmalSRitKwvfwaxXyHezNgEc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ksymoops related docs update
Date: Sat, 15 Oct 2005 20:40:59 +0200
User-Agent: KMail/1.8.2
Cc: "Richard E. Gooch" <rgooch@atnf.csiro.au>,
       Patrick Caulfield <patrick@tykepenguin.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Morton <akpm@osdl.org>, Chris Ricker <kaboom@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510152040.59350.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After getting some feedback on the initial version of this patch
I decided to rework it a bit and also update *all* references to
ksymoops in Documentation/ instead of only the Changes file.

Please consider merging.


Update ksymoops related documentation to reflect current 2.6 reality.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/Changes                        |   11 ++++++++---
 Documentation/filesystems/devfs/README       |    5 -----
 Documentation/networking/decnet.txt          |    2 --
 Documentation/oops-tracing.txt               |    2 +-
 Documentation/video4linux/bttv/README.freeze |    6 +++---
 5 files changed, 12 insertions(+), 14 deletions(-)

--- linux-2.6.14-rc4-git4-orig/Documentation/Changes	2005-10-11 22:40:49.000000000 +0200
+++ linux-2.6.14-rc4-git4/Documentation/Changes	2005-10-15 20:28:26.000000000 +0200
@@ -139,9 +139,14 @@
 Ksymoops
 --------
 
-If the unthinkable happens and your kernel oopses, you'll need a 2.4
-version of ksymoops to decode the report; see REPORTING-BUGS in the
-root of the Linux source for more information.
+If the unthinkable happens and your kernel oopses, you may need the
+ksymoops tool to decode it, but in most cases you don't.
+In the 2.6 kernel it is generally preferred to build the kernel with
+CONFIG_KALLSYMS so that it produces readable dumps that can be used as-is
+(this also produces better output than ksymoops).
+If for some reason your kernel is not build with CONFIG_KALLSYMS and
+you have no way to rebuild and reproduce the Oops with that option, then
+you can still decode that Oops with ksymoops.
 
 Module-Init-Tools
 -----------------
--- linux-2.6.14-rc4-git4-orig/Documentation/filesystems/devfs/README	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4-git4/Documentation/filesystems/devfs/README	2005-10-15 20:28:51.000000000 +0200
@@ -1812,11 +1812,6 @@
 you can
 
 
-if you get an Oops, run ksymoops to decode it so that the
-names of the offending functions are provided. A non-decoded Oops is
-pretty useless
-
-
 send a copy of your devfsd configuration file(s)
 
 send the bug report to me first.
--- linux-2.6.14-rc4-git4-orig/Documentation/networking/decnet.txt	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4-git4/Documentation/networking/decnet.txt	2005-10-15 20:29:04.000000000 +0200
@@ -176,8 +176,6 @@
  - Which client caused the problem ?
  - How much data was being transferred ?
  - Was the network congested ?
- - If there was a kernel panic, please run the output through ksymoops
-   before sending it to me, otherwise its _useless_.
  - How can the problem be reproduced ?
  - Can you use tcpdump to get a trace ? (N.B. Most (all?) versions of 
    tcpdump don't understand how to dump DECnet properly, so including
--- linux-2.6.14-rc4-git4-orig/Documentation/oops-tracing.txt	2005-10-11 22:40:49.000000000 +0200
+++ linux-2.6.14-rc4-git4/Documentation/oops-tracing.txt	2005-10-15 20:29:44.000000000 +0200
@@ -1,6 +1,6 @@
 NOTE: ksymoops is useless on 2.6.  Please use the Oops in its original format
 (from dmesg, etc).  Ignore any references in this or other docs to "decoding
-the Oops" or "running it through ksymoops".  If you post an Oops fron 2.6 that
+the Oops" or "running it through ksymoops".  If you post an Oops from 2.6 that
 has been run through ksymoops, people will just tell you to repost it.
 
 Quick Summary
--- linux-2.6.14-rc4-git4-orig/Documentation/video4linux/bttv/README.freeze	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4-git4/Documentation/video4linux/bttv/README.freeze	2005-10-15 20:30:17.000000000 +0200
@@ -27,9 +27,9 @@
 protection faults (so-called "kernel oops").
 
 If you run into some kind of deadlock, you can try to dump a call trace
-for each process using sysrq-t (see Documentation/sysrq.txt).  ksymoops
-will translate these dumps into kernel symbols too.  This way it is
-possible to figure where *exactly* some process in "D" state is stuck.
+for each process using sysrq-t (see Documentation/sysrq.txt).
+This way it is possible to figure where *exactly* some process in "D"
+state is stuck.
 
 I've seen reports that bttv 0.7.x crashes whereas 0.8.x works rock solid
 for some people.  Thus probably a small buglet left somewhere in bttv



