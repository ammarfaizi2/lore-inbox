Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUL3BgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUL3BgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUL3BgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:36:12 -0500
Received: from mail.dif.dk ([193.138.115.101]:11718 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261496AbUL3BgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:36:05 -0500
Date: Thu, 30 Dec 2004 02:47:10 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add printing of udev version to scripts/ver_linux
Message-ID: <Pine.LNX.4.61.0412300224080.3554@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since udev is starting to be used a lot of places and I've seen people get 
asked about their udev version a few times on lkml I figured it was 
perhaps time that scripts/ver_linux reported this info so it would get 
into more bugreports by default.

This patch adds printing of udev version to scripts/ver_linux

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-bk2-orig/scripts/ver_linux linux-2.6.10-bk2/scripts/ver_linux
--- linux-2.6.10-bk2-orig/scripts/ver_linux	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.10-bk2/scripts/ver_linux	2004-12-30 02:21:34.000000000 +0100
@@ -87,6 +87,8 @@
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 
+udevinfo -V | awk '{print "udev                  ", $3}'
+
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
     echo "Modules Loaded         "$X



I guess it would also make sense to also add a tiny bit of text about udev 
to Documentation/Changes if the above goes in - if so there's a possible 
patch to do that below.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-bk2-orig/Documentation/Changes linux-2.6.10-bk2/Documentation/Changes
--- linux-2.6.10-bk2-orig/Documentation/Changes	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.10-bk2/Documentation/Changes	2004-12-30 02:42:10.000000000 +0100
@@ -223,6 +223,11 @@
 version v0.99.0 or higher. Running old versions may cause problems
 with programs using shared memory.
 
+Udev
+----
+Udev is a userspace application for populating /dev dynamically with
+only entries for devices actually present. Udev replaces devfs.
+
 Networking
 ==========
 
@@ -368,6 +373,10 @@
 ----------
 o  <http://powertweak.sourceforge.net/>
 
+Udev
+----
+o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>
+
 Networking
 **********
 
@@ -399,4 +408,3 @@
 ---------
 o  <http://nfs.sourceforge.net/>
 
-




