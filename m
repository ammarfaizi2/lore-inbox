Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWHLSRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWHLSRb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWHLSRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 14:17:30 -0400
Received: from xenotime.net ([66.160.160.81]:7064 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030258AbWHLSR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 14:17:29 -0400
Date: Sat, 12 Aug 2006 11:20:14 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       Alex Tomas <alex@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060812112014.d1b4691a.rdunlap@xenotime.net>
In-Reply-To: <44DE1328.5080101@us.ibm.com>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<m37j1hlyzv.fsf@bzzz.home.net>
	<20060811135737.1abfa0f6.rdunlap@xenotime.net>
	<20060811160002.b2afbec3.akpm@osdl.org>
	<20060811230239.c89394b0.rdunlap@xenotime.net>
	<44DE1328.5080101@us.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 10:43:04 -0700 Darrick J. Wong wrote:

> Randy.Dunlap wrote:
> 
> > Uh, yes.  Well, I don't really care for the "ext3dev" name, but
> > I tried to ignore that "feature" and fix it up anyway.
> > Feel free to ignore any parts that you don't want.
> 
> Three nits to pick:
> 
> > +	  renamed ext4 fs later, once ext3dev is mature and
> > stabled.
> 
> I think you want "stabilized", not "stabled".
> 
> (Until someone writes horsefs, that is. ;))
> 
> > +	  Other than extent maps and 48-bit block number,
> > ext3dev also is
> 
> "...48-bit block numbers..."
> 
> > +	  By default the debugging output will be turned off.
> 
> "By default, the..."

Thanks, all fixed, although I think that the comma on the last
one is optional.  New patch is below, although what I would
really prefer to see is this:

- Drop the "ext3dev" name.  Use "ext4dev" temporarily, then
  switch to "ext4".

---
From: Randy Dunlap <rdunlap@xenotime.net>

Clean up help text and module names in ext4 & jbd2 Kconfig entries.
Add "depends on EXPERIMENTAL".

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/Kconfig |   59 ++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 30 insertions(+), 29 deletions(-)

--- linux-2618-rc4-ext4.orig/fs/Kconfig
+++ linux-2618-rc4-ext4/fs/Kconfig
@@ -139,28 +139,29 @@ config EXT3_FS_SECURITY
 	  extended attributes for file security labels, say N.
 
 config EXT3DEV_FS
-	tristate "Developmenting extended fs support"
+	tristate "Ext3dev/ext4 extended fs support development (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	select JBD2
 	help
-	  Ext3dev is a precede filesystem toward next generation
-	  of extended fs, based on ext3 filesystem code. It will be
-	  renamed ext4 fs later once this ext3dev is mature and stabled.
+	  Ext3dev is a predecessor filesystem of the next generation
+	  extended fs ext4, based on ext3 filesystem code. It will be
+	  renamed ext4 fs later, once ext3dev is mature and stabilized.
 
 	  Unlike the change from ext2 filesystem to ext3 filesystem,
 	  the on-disk format of ext3dev is not the same as ext3 any more:
-	  it is based on extent maps and it support 48 bit physical block
+	  it is based on extent maps and it supports 48-bit physical block
 	  numbers. These combined on-disk format changes will allow
-	  ext3dev/ext4 to handle more than 16TB filesystem volume --
-	  a hard limit that ext3 can not overcome without changing
+	  ext3dev/ext4 to handle more than 16 TB filesystem volumes --
+	  a hard limit that ext3 cannot overcome without changing the
 	  on-disk format.
 
-	  Other than extent maps and 48 bit block number, ext3dev also is
+	  Other than extent maps and 48-bit block numbers, ext3dev also is
 	  likely to have other new features such as persistent preallocation,
-	  high resolution time stamps and larger file support etc.  These
+	  high resolution time stamps, and larger file support etc.  These
 	  features will be added to ext3dev gradually.
 
-	  To compile this file system support as a module, choose M here: the
-	  module will be called ext2.  Be aware however that the file system
+	  To compile this file system support as a module, choose M here. The
+	  module will be called ext3dev.  Be aware, however, that the filesystem
 	  of your root partition (the one containing the directory /) cannot
 	  be compiled as a module, and so this could be dangerous.
 
@@ -177,17 +178,17 @@ config EXT3DEV_FS_XATTR
 
 	  If unsure, say N.
 
-	  You need this for POSIX ACL support on ext3.
+	  You need this for POSIX ACL support on ext3dev/ext4.
 
 config EXT3DEV_FS_POSIX_ACL
 	bool "Ext3dev POSIX Access Control Lists"
 	depends on EXT3DEV_FS_XATTR
 	select FS_POSIX_ACL
 	help
-	  Posix Access Control Lists (ACLs) support permissions for users and
+	  POSIX Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
 
-	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  To learn more about Access Control Lists, visit the POSIX ACLs for
 	  Linux website <http://acl.bestbits.at/>.
 
 	  If you don't know what Access Control Lists are, say N
@@ -199,7 +200,7 @@ config EXT3DEV_FS_SECURITY
 	  Security labels support alternative access control models
 	  implemented by security modules like SELinux.  This option
 	  enables an extended attribute handler for file security
-	  labels in the ext3 filesystem.
+	  labels in the ext3dev/ext4 filesystem.
 
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
@@ -240,31 +241,31 @@ config JBD2
 	tristate
 	help
 	  This is a generic journaling layer for block devices that support
-	  both 32 bit and 64 bit block numbers.  It is currently used by
-	  the ext3dev/ext4 file system, but it could also be used to add
+	  both 32-bit and 64-bit block numbers.  It is currently used by
+	  the ext3dev/ext4 filesystem, but it could also be used to add
 	  journal support to other file systems or block devices such
-	   as RAID or LVM.
+	  as RAID or LVM.
 
-	  If you are using the ext4, you need to say Y here. If you are not
-	  using ext4 then you will probably want to say N.
+	  If you are using ext3dev/ext4, you need to say Y here. If you are not
+	  using ext3dev/ext4 then you will probably want to say N.
 
-	  To compile this device as a module, choose M here: the module will be
-	  called jbd.  If you are compiling ext4 into the kernel,
+	  To compile this device as a module, choose M here. The module will be
+	  called jbd2.  If you are compiling ext3dev/ext4 into the kernel,
 	  you cannot compile this code as a module.
 
 config JBD2_DEBUG
-	bool "JBD2 (ext4) debugging support"
+	bool "JBD2 (ext3dev/ext4) debugging support"
 	depends on JBD2
 	help
-	  If you are using the ext4 journaled file system (or potentially any
-	  other file system/device using JBD2), this option allows you to
-	  enable debugging output while the system is running, in order to
-	  help track down any problems you are having.  By default the
-	  debugging output will be turned off.
+	  If you are using the ext3dev/ext4 journaled file system (or
+	  potentially any other filesystem/device using JBD2), this option
+	  allows you to enable debugging output while the system is running,
+	  in order to help track down any problems you are having.
+	  By default, the debugging output will be turned off.
 
 	  If you select Y here, then you will be able to turn on debugging
 	  with "echo N > /proc/sys/fs/jbd2-debug", where N is a number between
-	  1 and 5, the higher the number, the more debugging output is
+	  1 and 5. The higher the number, the more debugging output is
 	  generated.  To turn debugging off again, do
 	  "echo 0 > /proc/sys/fs/jbd2-debug".
 
