Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266411AbUFVEkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266411AbUFVEkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUFVEkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:40:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:17865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266411AbUFVEkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:40:00 -0400
Date: Mon, 21 Jun 2004 21:34:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>,
       viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] sparse: quota annotation
Message-Id: <20040621213444.15007754.rddunlap@osdl.org>
In-Reply-To: <200406220409.i5M49pZC015043@hera.kernel.org>
References: <200406220409.i5M49pZC015043@hera.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 03:26:01 +0000 Linux Kernel Mailing List wrote:

| ChangeSet 1.1830, 2004/06/21 20:26:01-07:00, viro@www.linux.org.uk
| 
| 	[PATCH] sparse: quota annotation
| 
|  quota.c |    4 ++--
|  1 files changed, 2 insertions(+), 2 deletions(-)
| 
| 
| diff -Nru a/fs/quota.c b/fs/quota.c
| --- a/fs/quota.c	2004-06-21 21:09:59 -07:00
| +++ b/fs/quota.c	2004-06-21 21:09:59 -07:00
| @@ -150,7 +150,7 @@
|  }
|  
|  /* Copy parameters and call proper function */
| -static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id, caddr_t addr)
| +static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id, void __user *addr)
|  {
|  	int ret;
|  
| @@ -264,7 +264,7 @@
|   * calls. Maybe we need to add the process quotas etc. in the future,
|   * but we probably should use rlimits for that.
|   */
| -asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special, qid_t id, caddr_t addr)
| +asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special, qid_t id, void __user *addr)
|  {
|  	uint cmds, type;
|  	struct super_block *sb = NULL;
| -

and in syscalls.h ... ?



sys_quotactl() prototype to match function

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 include/linux/syscalls.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./include/linux/syscalls.h~syscall_quotactl ./include/linux/syscalls.h
--- ./include/linux/syscalls.h~syscall_quotactl	2004-06-15 22:20:26.000000000 -0700
+++ ./include/linux/syscalls.h	2004-06-21 21:31:11.000000000 -0700
@@ -382,7 +382,7 @@ asmlinkage long sys_fchdir(unsigned int 
 asmlinkage long sys_rmdir(const char __user *pathname);
 asmlinkage long sys_lookup_dcookie(u64 cookie64, char __user *buf, size_t len);
 asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
-				qid_t id, caddr_t addr);
+				qid_t id, void __user *addr);
 asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
 				unsigned int count);
