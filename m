Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWFUQqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWFUQqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFUQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:46:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932249AbWFUQqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:46:44 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Corrections to memory barrier doc
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 21 Jun 2006 17:46:37 +0100
Message-ID: <30957.1150908397@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apply some small corrections to the memory barrier document, as contributed by:

	Christoph Lameter <clameter@sgi.com>
	Kirill Smelkov <kirr@mns.spb.ru>
	Randy Dunlap <rdunlap@xenotime.net>

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/mb.diff 
 Documentation/memory-barriers.txt |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index cc53f47..cf0d541 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -287,7 +287,7 @@ Memory barriers come in four basic varie
      A write barrier is a partial ordering on stores only; it is not required
      to have any effect on loads.
 
-     A CPU can be viewed as as commiting a sequence of store operations to the
+     A CPU can be viewed as committing a sequence of store operations to the
      memory system as time progresses.  All stores before a write barrier will
      occur in the sequence _before_ all the stores after the write barrier.
 
@@ -418,7 +418,7 @@ There are certain things that the Linux 
      indirect effect will be the order in which the second CPU sees the effects
      of the first CPU's accesses occur, but see the next point:
 
- (*) There is no guarantee that the a CPU will see the correct order of effects
+ (*) There is no guarantee that a CPU will see the correct order of effects
      from a second CPU's accesses, even _if_ the second CPU uses a memory
      barrier, unless the first CPU _also_ uses a matching memory barrier (see
      the subsection on "SMP Barrier Pairing").
@@ -489,7 +489,7 @@ lines.  The pointer P might be stored in
 variable B might be stored in an even-numbered cache line.  Then, if the
 even-numbered bank of the reading CPU's cache is extremely busy while the
 odd-numbered bank is idle, one can see the new value of the pointer P (&B),
-but the old value of the variable B (1).
+but the old value of the variable B (2).
 
 
 Another example of where data dependency barriers might by required is where a
@@ -749,7 +749,7 @@ some effectively random order, despite t
 	                                        :       :
 
 
-If, however, a read barrier were to be placed between the load of E and the
+If, however, a read barrier were to be placed between the load of B and the
 load of A on CPU 2:
 
 	CPU 1			CPU 2
@@ -1466,9 +1466,8 @@ instruction itself is complete.
 
 On a UP system - where this wouldn't be a problem - the smp_mb() is just a
 compiler barrier, thus making sure the compiler emits the instructions in the
-right order without actually intervening in the CPU.  Since there there's only
-one CPU, that CPU's dependency ordering logic will take care of everything
-else.
+right order without actually intervening in the CPU.  Since there's only one
+CPU, that CPU's dependency ordering logic will take care of everything else.
 
 
 ATOMIC OPERATIONS
@@ -1645,9 +1644,9 @@ functions:
 
      The PCI bus, amongst others, defines an I/O space concept - which on such
      CPUs as i386 and x86_64 cpus readily maps to the CPU's concept of I/O
-     space.  However, it may also mapped as a virtual I/O space in the CPU's
-     memory map, particularly on those CPUs that don't support alternate
-     I/O spaces.
+     space.  However, it may also be mapped as a virtual I/O space in the CPU's
+     memory map, particularly on those CPUs that don't support alternate I/O
+     spaces.
 
      Accesses to this space may be fully synchronous (as on i386), but
      intermediary bridges (such as the PCI host bridge) may not fully honour
