Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUFCIga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUFCIga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUFCIga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:36:30 -0400
Received: from [194.85.238.98] ([194.85.238.98]:38535 "EHLO school.ioffe.ru")
	by vger.kernel.org with ESMTP id S261857AbUFCIg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:36:27 -0400
Date: Thu, 3 Jun 2004 12:36:22 +0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
Message-ID: <20040603083622.GA9918@school.ioffe.ru>
References: <20040602174810.GA31263@school.ioffe.ru> <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.3.28i
From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Wed, Jun 02, 2004 at 02:40:47PM -0400, Stephen Smalley wrote:
> On Wed, 2004-06-02 at 13:48, Dmitry Baryshkov wrote:
> > Hello,
> 
> The mount process shouldn't be in kernel_t, although that shouldn't
> cause a hang.  Is /sbin/init labeled properly?  Are you using the
> patched /sbin/init that loads policy and then re-execs itself into the
> proper security domain?

Yes and no.
strace & cut was produced using manual booting to shell,
mount /proc
mount /selinux
load_policy /etc/security/selinux/policy.17
strace mount / -o remount,rw

> 
> When the mount process is hung, what output do you get from pressing
> ALT-SysRq-t after enabling sysrq (echo 1 > /proc/sys/kernel/sysrq)?

Here is a part related to mount (sorry, it's copied by hand from
monitor. can't use serial console here.):

inode2sd+0xcc/0x120
pathrelse+0x20/0x30
reiserfs_update_sd_size+0x13a/0x1d0
rwsem_down_read_failed+0x8d/0x170
.text.lock.xattr+0xb5/0x22f
inode_doinit_with_dentry+0x2ea/0x560
d_instantiate+0x47/0x60
reiserfs_mkdir+0x29b/0x2d0
open_xa_dir+0xbe/0x160
get_xa_file_dentry+0x24/0x100
open_xa_file+0x5/0x40
reiserfs_xattr_set+0x8f/0x360
do_journal_end+0x75e/0xa70
vsprintf+0x12/0x20
sprintf+0x11/0x20
context_struct_to_string+0x108/0x170
reiserfs_setxattr+0xf4/0x190
post_create+0xfb/0x220
vfs_create+0xca/0x130
open_namei+0x3d0/0x420
filp_open+0x2d/0x60
sys_open+0x4d/0xa0
syscall_call+0x7/0xb

-- 
With best wishes
DMitry Baryshkov.
