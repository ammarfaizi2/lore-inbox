Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264216AbTDKKXG (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTDKKXE (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:23:04 -0400
Received: from trillium-hollow.org ([209.180.166.89]:16289 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP id S264216AbTDKKXC (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 06:23:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Small fix for VMWare 3.2 (3.x?) on Redhat 9 (any 2.4.20+ kernel?)
Date: Fri, 11 Apr 2003 03:34:45 -0700
From: erich@uruk.org
Message-Id: <E193vrp-0006P4-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI...

I'm running Redhat 9, and to get my copy of VMWare 3.2 working with it,
I had to make a one-line fix to a source file inside the "vmnet.tar" file
for building the vmnet module.

With the fix, VMWare's scripts throw off a lot of what seem to be
irrelevant error messages while configuring, but it runs flawlessly
once the "vmware-config.pl" script completes.

In the default installation, the source files for the vmnet module are in:

   /usr/lib/vmware/modules/source/vmnet.tar

Here's the patch:
------------------------------------------------------------------------
diff -ruN vmnet-only.orig/driver.c vmnet-only/driver.c
--- vmnet-only.orig/driver.c    2002-09-09 20:22:41.000000000 -0700
+++ vmnet-only/driver.c 2003-04-10 18:51:22.000000000 -0700
@@ -1485,7 +1485,7 @@
     
    len += sprintf(buf+len, "pids ");
  
-   for_each_task(p) {
+   for_each_process(p) {
       if (VNetProcessOwnsPort(p, port)) {
          len += sprintf(buf+len, "%d", p->pid);
          if (seen) {
------------------------------------------------------------------------

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"


