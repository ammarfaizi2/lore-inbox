Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWEMDl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEMDl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWEMDl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:41:27 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:61939 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751159AbWEMDl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:41:26 -0400
Date: Fri, 12 May 2006 21:41:28 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 2/13: eCryptfs] Documentation
Message-ID: <20060513034128.GB18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

This patch provides documentation for using eCryptfs.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 ecryptfs.txt |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/Documentation/ecryptfs.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/Documentation/ecryptfs.txt	2006-05-12 20:00:30.000000000 -0600
@@ -0,0 +1,77 @@
+eCryptfs: A stacked cryptographic filesystem for Linux
+
+eCryptfs is free software. Please see the file COPYING for details.
+For documentation, please see the files in the doc/ subdirectory.  For
+building and installation instructions please see the INSTALL file.
+
+Maintainer: Phillip Hellewell
+Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
+Developers: Michael C. Thompson
+            Kent Yoder
+Web Site: http://ecryptfs.sf.net
+
+This software is currently undergoing development. Make sure to
+maintain a backup copy of any data you write into eCryptfs.
+
+eCryptfs requires the userspace tools downloadable from the
+SourceForge site:
+
+http://sourceforge.net/projects/ecryptfs/
+
+Userspace requirements include:
+ - David Howells' userspace keyring headers and libraries (version
+   1.0 or higher), obtainable from
+   http://people.redhat.com/~dhowells/keyutils/
+ - Libgcrypt
+
+
+NOTES
+
+In the beta/experimental releases of eCryptfs, when you upgrade
+eCryptfs, you should copy the files to an unencrypted location and
+then copy the files back into the new eCryptfs mount to migrate the
+files.
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
+/root/crypt that is at least 12288 bytes in size (depending on your
+host page size).  This is the encrypted underlying file for what you
+just wrote.  To test reading, from start to finish, you need to clear
+the user session keyring:
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
+eCryptfs version 0.1 should only be mounted on (1) empty directories
+or (2) directories containing files only created by eCryptfs. If you
+mount a directory that has pre-existing files not created by eCryptfs,
+then behavior is undefined. Do not run eCryptfs in higher verbosity
+levels unless you are doing so for the sole purpose of debugging or
+development, since secret values will be written out to the system log
+in that case.
+
+
+Mike Halcrow
+mhalcrow@us.ibm.com
