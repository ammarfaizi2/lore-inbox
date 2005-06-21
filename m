Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVFUWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVFUWog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVFUWlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:41:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:10686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262404AbVFUWY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:24:26 -0400
Date: Tue, 21 Jun 2005 15:24:19 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Message-ID: <20050621222419.GA23896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a much smaller patch to simply disable devfs from the build.  If
this goes well, and there are no complaints for a few weeks, I'll resend
my big "devfs-die-die-die" series of patches that rip the whole thing
out of the kernel tree.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/Kconfig |   50 --------------------------------------------------
 1 files changed, 50 deletions(-)

--- gregkh-2.6.orig/fs/Kconfig	2005-06-21 14:46:34.000000000 -0700
+++ gregkh-2.6/fs/Kconfig	2005-06-21 14:48:27.000000000 -0700
@@ -741,56 +741,6 @@
 
 	Designers of embedded systems may wish to say N here to conserve space.
 
-config DEVFS_FS
-	bool "/dev file system support (OBSOLETE)"
-	depends on EXPERIMENTAL
-	help
-	  This is support for devfs, a virtual file system (like /proc) which
-	  provides the file system interface to device drivers, normally found
-	  in /dev. Devfs does not depend on major and minor number
-	  allocations. Device drivers register entries in /dev which then
-	  appear automatically, which means that the system administrator does
-	  not have to create character and block special device files in the
-	  /dev directory using the mknod command (or MAKEDEV script) anymore.
-
-	  This is work in progress. If you want to use this, you *must* read
-	  the material in <file:Documentation/filesystems/devfs/>, especially
-	  the file README there.
-
-	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
-	  ptys, you will also need to mount the /dev/pts filesystem (devpts).
-
-	  Note that devfs has been obsoleted by udev,
-	  <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.
-	  It has been stripped down to a bare minimum and is only provided for
-	  legacy installations that use its naming scheme which is
-	  unfortunately different from the names normal Linux installations
-	  use.
-
-	  If unsure, say N.
-
-config DEVFS_MOUNT
-	bool "Automatically mount at boot"
-	depends on DEVFS_FS
-	help
-	  This option appears if you have CONFIG_DEVFS_FS enabled. Setting
-	  this to 'Y' will make the kernel automatically mount devfs onto /dev
-	  when the system is booted, before the init thread is started.
-	  You can override this with the "devfs=nomount" boot option.
-
-	  If unsure, say N.
-
-config DEVFS_DEBUG
-	bool "Debug devfs"
-	depends on DEVFS_FS
-	help
-	  If you say Y here, then the /dev file system code will generate
-	  debugging messages. See the file
-	  <file:Documentation/filesystems/devfs/boot-options> for more
-	  details.
-
-	  If unsure, say N.
-
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
 	depends on UNIX98_PTYS
