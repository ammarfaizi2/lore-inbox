Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTFBXCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbTFBXCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 19:02:30 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:55795 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264203AbTFBXC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 19:02:28 -0400
Date: Mon, 2 Jun 2003 16:12:56 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-lsm1
Message-ID: <20030602161256.K14544@figure1.int.wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Security Modules project provides a lightweight, general purpose
framework for access control.  The LSM interface enables developing
security policies as loadable kernel modules.  See http://lsm.immunix.org
for more information.

2.5.70-lsm1 patch released.  This is an update up to 2.5.70 as well as
some interface and module updates, and various cleanups.  Out of tree
projects will want to resync with interface changes.  Expect that some
modules may not be build ATM.  Patches welcome ;-)

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.70/patch-2.5.70-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.70/ChangeLog-2.5.70-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

ChangeLog summary:
------------------
Chris Wright:
  o merge with 2.5.70 TAG: v2.5.70-lsm1
  o patch-2.5.70 TAG: LINUX_2.5.70
  o Merge lsm@lsm.bkbits.net:lsm-2.5 into wirex.com:/home/chris/bk/lsm/lsm-2.5
  o Makefile, Kconfig
  o Add TPE to the LSM tree
  o fixup merge error, skb_head_pool was removed
  o merge with 2.5.69
  o patch-2.5.69 TAG: LINUX_2.5.69
  o Merge wirex.com:/home/chris/bk/lsm/linux-2.5 into
    wirex.com:/home/chris/bk/lsm/lsm-2.5
  o patch-2.5.68 TAG: LINUX_2.5.68
  o As discussed before, here is a simple patch to allow for early
    initialization of security modules when compiled statically into the
    kernel.  The standard do_initcalls is too late for complete coverage of all
    filesystems and threads for example.
  o Merge
  o patch-2.5.67 TAG: LINUX_2.5.67

Niki Rahimi:
  o TPE cleanups

Serge Hallyn:
  o LSM modules, when built into the kernel, can now be loaded earlier than
    ever.  But policies are supposed to be loaded by a user-space process, so
    DTE policies are now loaded later than ever.  This patch tracks the process
    tree between the time that DTE is loaded (whether as module or bulit-in),
    and the time that a policy is loaded, and retrofits domains as though the
    policy had been running all along.
  o DTE now interacts with userspace (including reading its policy) through
    sysfs

Stephen D. Smalley:
  o SELinux:  Fixes for 2.5.70
  o SELinux:  Remove inode_permission_list hook, since it doesn't exist in the
    lsm-2.5 BitKeeper tree anymore, but it is still present in the mainline 2.5
    tree.
  o The new 2.5 SELinux
  o Add an xattr handler for the security. namespace to devpts and add
    corresponding hooks to the LSM API to support conversion between xattr
    values and the security labels stored in the inode security field by the
    security module.  This allows userspace to get and set security labels on
    devpts nodes, e.g. so that sshd can set the security label for the pty via
    setxattr.  LSM API changes should be re-useable for other pseudo
    filesystems.
  o Add a hook to proc_pid_make_inode to allow security modules to set the
    security attributes on /proc/pid inodes based on the security attributes of
    the asociated task.
  o Add an xattr handler for ext3 to support the security. namespace for
    security modules.
  o Add an xattr handler for ext2 to support the security. namespace for
    security modules.
  o Move the security_d_instantiate hook call after the inode has been attached
    to the dentry so that the security module can call the getxattr inode
    operation from this hook to obtain the inode security label.
  o Add a inode_post_setxattr hook so that security modules can update their
    state after a successful setxattr, and move the existing inode_setxattr
    hook after taking the inode semaphore so that atomicity is provided for the
    security check and the update to the security field.
  o Process attribute API implemented via /proc/pid/attr nodes
  o SELinux:  Replace uses of kdevname with sb->s_id since kdevname is gone

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
