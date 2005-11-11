Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKKQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKKQux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKKQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:50:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:31379 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750898AbVKKQuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:50:51 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52168.9863.221771@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:50:16 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 6/12] relayfs: add Documention for non-relay files
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update for non-relay files.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 relayfs.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -125,6 +125,8 @@ Here's a summary of the API relayfs prov
     relay_reset(chan)
     relayfs_create_dir(name, parent)
     relayfs_remove_dir(dentry)
+    relayfs_create_file(name, parent, mode, fops, data)
+    relayfs_remove_file(dentry)
 
   channel management typically called on instigation of userspace:
 
@@ -320,6 +322,27 @@ forces a sub-buffer switch on all the ch
 to finalize and process the last sub-buffers before the channel is
 closed.
 
+Creating non-relay files
+------------------------
+
+relay_open() automatically creates files in the relayfs filesystem to
+represent the per-cpu kernel buffers; it's often useful for
+applications to be able to create their own files alongside the relay
+files in the relayfs filesystem as well e.g. 'control' files much like
+those created in /proc or debugfs for similar purposes, used to
+communicate control information between the kernel and user sides of a
+relayfs application.  For this purpose the relayfs_create_file() and
+relayfs_remove_file() API functions exist.  For relayfs_create_file(),
+the caller passes in a set of user-defined file operations to be used
+for the file and an optional void * to a user-specified data item,
+which will be accessible via inode->u.generic_ip (see the relay-apps
+tarball for examples).  The file_operations are a required parameter
+to relayfs_create_file() and thus the semantics of these files are
+completely defined by the caller.
+
+See the relay-apps tarball at http://relayfs.sourceforge.net for
+examples of how these non-relay files are meant to be used.
+
 Misc
 ----
 


