Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVASVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVASVPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVASVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:15:00 -0500
Received: from ns1.coraid.com ([65.14.39.133]:43346 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261899AbVASVNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:13:45 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [PATCH] aoe: add documentation for udev users
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 19 Jan 2005 16:10:35 -0500
Message-ID: <87brblm8fo.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi.  This patch was generated against block-2.6 but should apply
easily in other trees, since it touches only documentation.


add documentation for udev users

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=patch-aoe-udev

--- block-2.6-export-b/Documentation/aoe/aoe.txt	2005-01-19 14:29:15.000000000 -0500
+++ linux/Documentation/aoe/aoe.txt	2005-01-19 15:57:37.000000000 -0500
@@ -6,9 +6,16 @@ The EtherDrive (R) HOWTO for users of 2.
 
 CREATING DEVICE NODES
 
-  Users of udev should find device nodes created automatically.  Two
-  scripts are provided in Documentation/aoe as examples of static
-  device node creation for using the aoe driver.
+  Users of udev should find the block device nodes created
+  automatically, but to create all the necessary device nodes, use the
+  udev configuration rules provided in udev.txt (in this directory).
+
+  There is a udev-install.sh script that shows how to install these
+  rules on your system.
+
+  If you are not using udev, two scripts are provided in
+  Documentation/aoe as examples of static device node creation for
+  using the aoe driver.
 
     rm -rf /dev/etherd
     sh Documentation/aoe/mkdevs.sh /dev/etherd
--- block-2.6-export-b/Documentation/aoe/udev-install.sh	1969-12-31 19:00:00.000000000 -0500
+++ linux/Documentation/aoe/udev-install.sh	2005-01-19 15:57:37.000000000 -0500
@@ -0,0 +1,22 @@
+# install the aoe-specific udev rules from udev.txt into 
+# the system's udev configuration
+# 
+
+me="`basename $0`"
+
+# find udev.conf, often /etc/udev/udev.conf
+# (or environment can specify where to find udev.conf)
+#
+if test -z "$conf"; then
+	conf="`find /etc -type f -name udev.conf 2> /dev/null`"
+fi
+if test -z "$conf" || test ! -r $conf; then
+	echo "$me Error: could not find readable udev.conf in /etc" 1>&2
+	exit 1
+fi
+
+# find the directory where udev rules are stored, often
+# /etc/udev/rules.d
+#
+rules_d="`sed -n '/^udev_rules=/{ s!udev_rules=!!; s!\"!!g; p; }' $conf`"
+test "$rules_d" && sh -xc "cp `dirname $0`/udev.txt $rules_d/60-aoe.rules"
--- block-2.6-export-b/Documentation/aoe/udev.txt	1969-12-31 19:00:00.000000000 -0500
+++ linux/Documentation/aoe/udev.txt	2005-01-19 15:57:37.000000000 -0500
@@ -0,0 +1,23 @@
+# These rules tell udev what device nodes to create for aoe support.
+# They may be installed along the following lines (adjusted to what
+# you see on your system).
+# 
+#   ecashin@makki ~$ su
+#   Password:
+#   bash# find /etc -type f -name udev.conf
+#   /etc/udev/udev.conf
+#   bash# grep udev_rules= /etc/udev/udev.conf
+#   udev_rules="/etc/udev/rules.d/"
+#   bash# ls /etc/udev/rules.d/
+#   10-wacom.rules  50-udev.rules
+#   bash# cp /path/to/linux-2.6.xx/Documentation/aoe/udev.txt \
+#           /etc/udev/rules.d/60-aoe.rules
+#  
+
+# aoe char devices
+SUBSYSTEM="aoe", KERNEL="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+SUBSYSTEM="aoe", KERNEL="err",		NAME="etherd/%k", GROUP="disk", MODE="0440"
+SUBSYSTEM="aoe", KERNEL="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="0220"
+
+# aoe block devices     
+KERNEL="etherd*",       NAME="%k", GROUP="disk"

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

