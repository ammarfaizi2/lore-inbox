Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCICMM>; Thu, 8 Mar 2001 21:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129948AbRCICMC>; Thu, 8 Mar 2001 21:12:02 -0500
Received: from imcs.rutgers.edu ([165.230.57.130]:34498 "EHLO imcs.Rutgers.EDU")
	by vger.kernel.org with ESMTP id <S130065AbRCICLr> convert rfc822-to-8bit;
	Thu, 8 Mar 2001 21:11:47 -0500
Date: Thu, 8 Mar 2001 21:00:25 -0500 (EST)
From: Rob Cermak <cermak@IMCS.rutgers.edu>
To: linux-kernel@vger.kernel.org
cc: chris.ricker@genetics.utah.edu
Subject: [PATCH] Documentation/Changes & hunting
Message-ID: <Pine.SOL.4.21.0103082052430.902-100000@imcs.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included some info on things needed to compile 2.4.2-ac16.   Feel free to
further edit and comment.  Patched against -ac16.   [linux = ac16; my
edited version is ac14].

I have to keep up with the kernel as a small 3c509 ethernet problem has
appeared, just gotta hunt it down.  2.2.17-14 works from Redhat but moving
into the 2.4.2 both cards come up and with the right hardware irq/ioport
allocation & ifconfig can set an address, but the card fails to bring up a
signal on the hub -- its very odd.  So, I'm looking over the code between
2.2.17-14 from RH and the 2.4.2 series.    Here is the patch...cc: to the
maintainer as well.

--- linux/Documentation/Changes	Thu Mar  8 20:58:05 2001
+++ linux-2.4.2-ac14/Documentation/Changes	Thu Mar  8 21:03:14 2001
@@ -58,6 +58,15 @@
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
+o  flex                   2.5.4                   # flex --version
+o  bison                  1.28                    # bison --version
+o  db                     3.1.17 (1)              # strings /lib/libdb.so | grep Sleep | grep DB
+o  yacc                   (2)
+
+Notes:
+(1) If using RedHat db3-devel package, it loads what you need but requires
+a small tweak to /usr/include; see notes for Db.
+(2) see notes for Bison. 
 			  
 Kernel compilation
 ==================
@@ -137,6 +146,32 @@
 types, have a fdformat which works with 2.4 kernels, and similar goodies.
 You'll probably want to upgrade.
 
+Bison
+-----
+
+Bison is a parser generator in the style of yacc(1).  It should be
+upwardly compatible with input files designed for yacc.   
+
+Yacc
+----
+
+A yacc requirement was added to the kernel as of 2.4.2-ac14; see 
+attached script below.  See Bison notes above and below.
+
+Flex
+----
+
+Fast lexical analyzer generator.  A tool for generating programs 
+that perform pattern-matching on text.
+
+Db
+--
+
+The Berkeley Database (Berkeley DB) is a programmatic toolkit that 
+provides embedded database support for both traditional and 
+client/server applications.  Berkeley DB is used by many applications, 
+including Python and Perl, so this should be installed on all systems.
+
 Ksymoops
 --------
 
@@ -296,6 +331,28 @@
 Util-linux
 ----------
 o  <ftp://ftp.kernel.org/pub/linux/utils/util-linux/util-linux-2.10o.tar.gz>
+
+Bison
+-----
+o  <ftp://ftp.gnu.org/gnu/bison/bison-1.28.tar.gz>
+
+Yacc
+----
+#!/bin/sh
+# Justin T. Gibbs <gibbs@scsiguy.com>
+# Jörn Nettingsmeier <nettings@folkwang-hochschule.de>
+# Peter Samuelson <peter@cadcamlab.org>
+exec bison -y "$@"
+
+Flex
+----
+o  <ftp://ftp.gnu.org/non-gnu/flex/flex-2.5.4a.tar.gz>
+
+Db
+--
+o  <http://www.sleepycat.com/update/3.1.17/db-3.1.17.tar.gz>
+o  Loading the RedHat db3-devel package requires the following:
+   cd /usr/include; mkdir db; cd db; ln -s ln -s ../db3/db_185.h db_185.h
 
 Ksymoops
 --------


