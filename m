Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752191AbWCCJGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbWCCJGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWCCJGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:06:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752191AbWCCJGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:06:08 -0500
Date: Fri, 3 Mar 2006 00:49:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: efault@gmx.de, nickpiggin@yahoo.com.au, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, pj@sgi.com
Subject: Re: [PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/
 symlinks.
Message-Id: <20060303004942.3b96a8ae.akpm@osdl.org>
In-Reply-To: <m1u0agkdkh.fsf_-_@ebiederm.dsl.xmission.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<1141221511.7775.10.camel@homer>
	<4405B4AA.7090207@free.fr>
	<1141227199.10460.2.camel@homer>
	<20060301121218.68fb3f76.akpm@osdl.org>
	<m1u0agkdkh.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With all your latest patches I get a big spew lateish in the boot:

EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1135 types, 133 bools, 1 sens, 256 cats
security:  55 classes, 37666 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda6, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
audit(1141341858.520:2): avc:  denied  { ptrace } for  pid=372 comm="restorecon" scontext=system_u:system_r:restorecon_t:s0 tcontext=system_u:system_r:restorecon_t:s0 tclass=process
audit(1141341858.520:3): avc:  denied  { ptrace } for  pid=372 comm="restorecon" scontext=system_u:system_r:restorecon_t:s0 tcontext=system_u:system_r:restorecon_t:s0 tclass=process
audit(1141341858.520:4): avc:  denied  { ptrace } for  pid=372 comm="restorecon" scontext=system_u:system_r:restorecon_t:s0 tcontext=system_u:system_r:restorecon_t:s0 tclass=process
audit(1141341858.520:5): avc:  denied  { ptrace } for  pid=372 comm="restorecon" scontext=system_u:system_r:restorecon_t:s0 tcontext=system_u:system_r:restorecon_t:s0 tclass=process
audit(1141341858.520:6): avc:  denied  { ptrace } for  pid=372 comm="restorecon" scontext=system_u:system_r:restorecon_t:s0 tcontext=system_u:system_r:restorecon_t:s0 tclass=process
...
audit(1141370661.947:106): avc:  denied  { ptrace } for  pid=380 comm="hwclock" scontext=system_u:system_r:hwclock_t:s0 tcontext=system_u:system_r:hwclock_t:s0 tclass=process
audit(1141370661.947:107): avc:  denied  { ptrace } for  pid=380 comm="hwclock" scontext=system_u:system_r:hwclock_t:s0 tcontext=system_u:system_r:hwclock_t:s0 tclass=process
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later


Reverting just this patch prevents the above.

This is with basically unaltered FC5 as of a few days ago.  The audit
patches weren't applied.

What is happening is that both `current' and get_proc_task(inode) are the
same task_struct: `restorecon' is trying to read its own proc files.  But
ptrace_may_attach()->security_ptrace() is returning -EACCES.

So I bodged it in the obvious manner:

--- devel/fs/proc/base.c~proc-use-sane-permission-checks-on-the-proc-pid-fd-fix	2006-03-03 00:38:17.000000000 -0800
+++ devel-akpm/fs/proc/base.c	2006-03-03 00:43:54.000000000 -0800
@@ -521,8 +521,11 @@ static int proc_fd_access_allowed(struct
 	 * allow access if we have the proper capability.
 	 */
 	task = get_proc_task(inode);
-	if (task) {
+	if (task == current)
+		allowed = 1;
+	if (task && !allowed) {
 		int alive;
+
 		task_lock(task);
 		alive = !!task->mm;
 		task_unlock(task);

And the messages went away.

But I have a bad feeling about these /proc permission changes, Eric.  I
suspect we'll be chasing a gradually decreasing frequency of weird problems
for a long time.


That task_lock() you have in proc_fd_access_allowed() looks very fishy,
btw.  As soon as the lock is dropped, local `alive' becomes meaningless. 
Either that, or the lock wasn't needed.


btw, it's surprising (to me) that security_ptrace(t1, t2) fails when
t1==t2?

