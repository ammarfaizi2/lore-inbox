Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272464AbTG1BRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272428AbTG1ADE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272743AbTG0W7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:59:08 -0400
Date: Sun, 27 Jul 2003 21:28:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272028.h6RKSsHh029853@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: update Changes for NFS changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/Documentation/Changes linux-2.6.0-test2-ac1/Documentation/Changes
--- linux-2.6.0-test2/Documentation/Changes	2003-07-10 21:14:21.000000000 +0100
+++ linux-2.6.0-test2-ac1/Documentation/Changes	2003-07-16 18:40:03.000000000 +0100
@@ -61,9 +61,9 @@
 o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
+o  nfs-utils              1.0.4                   # showmount --version
 o  procps                 2.0.9                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
-o  nfs-utils              1.0.3                   # showmount --version
 
 Kernel compilation
 ==================
@@ -280,6 +280,34 @@
 Due to changes in the length of the phone number field, isdn4k-utils
 needs to be recompiled or (preferably) upgraded.
 
+NFS-utils
+---------
+
+In 2.4 and earlier kernels, the nfs server needed to know about any
+client that expected to be able to access files via NFS.  This
+information would be given to the kernel by "mountd" when the client
+mounted the filesystem, or by "exportfs" at system startup.  exportfs
+would take information about active clients from /var/lib/nfs/rmtab.
+
+This approach is quite fragile as it depends on rmtab being correct
+which is not always easy, particularly when trying to implement
+fail-over.  Even when the system is working well, rmtab suffers from
+getting lots of old entries that never get removed.
+
+With 2.6 we have the option of having the kernel tell mountd when it
+gets a request from an unknown host, and mountd can give appropriate
+export information to the kernel.  This removes the dependency on
+rmtab and means that the kernel only needs to know about currently
+active clients.
+
+To enable this new functionality, you need to:
+
+  mount -t nfsd nfsd /proc/fs/nfs
+
+before running exportfs or mountd.  It is recommended that all NFS
+services be protected from the internet-at-large by a firewall where
+that is possible.
+
 Getting updated software
 ========================
 
@@ -368,6 +396,10 @@
 ------------
 o  <ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/isdn4k-utils.v3.1pre1.tar.gz>
 
+NFS-utils
+---------
+o  <http://sourceforge.net/project/showfiles.php?group_id=14>
+
 Netfilter
 ---------
 o  <http://netfilter.filewatcher.org/iptables-1.2.tar.bz2>
