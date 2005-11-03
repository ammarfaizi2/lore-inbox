Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbVKCDmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbVKCDmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbVKCDmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:42:45 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:3566
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751619AbVKCDmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:42:44 -0500
Date: Wed, 2 Nov 2005 20:43:08 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 2/12: eCryptfs] Documentation
Message-ID: <20051103034308.GB3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides documentation for using eCryptfs.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 ecryptfs.txt |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+)
--- linux-2.6.14-rc5-mm1/Documentation/ecryptfs.txt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/Documentation/ecryptfs.txt	2005-11-01 16:47:17.000000000 -0600
@@ -0,0 +1,55 @@
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
+Run make and make install from the request-key/ directory.
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
