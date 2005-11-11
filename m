Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVKKQwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVKKQwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVKKQwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:52:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:6054 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750903AbVKKQwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:52:20 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52256.814023.679137@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:51:44 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 8/12] relayfs: add Documentation on relay files in other filesystems
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update for creating relay files in other filesystems.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 relayfs.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -143,6 +143,8 @@ Here's a summary of the API relayfs prov
     subbuf_start(buf, subbuf, prev_subbuf, prev_padding)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
+    create_buf_file(filename, parent, mode, buf)
+    remove_buf_file(dentry)
 
   helper functions:
 
@@ -343,6 +345,31 @@ completely defined by the caller.
 See the relay-apps tarball at http://relayfs.sourceforge.net for
 examples of how these non-relay files are meant to be used.
 
+Creating relay files in other filesystems
+-----------------------------------------
+
+By default of course, relay_open() creates relay files in the relayfs
+filesystem.  Because relay_file_operations is exported, however, it's
+also possible to create and use relay files in other pseudo-filesytems
+such as debugfs.
+
+For this purpose, two callback functions are provided,
+create_buf_file() and remove_buf_file().  create_buf_file() is called
+once for each per-cpu buffer from relay_open() to allow the client to
+create a file to be used to represent the corresponding buffer; if
+this callback is not defined, the default implementation will create
+and return a file in the relayfs filesystem to represent the buffer.
+The callback should return the dentry of the file created to represent
+the relay buffer.  Note that the parent directory passed to
+relay_open() (and passed along to the callback), if specified, must
+exist in the same filesystem the new relay file is created in.  If
+create_buf_file() is defined, remove_buf_file() must also be defined;
+it's responsible for deleting the file(s) created in create_buf_file()
+and is called during relay_close().
+
+See the 'exported-relayfile' examples in the relay-apps tarball for
+examples of creating and using relay files in debugfs.
+
 Misc
 ----
 


