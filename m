Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUEFWd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUEFWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUEFWd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 18:33:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:8676 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263126AbUEFWdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 18:33:00 -0400
Date: Thu, 06 May 2004 15:30:59 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.6-rc3] Lindent on arch/i386/kernel/msr.c
Message-ID: <50390000.1083882659@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per Greg's request this is a patch of having run Lindent on msr.c.
The tabs were not the right number of spaces before. I also added a semicolon
after the module_exit statement to make Lindent do the right thing wrt the
spacing of the MODULE_AUTHOR. I have compiled and booted to verify this 
change does not break anything.

[root@w-hlinder2 0]# pwd
/dev/cpu/0
[root@w-hlinder2 0]# ls -al
total 8
drwxr-xr-x    2 root     root         4096 Oct 21  2002 .
drwxr-xr-x   18 root     root         4096 Oct 21  2002 ..
crw-------    1 root     root     203,   0 Apr 11  2002 cpuid
crw-------    1 root     root      10, 184 Apr 11  2002 microcode
crw-------    1 root     root     202,   0 Apr 11  2002 msr


Please consider for inclusion.

Thanks.

Hanna Linder
IBM Linux Technology Center
----------
diff -Nrup -Xdontdiff linux-2.6.6-rc3/arch/i386/kernel/msr.c linux-2.6.6-rc3p/arch/i386/kernel/msr.c
--- linux-2.6.6-rc3/arch/i386/kernel/msr.c	2004-04-27 18:35:44.000000000 -0700
+++ linux-2.6.6-rc3p/arch/i386/kernel/msr.c	2004-05-06 14:27:41.000000000 -0700
@@ -46,238 +46,232 @@
 
 static inline int wrmsr_eio(u32 reg, u32 eax, u32 edx)
 {
-  int err;
+	int err;
 
-  asm volatile(
-	       "1:	wrmsr\n"
-	       "2:\n"
-	       ".section .fixup,\"ax\"\n"
-	       "3:	movl %4,%0\n"
-	       "	jmp 2b\n"
-	       ".previous\n"
-	       ".section __ex_table,\"a\"\n"
-	       "	.align 4\n"
-	       "	.long 1b,3b\n"
-	       ".previous"
-	       : "=&bDS" (err)
-	       : "a" (eax), "d" (edx), "c" (reg), "i" (-EIO), "0" (0));
-
-  return err;
-}
-
-static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
-{
-  int err;
-
-  asm volatile(
-	       "1:	rdmsr\n"
-	       "2:\n"
-	       ".section .fixup,\"ax\"\n"
-	       "3:	movl %4,%0\n"
-	       "	jmp 2b\n"
-	       ".previous\n"
-	       ".section __ex_table,\"a\"\n"
-	       "	.align 4\n"
-	       "	.long 1b,3b\n"
-	       ".previous"
-	       : "=&bDS" (err), "=a" (*eax), "=d" (*edx)
-	       : "c" (reg), "i" (-EIO), "0" (0));
+	asm volatile ("1:	wrmsr\n"
+		      "2:\n"
+		      ".section .fixup,\"ax\"\n"
+		      "3:	movl %4,%0\n"
+		      "	jmp 2b\n"
+		      ".previous\n"
+		      ".section __ex_table,\"a\"\n"
+		      "	.align 4\n" "	.long 1b,3b\n" ".previous":"=&bDS" (err)
+		      :"a"(eax), "d"(edx), "c"(reg), "i"(-EIO), "0"(0));
+
+	return err;
+}
+
+static inline int rdmsr_eio(u32 reg, u32 * eax, u32 * edx)
+{
+	int err;
+
+	asm volatile ("1:	rdmsr\n"
+		      "2:\n"
+		      ".section .fixup,\"ax\"\n"
+		      "3:	movl %4,%0\n"
+		      "	jmp 2b\n"
+		      ".previous\n"
+		      ".section __ex_table,\"a\"\n"
+		      "	.align 4\n"
+		      "	.long 1b,3b\n"
+		      ".previous":"=&bDS" (err), "=a"(*eax), "=d"(*edx)
+		      :"c"(reg), "i"(-EIO), "0"(0));
 
-  return err;
+	return err;
 }
 
 #ifdef CONFIG_SMP
 
 struct msr_command {
-  int cpu;
-  int err;
-  u32 reg;
-  u32 data[2];
+	int cpu;
+	int err;
+	u32 reg;
+	u32 data[2];
 };
 
 static void msr_smp_wrmsr(void *cmd_block)
 {
-  struct msr_command *cmd = (struct msr_command *) cmd_block;
-  
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
+	struct msr_command *cmd = (struct msr_command *)cmd_block;
+
+	if (cmd->cpu == smp_processor_id())
+		cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
 }
 
 static void msr_smp_rdmsr(void *cmd_block)
 {
-  struct msr_command *cmd = (struct msr_command *) cmd_block;
-  
-  if ( cmd->cpu == smp_processor_id() )
-    cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
+	struct msr_command *cmd = (struct msr_command *)cmd_block;
+
+	if (cmd->cpu == smp_processor_id())
+		cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
 }
 
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
-  struct msr_command cmd;
-  int ret;
+	struct msr_command cmd;
+	int ret;
 
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    ret = wrmsr_eio(reg, eax, edx);
-  } else {
-    cmd.cpu = cpu;
-    cmd.reg = reg;
-    cmd.data[0] = eax;
-    cmd.data[1] = edx;
-    
-    smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
-    ret = cmd.err;
-  }
-  preempt_enable();
-  return ret;
-}
-
-static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
-{
-  struct msr_command cmd;
-  int ret;
-
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    ret = rdmsr_eio(reg, eax, edx);
-  } else {
-    cmd.cpu = cpu;
-    cmd.reg = reg;
-
-    smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
-    
-    *eax = cmd.data[0];
-    *edx = cmd.data[1];
-
-    ret = cmd.err;
-  }
-  preempt_enable();
-  return ret;
+	preempt_disable();
+	if (cpu == smp_processor_id()) {
+		ret = wrmsr_eio(reg, eax, edx);
+	} else {
+		cmd.cpu = cpu;
+		cmd.reg = reg;
+		cmd.data[0] = eax;
+		cmd.data[1] = edx;
+
+		smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+		ret = cmd.err;
+	}
+	preempt_enable();
+	return ret;
 }
 
-#else /* ! CONFIG_SMP */
+static inline int do_rdmsr(int cpu, u32 reg, u32 * eax, u32 * edx)
+{
+	struct msr_command cmd;
+	int ret;
+
+	preempt_disable();
+	if (cpu == smp_processor_id()) {
+		ret = rdmsr_eio(reg, eax, edx);
+	} else {
+		cmd.cpu = cpu;
+		cmd.reg = reg;
+
+		smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
+
+		*eax = cmd.data[0];
+		*edx = cmd.data[1];
+
+		ret = cmd.err;
+	}
+	preempt_enable();
+	return ret;
+}
+
+#else				/* ! CONFIG_SMP */
 
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
-  return wrmsr_eio(reg, eax, edx);
+	return wrmsr_eio(reg, eax, edx);
 }
 
-static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
+static inline int do_rdmsr(int cpu, u32 reg, u32 * eax, u32 * edx)
 {
-  return rdmsr_eio(reg, eax, edx);
+	return rdmsr_eio(reg, eax, edx);
 }
 
-#endif /* ! CONFIG_SMP */
+#endif				/* ! CONFIG_SMP */
 
 static loff_t msr_seek(struct file *file, loff_t offset, int orig)
 {
-  loff_t ret = -EINVAL;
-  lock_kernel();
-  switch (orig) {
-  case 0:
-    file->f_pos = offset;
-    ret = file->f_pos;
-    break;
-  case 1:
-    file->f_pos += offset;
-    ret = file->f_pos;
-  }
-  unlock_kernel();
-  return ret;
-}
-
-static ssize_t msr_read(struct file * file, char __user * buf,
-			size_t count, loff_t *ppos)
-{
-  u32 *tmp = (u32 *)buf;
-  u32 data[2];
-  size_t rv;
-  u32 reg = *ppos;
-  int cpu = iminor(file->f_dentry->d_inode);
-  int err;
-
-  if ( count % 8 )
-    return -EINVAL; /* Invalid chunk size */
-  
-  for ( rv = 0 ; count ; count -= 8 ) {
-    err = do_rdmsr(cpu, reg, &data[0], &data[1]);
-    if ( err )
-      return err;
-    if ( copy_to_user(tmp,&data,8) )
-      return -EFAULT;
-    tmp += 2;
-  }
-
-  return ((char *)tmp) - buf;
-}
-
-static ssize_t msr_write(struct file * file, const char __user * buf,
-			 size_t count, loff_t *ppos)
-{
-  const u32 *tmp = (const u32 *)buf;
-  u32 data[2];
-  size_t rv;
-  u32 reg = *ppos;
-  int cpu = iminor(file->f_dentry->d_inode);
-  int err;
-
-  if ( count % 8 )
-    return -EINVAL; /* Invalid chunk size */
-  
-  for ( rv = 0 ; count ; count -= 8 ) {
-    if ( copy_from_user(&data,tmp,8) )
-      return -EFAULT;
-    err = do_wrmsr(cpu, reg, data[0], data[1]);
-    if ( err )
-      return err;
-    tmp += 2;
-  }
+	loff_t ret = -EINVAL;
+	lock_kernel();
+	switch (orig) {
+	case 0:
+		file->f_pos = offset;
+		ret = file->f_pos;
+		break;
+	case 1:
+		file->f_pos += offset;
+		ret = file->f_pos;
+	}
+	unlock_kernel();
+	return ret;
+}
+
+static ssize_t msr_read(struct file *file, char __user * buf,
+			size_t count, loff_t * ppos)
+{
+	u32 *tmp = (u32 *) buf;
+	u32 data[2];
+	size_t rv;
+	u32 reg = *ppos;
+	int cpu = iminor(file->f_dentry->d_inode);
+	int err;
+
+	if (count % 8)
+		return -EINVAL;	/* Invalid chunk size */
+
+	for (rv = 0; count; count -= 8) {
+		err = do_rdmsr(cpu, reg, &data[0], &data[1]);
+		if (err)
+			return err;
+		if (copy_to_user(tmp, &data, 8))
+			return -EFAULT;
+		tmp += 2;
+	}
+
+	return ((char *)tmp) - buf;
+}
+
+static ssize_t msr_write(struct file *file, const char __user * buf,
+			 size_t count, loff_t * ppos)
+{
+	const u32 *tmp = (const u32 *)buf;
+	u32 data[2];
+	size_t rv;
+	u32 reg = *ppos;
+	int cpu = iminor(file->f_dentry->d_inode);
+	int err;
+
+	if (count % 8)
+		return -EINVAL;	/* Invalid chunk size */
+
+	for (rv = 0; count; count -= 8) {
+		if (copy_from_user(&data, tmp, 8))
+			return -EFAULT;
+		err = do_wrmsr(cpu, reg, data[0], data[1]);
+		if (err)
+			return err;
+		tmp += 2;
+	}
 
-  return ((char *)tmp) - buf;
+	return ((char *)tmp) - buf;
 }
 
 static int msr_open(struct inode *inode, struct file *file)
 {
-  int cpu = iminor(file->f_dentry->d_inode);
-  struct cpuinfo_x86 *c = &(cpu_data)[cpu];
-  
-  if (!cpu_online(cpu))
-    return -ENXIO;		/* No such CPU */
-  if ( !cpu_has(c, X86_FEATURE_MSR) )
-    return -EIO;		/* MSR not supported */
-  
-  return 0;
+	int cpu = iminor(file->f_dentry->d_inode);
+	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+
+	if (!cpu_online(cpu))
+		return -ENXIO;	/* No such CPU */
+	if (!cpu_has(c, X86_FEATURE_MSR))
+		return -EIO;	/* MSR not supported */
+
+	return 0;
 }
 
 /*
  * File operations we support
  */
 static struct file_operations msr_fops = {
-  .owner	= THIS_MODULE,
-  .llseek	= msr_seek,
-  .read		= msr_read,
-  .write	= msr_write,
-  .open		= msr_open,
+	.owner = THIS_MODULE,
+	.llseek = msr_seek,
+	.read = msr_read,
+	.write = msr_write,
+	.open = msr_open,
 };
 
 int __init msr_init(void)
 {
-  if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
-    printk(KERN_ERR "msr: unable to get major %d for msr\n",
-	   MSR_MAJOR);
-    return -EBUSY;
-  }
-  
-  return 0;
+	if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
+		printk(KERN_ERR "msr: unable to get major %d for msr\n",
+		       MSR_MAJOR);
+		return -EBUSY;
+	}
+
+	return 0;
 }
 
 void __exit msr_exit(void)
 {
-  unregister_chrdev(MSR_MAJOR, "cpu/msr");
+	unregister_chrdev(MSR_MAJOR, "cpu/msr");
 }
 
 module_init(msr_init);
-module_exit(msr_exit)
+module_exit(msr_exit);
 
 MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic MSR driver");

