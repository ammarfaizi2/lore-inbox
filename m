Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbRF3Ekh>; Sat, 30 Jun 2001 00:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbRF3Ek1>; Sat, 30 Jun 2001 00:40:27 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:34178 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264724AbRF3EkP>; Sat, 30 Jun 2001 00:40:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 29 Jun 2001 21:40:12 -0700
Message-Id: <200106300440.VAA14185@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Argh!  I just accidentally sent and older version of my
patch.  Here is the current version.  Sorry about that.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
--------------------------CUT HERE----------------------------------
--- linux-2.4.6-pre6/scripts/Configure	Sat Dec 30 18:16:13 2000
+++ linux/scripts/Configure	Fri Jun 29 21:39:24 2001
@@ -48,6 +48,10 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 29 June 2001, Adam J. Richter, <adam@yggdrasil.com>
+# - Default all non-numeric variables arch/*/config.in to "n"
+
 
 #
 # Make sure we're really running bash.
@@ -531,6 +535,18 @@
 echo " * Automatically generated C config: don't edit" >> $CONFIG_H
 echo " */" >> $CONFIG_H
 echo "#define AUTOCONF_INCLUDED" >> $CONFIG_H
+
+# Ensure all unselected architecture variables are set to "n" rather than being
+# undefined, so that dep_bool and dep_tristate properly detect their absense.
+set +f
+for var in $(cat arch/*/config.in |
+	     egrep -w -v '^[ 	]*int' |
+             tr '   $"' '\n\n\n' |
+	     egrep '^CONFIG_[A-Z0-9_]*$' |
+	     sort -u) ; do
+	define_bool "$var" "n"
+done
+set -f
 
 DEFAULT=""
 if [ "$1" = "-d" ] ; then
