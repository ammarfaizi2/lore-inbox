Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUBVAN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 19:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUBVAN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 19:13:56 -0500
Received: from pxy6allmi.all.mi.charter.com ([24.247.15.57]:45979 "EHLO
	proxy6-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261625AbUBVANg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 19:13:36 -0500
Message-ID: <4037F4E0.6050508@quark.didntduck.org>
Date: Sat, 21 Feb 2004 19:16:32 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Run cpuid.c and msr.c through Lindent
Content-Type: multipart/mixed;
 boundary="------------000408060203050302030302"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408060203050302030302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Run cpuid.c and msr.c through Lindent to improve readability.  The only 
non-whitespace change was to add a missing semicolon after module_exit().

--
				Brian Gerst

--------------000408060203050302030302
Content-Type: text/plain;
 name="lindent-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lindent-1"

diff -ur linux-bk/arch/i386/kernel/cpuid.c linux/arch/i386/kernel/cpuid.c
--- linux-bk/arch/i386/kernel/cpuid.c	2004-02-18 01:37:14.000000000 -0500
+++ linux/arch/i386/kernel/cpuid.c	2004-02-21 18:41:25.347471544 -0500
@@ -10,7 +10,6 @@
  *
  * ----------------------------------------------------------------------- */
 
-
 /*
  * cpuid.c
  *
@@ -46,131 +45,132 @@
 #ifdef CONFIG_SMP
 
 struct cpuid_command {
-  int cpu;
-  u32 reg;
-  u32 *data;
+	int cpu;
+	u32 reg;
+	u32 *data;
 };
 
 static void cpuid_smp_cpuid(void *cmd_block)
 {
-  struct cpuid_command *cmd = (struct cpuid_command *) cmd_block;
-  
-  if ( cmd->cpu == smp_processor_id() )
-    cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2], &cmd->data[3]);
+	struct cpuid_command *cmd = (struct cpuid_command *)cmd_block;
+
+	if (cmd->cpu == smp_processor_id())
+		cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2],
+		      &cmd->data[3]);
 }
 
 static inline void do_cpuid(int cpu, u32 reg, u32 *data)
 {
-  struct cpuid_command cmd;
-  
-  preempt_disable();
-  if ( cpu == smp_processor_id() ) {
-    cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
-  } else {
-    cmd.cpu  = cpu;
-    cmd.reg  = reg;
-    cmd.data = data;
-    
-    smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
-  }
-  preempt_enable();
+	struct cpuid_command cmd;
+
+	preempt_disable();
+	if (cpu == smp_processor_id()) {
+		cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+	} else {
+		cmd.cpu = cpu;
+		cmd.reg = reg;
+		cmd.data = data;
+
+		smp_call_function(cpuid_smp_cpuid, &cmd, 1, 1);
+	}
+	preempt_enable();
 }
 #else /* ! CONFIG_SMP */
 
 static inline void do_cpuid(int cpu, u32 reg, u32 *data)
 {
-  cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
+	cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
 }
 
 #endif /* ! CONFIG_SMP */
 
 static loff_t cpuid_seek(struct file *file, loff_t offset, int orig)
 {
-  loff_t ret;
+	loff_t ret;
 
-  lock_kernel();
+	lock_kernel();
 
-  switch (orig) {
-  case 0:
-    file->f_pos = offset;
-    ret = file->f_pos;
-    break;
-  case 1:
-    file->f_pos += offset;
-    ret = file->f_pos;
-    break;
-  default:
-    ret = -EINVAL;
-  }
-
-  unlock_kernel();
-  return ret;
-}
-
-static ssize_t cpuid_read(struct file * file, char * buf,
-			size_t count, loff_t *ppos)
-{
-  u32 *tmp = (u32 *)buf;
-  u32 data[4];
-  size_t rv;
-  u32 reg = *ppos;
-  int cpu = iminor(file->f_dentry->d_inode);
-  
-  if ( count % 16 )
-    return -EINVAL; /* Invalid chunk size */
-  
-  for ( rv = 0 ; count ; count -= 16 ) {
-    do_cpuid(cpu, reg, data);
-    if ( copy_to_user(tmp,&data,16) )
-      return -EFAULT;
-    tmp += 4;
-    *ppos = reg++;
-  }
-  
-  return ((char *)tmp) - buf;
+	switch (orig) {
+	case 0:
+		file->f_pos = offset;
+		ret = file->f_pos;
+		break;
+	case 1:
+		file->f_pos += offset;
+		ret = file->f_pos;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	unlock_kernel();
+	return ret;
+}
+
+static ssize_t cpuid_read(struct file *file, char *buf,
+			  size_t count, loff_t *ppos)
+{
+	u32 *tmp = (u32 *)buf;
+	u32 data[4];
+	size_t rv;
+	u32 reg = *ppos;
+	int cpu = iminor(file->f_dentry->d_inode);
+
+	if (count % 16)
+		return -EINVAL;	/* Invalid chunk size */
+
+	for (rv = 0; count; count -= 16) {
+		do_cpuid(cpu, reg, data);
+		if (copy_to_user(tmp, &data, 16))
+			return -EFAULT;
+		tmp += 4;
+		*ppos = reg++;
+	}
+
+	return ((char *)tmp) - buf;
 }
 
 static int cpuid_open(struct inode *inode, struct file *file)
 {
-  int cpu = iminor(file->f_dentry->d_inode);
-  struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+	int cpu = iminor(file->f_dentry->d_inode);
+	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+
+	if (!cpu_online(cpu))
+		return -ENXIO;	/* No such CPU */
+	if (c->cpuid_level < 0)
+		return -EIO;	/* CPUID not supported */
 
-  if (!cpu_online(cpu))
-    return -ENXIO;		/* No such CPU */
-  if ( c->cpuid_level < 0 )
-    return -EIO;		/* CPUID not supported */
-  
-  return 0;
+	return 0;
 }
 
 /*
  * File operations we support
  */
 static struct file_operations cpuid_fops = {
-  .owner	= THIS_MODULE,
-  .llseek	= cpuid_seek,
-  .read		= cpuid_read,
-  .open		= cpuid_open,
+	.owner = THIS_MODULE,
+	.llseek = cpuid_seek,
+	.read = cpuid_read,
+	.open = cpuid_open,
 };
 
 int __init cpuid_init(void)
 {
-  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
-    printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
-	   CPUID_MAJOR);
-    return -EBUSY;
-  }
+	if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
+		printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
+		       CPUID_MAJOR);
+		return -EBUSY;
+	}
 
-  return 0;
+	return 0;
 }
 
 void __exit cpuid_exit(void)
 {
-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 }
 
 module_init(cpuid_init);
-module_exit(cpuid_exit)
+module_exit(cpuid_exit);
 
 MODULE_AUTHOR("H. Peter Anvin <hpa@zytor.com>");
 MODULE_DESCRIPTION("x86 generic CPUID driver");
diff -ur linux-bk/arch/i386/kernel/msr.c linux/arch/i386/kernel/msr.c
--- linux-bk/arch/i386/kernel/msr.c	2004-02-18 01:37:14.000000000 -0500
+++ linux/arch/i386/kernel/msr.c	2004-02-21 18:52:55.806505816 -0500
@@ -46,238 +46,236 @@
 
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
+	asm volatile ("1:	wrmsr\n"
+		      "2:\n"
+		      ".section .fixup,\"ax\"\n"
+		      "3:	movl %4,%0\n"
+		      "	jmp 2b\n"
+		      ".previous\n"
+		      ".section __ex_table,\"a\"\n"
+		      "	.align 4\n"
+		      "	.long 1b,3b\n"
+		      ".previous"
+		      :"=&bDS" (err)
+		      :"a"(eax), "d"(edx), "c"(reg), "i"(-EIO), "0"(0));
 
-  return err;
+	return err;
 }
 
 static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
 {
-  int err;
+	int err;
 
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
+	asm volatile ("1:	rdmsr\n"
+		      "2:\n"
+		      ".section .fixup,\"ax\"\n"
+		      "3:	movl %4,%0\n"
+		      "	jmp 2b\n"
+		      ".previous\n"
+		      ".section __ex_table,\"a\"\n"
+		      "	.align 4\n"
+		      "	.long 1b,3b\n"
+		      ".previous"
+		      :"=&bDS" (err), "=a"(*eax), "=d"(*edx)
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
 
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
-  struct msr_command cmd;
-  int ret;
+	struct msr_command cmd;
+	int ret;
 
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
 }
 
 #else /* ! CONFIG_SMP */
 
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
-  return wrmsr_eio(reg, eax, edx);
+	return wrmsr_eio(reg, eax, edx);
 }
 
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
-  return rdmsr_eio(reg, eax, edx);
+	return rdmsr_eio(reg, eax, edx);
 }
 
 #endif /* ! CONFIG_SMP */
 
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
 }
 
-static ssize_t msr_read(struct file * file, char __user * buf,
+static ssize_t msr_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
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
+	u32 *tmp = (u32 *)buf;
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
 
-  return ((char *)tmp) - buf;
+	return ((char *)tmp) - buf;
 }
 
-static ssize_t msr_write(struct file * file, const char __user * buf,
+static ssize_t msr_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
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

--------------000408060203050302030302--
