Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVCJBKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVCJBKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCJBHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:07:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:48031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262615AbVCJAm0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:26 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe status.sh: handle sysfs not in /etc/mtab
In-Reply-To: <11104139631637@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:19:23 -0800
Message-Id: <11104139632443@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2039, 2005/03/09 10:21:52-08:00, ecashin@coraid.com

[PATCH] aoe status.sh: handle sysfs not in /etc/mtab

Suse 9.1 Pro doesn't put /sys in /etc/mtab.  This patch makes the
example aoe status.sh script work when sysfs is mounted but `mount`
doesn't mention sysfs.


aoe status.sh: handle sysfs not in /etc/mtab

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 Documentation/aoe/status.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/aoe/status.sh b/Documentation/aoe/status.sh
--- a/Documentation/aoe/status.sh	2005-03-09 16:15:46 -08:00
+++ b/Documentation/aoe/status.sh	2005-03-09 16:15:46 -08:00
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
 

