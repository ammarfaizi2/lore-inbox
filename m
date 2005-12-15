Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVLOOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVLOOjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLOOjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:06 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:51354 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750722AbVLOOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:59 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143852.495458000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:10 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 13/21] PID Virtualization: Documentation
Content-Disposition: inline; filename=G0-documentation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First (incomplete) attempt of documentation
Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 Documentation/pidvirtualization.txt |   64 ++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+)

Index: linux-2.6.15-rc1/Documentation/containers.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc1/Documentation/containers.txt	2005-12-08 01:30:42.000000000 -0500
@@ -0,0 +1,64 @@
+This document describes the basics of the container
+
+Hubertus Franke	<frankeh@watson.ibm.com>
+Serge E Hallyn	<serue@us.ibm.com>
+Cedric Legoater <clg@fr.ibm.com>
+
+Applications and associated processes can be containerized into
+"isolated" soft partitions. The goal is to make containers
+transparently migratable. To do so certain resources identifiers
+need to be virtualized.
+These includes
+	- pids, gids,
+	- SysV ids
+	- procfs
+Only resource belonging to a container can be accessed within
+the container.
+
+A "container" is created through a helper program <contexe>,
+that is supplied separately.
+A process moves itself to a container by writing
+the name of the container to create to /proc/container.
+Doing so makes the calling process the pseudo init process
+of the container.
+
+
+For example "contexe -j2 /bin/bash" spawns a bash within
+a new container <cont_2> and make the contexe process
+the containers virtual initproc.
+
+
+PID-VIRTUALIZATION:
+-------------------
+
+Let Process <A> be the currently running process ( e.g. bash with pid 913 )
+Each container has an associated pidspace id associated. Each pidspace
+id is managed like the standard pid range in linux.
+
+We obtain the following tree, where <pidspace | vpid > denotes the
+internal pid which is obtained by bitmasking.
+
+A some older bash < 0 | 913 >
+	|
+	\/
+B == contexe == < 0 | 1087 >      ( also container->init_proc := A
+				   	 container->init_pid  := 1087
+	|
+	\/
+C == /bin/bash == < 1 | 2 >
+
+
+let's define the results here we are expecting.
+
+C in context of B:      vpid = 2
+B in context of C:	vpid = 1
+
+B in context of A:	vpid = pid = 1087
+C in context of A:	vpid = pid = < 1 | 2 >
+
+A in context of B:	vpid = pid = 913
+A in context of C:	vpid = -1
+
+< More to Follow >
+
+

--
