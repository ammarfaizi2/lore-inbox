Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992848AbWJUHNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992848AbWJUHNy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992842AbWJUHNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:50 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:17287 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992837AbWJUHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 23] i386: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <80b5ca3e42d1fb3ea5bb.1161411457@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:37 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the i386 arch code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

2 files changed, 5 insertions(+), 5 deletions(-)
arch/i386/kernel/cpuid.c |    4 ++--
arch/i386/kernel/msr.c   |    6 +++---

diff --git a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -117,7 +117,7 @@ static ssize_t cpuid_read(struct file *f
 	char __user *tmp = buf;
 	u32 data[4];
 	u32 reg = *ppos;
-	int cpu = iminor(file->f_dentry->d_inode);
+	int cpu = iminor(file->f_path.dentry->d_inode);
 
 	if (count % 16)
 		return -EINVAL;	/* Invalid chunk size */
@@ -135,7 +135,7 @@ static ssize_t cpuid_read(struct file *f
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-	unsigned int cpu = iminor(file->f_dentry->d_inode);
+	unsigned int cpu = iminor(file->f_path.dentry->d_inode);
 	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
 	if (cpu >= NR_CPUS || !cpu_online(cpu))
diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -172,7 +172,7 @@ static ssize_t msr_read(struct file *fil
 	u32 __user *tmp = (u32 __user *) buf;
 	u32 data[2];
 	u32 reg = *ppos;
-	int cpu = iminor(file->f_dentry->d_inode);
+	int cpu = iminor(file->f_path.dentry->d_inode);
 	int err;
 
 	if (count % 8)
@@ -197,7 +197,7 @@ static ssize_t msr_write(struct file *fi
 	u32 data[2];
 	size_t rv;
 	u32 reg = *ppos;
-	int cpu = iminor(file->f_dentry->d_inode);
+	int cpu = iminor(file->f_path.dentry->d_inode);
 	int err;
 
 	if (count % 8)
@@ -217,7 +217,7 @@ static ssize_t msr_write(struct file *fi
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-	unsigned int cpu = iminor(file->f_dentry->d_inode);
+	unsigned int cpu = iminor(file->f_path.dentry->d_inode);
 	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
 	if (cpu >= NR_CPUS || !cpu_online(cpu))


