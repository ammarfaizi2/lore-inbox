Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVKSEQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKSEQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVKSEQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:16:16 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:52981
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750890AbVKSEQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:16:15 -0500
Date: Fri, 18 Nov 2005 21:16:15 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 2/12: eCryptfs] Documentation
Message-ID: <20051119041615.GB15747@sshock.rn.byu.edu>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119041130.GA15559@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides documentation for using eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 ecryptfs.txt |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+)
--- linux-2.6.15-rc1-mm1/Documentation/ecryptfs.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc1-mm1-ecryptfs/Documentation/ecryptfs.txt	2005-11-18 11:46:12.000000000 -0600
@@ -0,0 +1,81 @@
+eCryptfs: A stacked cryptographic filesystem for Linux
+Maintainer: Phillip Hellewell
+Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
+Developers: Michael C. Thompson
+            Kent Yoder
+Current Release Version: 0.1
+
+This software is currently undergoing development. Make sure to
+maintain a backup copy of any data you write into eCryptfs.
+
+eCryptfs requires the userspace tools downloadable from the
+SourceForge site:
+
+http://sourceforge.net/projects/ecryptfs/
+
+Requirements include:
+ - Kernel version 2.6.15-rc1-mm1 or higher
+  - eCryptfs will work with 2.6.14, but you will need the
+    export_user_type.patch applied
+ - David Howells' userspace keyring headers and libraries, obtainable
+   from http://people.redhat.com/~dhowells/keyutils/
+  - (You will need to apply the keyutil_h_fix.diff patch to version 0.3)
+ - GnuPG Made Easy (GPGME)
+ - Building the kernel with:
+  - Cryptographic API
+  - Blowfish cipher
+  - Key retention support
+  - Filesystems->Miscellaneous filesystems->eCryptfs
+
+
+BUILD AND INSTALL INSTRUCTIONS
+
+If you are installing from the patch set:
+1) Apply export_user_type.patch to the kernel if you are running
+   kernel version 2.6.14
+2) Apply all patches in the patches/ directory to the kernel
+
+Once eCryptfs is already in the kernel:
+3) Select build options (see Requirements) and build kernel
+4) Apply keyutil_h_fix.diff to the keyutils if you are running version
+   0.3
+5) Run make and make install from the request-key/ directory.
+
+
+MOUNT-WIDE PASSPHRASE
+
+Create a new directory into which eCryptfs will write its encrypted
+files (i.e., /root/crypt).  Then, create the mount point directory
+(i.e., /mnt/crypt).  Now it's time to mount eCryptfs:
+
+mount -t ecryptfs /root/crypt /mnt/crypt
+
+You should be prompted for a passphrase and a salt (the salt may be
+blank).
+
+Try writing a new file:
+
+echo "Hello, World" > /mnt/crypt/hello.txt
+
+The operation will complete.  Notice that there is a new file in
+/root/crypt that is 3 pages (12288 bytes) in size.  This is the
+encrypted underlying file for what you just wrote.  To test reading,
+from start to finish, you need to clear the user session keyring:
+
+keyctl clear @u
+
+Then umount /mnt/crypt and mount again per the instructions given
+above.
+
+cat /mnt/crypt/hello.txt
+
+
+NOTES
+
+eCryptfs should only be mounted on (1) empty directories or (2)
+directories containing files only created by eCryptfs. If you mount a
+directory that has pre-existing files not created by eCryptfs, then
+behavior is undefined.
+
+Mike Halcrow
+mhalcrow@us.ibm.com
