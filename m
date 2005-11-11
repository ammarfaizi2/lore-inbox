Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVKKQyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVKKQyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVKKQyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:54:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:15071 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750915AbVKKQyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:54:35 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52392.235786.407720@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:54:00 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 12/12] relayfs: Documentation cleanup, remove obsolete info
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

librelay and relay-app.h have been retired - update Documentation to
reflect that.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 relayfs.txt |   55 +++++++++++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -44,30 +44,41 @@ relayfs can operate in a mode where it w
 collected by userspace, and not wait for it to consume it.
 
 relayfs itself does not provide for communication of such data between
-userspace and kernel, allowing the kernel side to remain simple and not
-impose a single interface on userspace. It does provide a separate
-helper though, described below.
+userspace and kernel, allowing the kernel side to remain simple and
+not impose a single interface on userspace. It does provide a set of
+examples and a separate helper though, described below.
+
+klog and relay-apps example code
+================================
+
+relayfs itself is ready to use, but to make things easier, a couple
+simple utility functions and a set of examples are provided.
+
+The relay-apps example tarball, available on the relayfs sourceforge
+site, contains a set of self-contained examples, each consisting of a
+pair of .c files containing boilerplate code for each of the user and
+kernel sides of a relayfs application; combined these two sets of
+boilerplate code provide glue to easily stream data to disk, without
+having to bother with mundane housekeeping chores.
+
+The 'klog debugging functions' patch (klog.patch in the relay-apps
+tarball) provides a couple of high-level logging functions to the
+kernel which allow writing formatted text or raw data to a channel,
+regardless of whether a channel to write into exists or not, or
+whether relayfs is compiled into the kernel or is configured as a
+module.  These functions allow you to put unconditional 'trace'
+statements anywhere in the kernel or kernel modules; only when there
+is a 'klog handler' registered will data actually be logged (see the
+klog and kleak examples for details).
+
+It is of course possible to use relayfs from scratch i.e. without
+using any of the relay-apps example code or klog, but you'll have to
+implement communication between userspace and kernel, allowing both to
+convey the state of buffers (full, empty, amount of padding).
 
-klog, relay-app & librelay
-==========================
-
-relayfs itself is ready to use, but to make things easier, two
-additional systems are provided.  klog is a simple wrapper to make
-writing formatted text or raw data to a channel simpler, regardless of
-whether a channel to write into exists or not, or whether relayfs is
-compiled into the kernel or is configured as a module.  relay-app is
-the kernel counterpart of userspace librelay.c, combined these two
-files provide glue to easily stream data to disk, without having to
-bother with housekeeping.  klog and relay-app can be used together,
-with klog providing high-level logging functions to the kernel and
-relay-app taking care of kernel-user control and disk-logging chores.
-
-It is possible to use relayfs without relay-app & librelay, but you'll
-have to implement communication between userspace and kernel, allowing
-both to convey the state of buffers (full, empty, amount of padding).
+klog and the relay-apps examples can be found in the relay-apps
+tarball on http://relayfs.sourceforge.net
 
-klog, relay-app and librelay can be found in the relay-apps tarball on
-http://relayfs.sourceforge.net
 
 The relayfs user space API
 ==========================


