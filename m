Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVA0BO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVA0BO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVA0AFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:05:15 -0500
Received: from ns1.coraid.com ([65.14.39.133]:29933 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262433AbVAZVFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:05:46 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [PATCH block-2.6] aoe status.sh: handle sysfs not in /etc/mtab
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 26 Jan 2005 16:02:02 -0500
Message-ID: <878y6fzyyd.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Suse 9.1 Pro doesn't put /sys in /etc/mtab.  This patch makes the
example aoe status.sh script work when sysfs is mounted but `mount`
doesn't mention sysfs.


aoe status.sh: handle sysfs not in /etc/mtab
Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff-aoe-stat

--- a/Documentation/aoe/status.sh
+++ b/Documentation/aoe/status.sh
@@ -4,10 +4,13 @@
 set -e
 format="%8s\t%8s\t%8s\n"
 me=`basename $0`
+sysd=${sysfs_dir:-/sys}
 
 # printf "$format" device mac netif state
 
-test -z "`mount | grep sysfs`" && {
+# Suse 9.1 Pro doesn't put /sys in /etc/mtab
+#test -z "`mount | grep sysfs`" && {
+test ! -d "$sysd/block" && {
 	echo "$me Error: sysfs is not mounted" 1>&2
 	exit 1
 }
@@ -16,7 +19,7 @@
 	exit 1
 }
 
-for d in `ls -d /sys/block/etherd* 2>/dev/null | grep -v p` end; do
+for d in `ls -d $sysd/block/etherd* 2>/dev/null | grep -v p` end; do
 	# maybe ls comes up empty, so we use "end"
 	test $d = end && continue
 




--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

