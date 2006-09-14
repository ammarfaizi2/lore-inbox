Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWINQKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWINQKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWINQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:10:51 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:30992 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1750963AbWINQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:10:50 -0400
Date: Thu, 14 Sep 2006 12:10:41 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] CodingStyle cleanup for kernel/sys.c
Message-ID: <Pine.LNX.4.64.0609141200360.30072@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's a patch to go with my other one currently in your tree. This one 
consistifies kernel/sys.c with CodingStyle. If you think it's too academic 
then feel free to ignore :)

  - C.


From: Cal Peake <cp@absolutedigital.net>

Fix up kernel/sys.c to be consistent with CodingStyle and the rest of the 
file.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.18-rc7/kernel/sys.c~orig	2006-09-14 11:56:30.000000000 -0400
+++ linux-2.6.18-rc7/kernel/sys.c	2006-09-14 11:49:01.000000000 -0400
@@ -606,11 +606,10 @@ static void kernel_restart_prepare(char 
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
-	if (!cmd) {
+	if (!cmd)
 		printk(KERN_EMERG "Restarting system.\n");
-	} else {
+	else
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", cmd);
-	}
 	machine_restart(cmd);
 }
 EXPORT_SYMBOL_GPL(kernel_restart);
@@ -626,9 +625,8 @@ static void kernel_kexec(void)
 #ifdef CONFIG_KEXEC
 	struct kimage *image;
 	image = xchg(&kexec_image, NULL);
-	if (!image) {
+	if (!image)
 		return;
-	}
 	kernel_restart_prepare(NULL);
 	printk(KERN_EMERG "Starting new kernel\n");
 	machine_shutdown();
@@ -822,12 +820,10 @@ asmlinkage long sys_setregid(gid_t rgid,
 		    (current->sgid == egid) ||
 		    capable(CAP_SETGID))
 			new_egid = egid;
-		else {
+		else
 			return -EPERM;
-		}
 	}
-	if (new_egid != old_egid)
-	{
+	if (new_egid != old_egid) {
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
@@ -856,19 +852,14 @@ asmlinkage long sys_setgid(gid_t gid)
 	if (retval)
 		return retval;
 
-	if (capable(CAP_SETGID))
-	{
-		if(old_egid != gid)
-		{
+	if (capable(CAP_SETGID)) {
+		if (old_egid != gid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
-	}
-	else if ((gid == current->gid) || (gid == current->sgid))
-	{
-		if(old_egid != gid)
-		{
+	} else if ((gid == current->gid) || (gid == current->sgid)) {
+		if (old_egid != gid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
@@ -899,8 +890,7 @@ static int set_user(uid_t new_ruid, int 
 
 	switch_uid(new_user);
 
-	if(dumpclear)
-	{
+	if (dumpclear) {
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
@@ -956,8 +946,7 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (new_ruid != old_ruid && set_user(new_ruid, new_euid != old_euid) < 0)
 		return -EAGAIN;
 
-	if (new_euid != old_euid)
-	{
+	if (new_euid != old_euid) {
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
@@ -1007,8 +996,7 @@ asmlinkage long sys_setuid(uid_t uid)
 	} else if ((uid != current->uid) && (uid != new_suid))
 		return -EPERM;
 
-	if (old_euid != uid)
-	{
+	if (old_euid != uid) {
 		current->mm->dumpable = suid_dumpable;
 		smp_wmb();
 	}
@@ -1053,8 +1041,7 @@ asmlinkage long sys_setresuid(uid_t ruid
 			return -EAGAIN;
 	}
 	if (euid != (uid_t) -1) {
-		if (euid != current->euid)
-		{
+		if (euid != current->euid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
@@ -1104,8 +1091,7 @@ asmlinkage long sys_setresgid(gid_t rgid
 			return -EPERM;
 	}
 	if (egid != (gid_t) -1) {
-		if (egid != current->egid)
-		{
+		if (egid != current->egid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
@@ -1150,10 +1136,8 @@ asmlinkage long sys_setfsuid(uid_t uid)
 
 	if (uid == current->uid || uid == current->euid ||
 	    uid == current->suid || uid == current->fsuid || 
-	    capable(CAP_SETUID))
-	{
-		if (uid != old_fsuid)
-		{
+	    capable(CAP_SETUID)) {
+		if (uid != old_fsuid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
@@ -1181,10 +1165,8 @@ asmlinkage long sys_setfsgid(gid_t gid)
 
 	if (gid == current->gid || gid == current->egid ||
 	    gid == current->sgid || gid == current->fsgid || 
-	    capable(CAP_SETGID))
-	{
-		if (gid != old_fsgid)
-		{
+	    capable(CAP_SETGID)) {
+		if (gid != old_fsgid) {
 			current->mm->dumpable = suid_dumpable;
 			smp_wmb();
 		}
@@ -1320,9 +1302,9 @@ out:
 
 asmlinkage long sys_getpgid(pid_t pid)
 {
-	if (!pid) {
+	if (!pid)
 		return process_group(current);
-	} else {
+	else {
 		int retval;
 		struct task_struct *p;
 
@@ -1352,9 +1334,9 @@ asmlinkage long sys_getpgrp(void)
 
 asmlinkage long sys_getsid(pid_t pid)
 {
-	if (!pid) {
+	if (!pid)
 		return current->signal->session;
-	} else {
+	else {
 		int retval;
 		struct task_struct *p;
 
@@ -1362,7 +1344,7 @@ asmlinkage long sys_getsid(pid_t pid)
 		p = find_task_by_pid(pid);
 
 		retval = -ESRCH;
-		if(p) {
+		if (p) {
 			retval = security_task_getsid(p);
 			if (!retval)
 				retval = p->signal->session;
@@ -1430,9 +1412,9 @@ struct group_info *groups_alloc(int gids
 	group_info->nblocks = nblocks;
 	atomic_set(&group_info->usage, 1);
 
-	if (gidsetsize <= NGROUPS_SMALL) {
+	if (gidsetsize <= NGROUPS_SMALL)
 		group_info->blocks[0] = group_info->small_block;
-	} else {
+	else {
 		for (i = 0; i < nblocks; i++) {
 			gid_t *b;
 			b = (void *)__get_free_page(GFP_USER);
@@ -1488,7 +1470,7 @@ static int groups_to_user(gid_t __user *
 /* fill a group_info from a user-space array - it must be allocated already */
 static int groups_from_user(struct group_info *group_info,
     gid_t __user *grouplist)
- {
+{
 	int i;
 	int count = group_info->ngroups;
 
@@ -1646,9 +1628,8 @@ asmlinkage long sys_setgroups(int gidset
 int in_group_p(gid_t grp)
 {
 	int retval = 1;
-	if (grp != current->fsgid) {
+	if (grp != current->fsgid)
 		retval = groups_search(current->group_info, grp);
-	}
 	return retval;
 }
 
@@ -1657,9 +1638,8 @@ EXPORT_SYMBOL(in_group_p);
 int in_egroup_p(gid_t grp)
 {
 	int retval = 1;
-	if (grp != current->egid) {
+	if (grp != current->egid)
 		retval = groups_search(current->group_info, grp);
-	}
 	return retval;
 }
 
@@ -1774,9 +1754,9 @@ asmlinkage long sys_old_getrlimit(unsign
 	task_lock(current->group_leader);
 	x = current->signal->rlim[resource];
 	task_unlock(current->group_leader);
-	if(x.rlim_cur > 0x7FFFFFFF)
+	if (x.rlim_cur > 0x7FFFFFFF)
 		x.rlim_cur = 0x7FFFFFFF;
-	if(x.rlim_max > 0x7FFFFFFF)
+	if (x.rlim_max > 0x7FFFFFFF)
 		x.rlim_max = 0x7FFFFFFF;
 	return copy_to_user(rlim, &x, sizeof(x))?-EFAULT:0;
 }
