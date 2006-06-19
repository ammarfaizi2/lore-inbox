Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWFSMZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWFSMZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWFSMZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932392AbWFSMZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:05 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/15] frv: misc __user annotations
Date: Mon, 19 Jun 2006 13:24:57 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122457.10060.10101.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/irq.c      |    6 +++---
 arch/frv/kernel/process.c  |    2 +-
 arch/frv/kernel/sys_frv.c  |    2 +-
 include/asm-frv/checksum.h |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/frv/kernel/irq.c b/arch/frv/kernel/irq.c
index 11fa326..8b112b3 100644
--- a/arch/frv/kernel/irq.c
+++ b/arch/frv/kernel/irq.c
@@ -625,7 +625,7 @@ static struct proc_dir_entry * irq_dir [
 
 #define HEX_DIGITS 8
 
-static unsigned int parse_hex_value (const char *buffer,
+static unsigned int parse_hex_value (const char __user *buffer,
 				     unsigned long count, unsigned long *ret)
 {
 	unsigned char hexnum [HEX_DIGITS];
@@ -672,7 +672,7 @@ static int prof_cpu_mask_read_proc (char
 	return sprintf (page, "%08lx\n", *mask);
 }
 
-static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
+static int prof_cpu_mask_write_proc (struct file *file, const char __user *buffer,
 					unsigned long count, void *data)
 {
 	unsigned long *mask = (unsigned long *) data, full_count = count, err;
@@ -711,7 +711,7 @@ void init_irq_proc (void)
 	int i;
 
 	/* create /proc/irq */
-	root_irq_dir = proc_mkdir("irq", 0);
+	root_irq_dir = proc_mkdir("irq", NULL);
 
 	/* create /proc/irq/prof_cpu_mask */
 	entry = create_proc_entry("prof_cpu_mask", 0600, root_irq_dir);
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index 0fff8a6..489e6c4 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -246,7 +246,7 @@ int copy_thread(int nr, unsigned long cl
 /*
  * sys_execve() executes a new program.
  */
-asmlinkage int sys_execve(char *name, char **argv, char **envp)
+asmlinkage int sys_execve(char __user *name, char __user * __user *argv, char __user * __user *envp)
 {
 	int error;
 	char * filename;
diff --git a/arch/frv/kernel/sys_frv.c b/arch/frv/kernel/sys_frv.c
index 931aa6d..c4d4348 100644
--- a/arch/frv/kernel/sys_frv.c
+++ b/arch/frv/kernel/sys_frv.c
@@ -32,7 +32,7 @@ #include <asm/ipc.h>
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way unix traditionally does this, though.
  */
-asmlinkage long sys_pipe(unsigned long * fildes)
+asmlinkage long sys_pipe(unsigned long __user * fildes)
 {
 	int fd[2];
 	int error;
diff --git a/include/asm-frv/checksum.h b/include/asm-frv/checksum.h
index 10236f6..42bf0db 100644
--- a/include/asm-frv/checksum.h
+++ b/include/asm-frv/checksum.h
@@ -43,7 +43,7 @@ unsigned int csum_partial_copy(const cha
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern unsigned int csum_partial_copy_from_user(const char *src, char *dst,
+extern unsigned int csum_partial_copy_from_user(const char __user *src, char *dst,
 						int len, int sum, int *csum_err);
 
 #define csum_partial_copy_nocheck(src, dst, len, sum)	\

