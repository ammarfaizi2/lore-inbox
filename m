Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbTAARDy>; Wed, 1 Jan 2003 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAARDy>; Wed, 1 Jan 2003 12:03:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:40895 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265085AbTAARDw>; Wed, 1 Jan 2003 12:03:52 -0500
Date: Wed, 1 Jan 2003 18:12:15 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the QOS submenu if QOS is selected
Message-ID: <20030101171215.GJ15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the QOS submenu if the QOS entry is selected.

This one is a bit larger on account of its moving CONFIG_NET_SCHED where
it belongs.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2002-12-08 20:06:41.000000000 +0100
+++ b/net/Kconfig	2003-01-01 18:07:56.000000000 +0100
@@ -586,49 +586,9 @@
 	  However, do not say Y here if you did not experience any serious
 	  problems.
 
-
-menu "QoS and/or fair queueing"
-
-config NET_SCHED
-	bool "QoS and/or fair queueing"
-	---help---
-	  When the kernel has several packets to send out over a network
-	  device, it has to decide which ones to send first, which ones to
-	  delay, and which ones to drop. This is the job of the packet
-	  scheduler, and several different algorithms for how to do this
-	  "fairly" have been proposed.
-
-	  If you say N here, you will get the standard packet scheduler, which
-	  is a FIFO (first come, first served). If you say Y here, you will be
-	  able to choose from among several alternative algorithms which can
-	  then be attached to different network devices. This is useful for
-	  example if some of your network devices are real time devices that
-	  need a certain minimum data flow rate, or if you need to limit the
-	  maximum data flow rate for traffic which matches specified criteria.
-	  This code is considered to be experimental.
-
-	  To administer these schedulers, you'll need the user-level utilities
-	  from the package iproute2+tc at <ftp://ftp.inr.ac.ru/ip-routing/>.
-	  That package also contains some documentation; for more, check out
-	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
-
-	  This Quality of Service (QoS) support will enable you to use
-	  Differentiated Services (diffserv) and Resource Reservation Protocol
-	  (RSVP) on your Linux router if you also say Y to "QoS support",
-	  "Packet classifier API" and to some classifiers below. Documentation
-	  and software is at <http://icawww1.epfl.ch/linux-diffserv/>.
-
-	  If you say Y here and to "/proc file system" below, you will be able
-	  to read status information about packet schedulers from the file
-	  /proc/net/psched.
-
-	  The available schedulers are listed in the following questions; you
-	  can say Y to as many as you like. If unsure, say N now.
-
 source "net/sched/Kconfig"
 
 #bool 'Network code profiler' CONFIG_NET_PROFILE
-endmenu
 
 menu "Network testing"
 
diff -urN a/net/sched/Kconfig b/net/sched/Kconfig
--- a/net/sched/Kconfig	2002-10-31 02:34:02.000000000 +0100
+++ b/net/sched/Kconfig	2003-01-01 18:08:40.000000000 +0100
@@ -1,6 +1,46 @@
 #
 # Traffic control configuration.
 # 
+
+config NET_SCHED
+	bool "QoS and/or fair queueing"
+	---help---
+	  When the kernel has several packets to send out over a network
+	  device, it has to decide which ones to send first, which ones to
+	  delay, and which ones to drop. This is the job of the packet
+	  scheduler, and several different algorithms for how to do this
+	  "fairly" have been proposed.
+
+	  If you say N here, you will get the standard packet scheduler, which
+	  is a FIFO (first come, first served). If you say Y here, you will be
+	  able to choose from among several alternative algorithms which can
+	  then be attached to different network devices. This is useful for
+	  example if some of your network devices are real time devices that
+	  need a certain minimum data flow rate, or if you need to limit the
+	  maximum data flow rate for traffic which matches specified criteria.
+	  This code is considered to be experimental.
+
+	  To administer these schedulers, you'll need the user-level utilities
+	  from the package iproute2+tc at <ftp://ftp.inr.ac.ru/ip-routing/>.
+	  That package also contains some documentation; for more, check out
+	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
+
+	  This Quality of Service (QoS) support will enable you to use
+	  Differentiated Services (diffserv) and Resource Reservation Protocol
+	  (RSVP) on your Linux router if you also say Y to "QoS support",
+	  "Packet classifier API" and to some classifiers below. Documentation
+	  and software is at <http://icawww1.epfl.ch/linux-diffserv/>.
+
+	  If you say Y here and to "/proc file system" below, you will be able
+	  to read status information about packet schedulers from the file
+	  /proc/net/psched.
+
+	  The available schedulers are listed in the following questions; you
+	  can say Y to as many as you like. If unsure, say N now.
+
+menu "QoS and/or fair queueing"
+	depends on NET_SCHED
+
 config NET_SCH_CBQ
 	tristate "CBQ packet scheduler"
 	depends on NET_SCHED
@@ -326,3 +366,4 @@
 	  Say Y to support traffic policing (bandwidth limits).  Needed for
 	  ingress and egress rate limiting.
 
+endmenu
