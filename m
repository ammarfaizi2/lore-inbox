Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTEEDAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 23:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTEEDAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 23:00:51 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:65295 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261916AbTEEDAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 23:00:37 -0400
Date: Sun, 4 May 2003 22:13:00 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Add C99 initializers to kernel/sysctl.c
Message-ID: <20030505031300.GB5680@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds C99 initializers to kernel/sysctl.c. The patch is
against the current BK. I've had this patch for a while - the kernel
running right now has it.

Art Haas

===== kernel/sysctl.c 1.41 vs edited =====
--- 1.41/kernel/sysctl.c	Wed Apr  9 22:50:43 2003
+++ edited/kernel/sysctl.c	Sun May  4 14:47:15 2003
@@ -149,123 +149,408 @@
 /* The default sysctl tables: */
 
 static ctl_table root_table[] = {
-	{CTL_KERN, "kernel", NULL, 0, 0555, kern_table},
-	{CTL_VM, "vm", NULL, 0, 0555, vm_table},
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= kern_table,
+	},
+	{
+		.ctl_name	= CTL_VM,
+		.procname	= "vm",
+		.mode		= 0555,
+		.child		= vm_table,
+	},
 #ifdef CONFIG_NET
-	{CTL_NET, "net", NULL, 0, 0555, net_table},
-#endif
-	{CTL_PROC, "proc", NULL, 0, 0555, proc_table},
-	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
-	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
-        {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
-	{0}
+	{
+		.ctl_name	= CTL_NET,
+		.procname	= "net",
+		.mode		= 0555,
+		.child		= net_table,
+	},
+#endif
+	{
+		.ctl_name	= CTL_PROC,
+		.procname	= "proc",
+		.mode		= 0555,
+		.child		= proc_table,
+	},
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= fs_table,
+	},
+	{
+		.ctl_name	= CTL_DEBUG,
+		.procname	= "debug",
+		.mode		= 0555,
+		.child		= debug_table,
+	},
+	{
+		.ctl_name	= CTL_DEV,
+		.procname	= "dev",
+		.mode		= 0555,
+		.child		= dev_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table kern_table[] = {
-	{KERN_OSTYPE, "ostype", system_utsname.sysname, 64,
-	 0444, NULL, &proc_doutsstring, &sysctl_string},
-	{KERN_OSRELEASE, "osrelease", system_utsname.release, 64,
-	 0444, NULL, &proc_doutsstring, &sysctl_string},
-	{KERN_VERSION, "version", system_utsname.version, 64,
-	 0444, NULL, &proc_doutsstring, &sysctl_string},
-	{KERN_NODENAME, "hostname", system_utsname.nodename, 64,
-	 0644, NULL, &proc_doutsstring, &sysctl_string},
-	{KERN_DOMAINNAME, "domainname", system_utsname.domainname, 64,
-	 0644, NULL, &proc_doutsstring, &sysctl_string},
-	{KERN_PANIC, "panic", &panic_timeout, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_CORE_PATTERN, "core_pattern", core_pattern, 64,
-	 0644, NULL, &proc_dostring, &sysctl_string},
-	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
-	 0600, NULL, &proc_dointvec_bset},
+	{
+		.ctl_name	= KERN_OSTYPE,
+		.procname	= "ostype",
+		.data		= system_utsname.sysname,
+		.maxlen		= 64,
+		.mode		= 0444,
+		.proc_handler	= &proc_doutsstring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_OSRELEASE,
+		.procname	= "osrelease",
+		.data		= system_utsname.release,
+		.maxlen		= 64,
+		.mode		= 0444,
+		.proc_handler	= &proc_doutsstring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_VERSION,
+		.procname	= "version",
+		.data		= system_utsname.version,
+		.maxlen		= 64,
+		.mode		= 0444,
+		.proc_handler	= &proc_doutsstring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_NODENAME,
+		.procname	= "hostname",
+		.data		= system_utsname.nodename,
+		.maxlen		= 64,
+		.mode		= 0644,
+		.proc_handler	= &proc_doutsstring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_DOMAINNAME,
+		.procname	= "domainname",
+		.data		= system_utsname.domainname,
+		.maxlen		= 64,
+		.mode		= 0644,
+		.proc_handler	= &proc_doutsstring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "panic",
+		.data		= &panic_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_CORE_USES_PID,
+		.procname	= "core_uses_pid",
+		.data		= &core_uses_pid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_CORE_PATTERN,
+		.procname	= "core_pattern",
+		.data		= core_pattern,
+		.maxlen		= 64,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_TAINTED,
+		.procname	= "tainted",
+		.data		= &tainted,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_CAP_BSET,
+		.procname	= "cap-bound",
+		.data		= &cap_bset,
+		.maxlen		= sizeof(kernel_cap_t),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec_bset,
+	},
 #ifdef CONFIG_BLK_DEV_INITRD
-	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_REALROOTDEV,
+		.procname	= "real-root-dev",
+		.data		= &real_root_dev,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #ifdef __sparc__
-	{KERN_SPARC_REBOOT, "reboot-cmd", reboot_command,
-	 256, 0644, NULL, &proc_dostring, &sysctl_string },
-	{KERN_SPARC_STOP_A, "stop-a", &stop_a_enabled, sizeof (int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_SPARC_REBOOT,
+		.procname	= "reboot-cmd",
+		.data		= reboot_command,
+		.maxlen		= 256,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
+	{
+		.ctl_name	= KERN_SPARC_STOP_A,
+		.procname	= "stop-a",
+		.data		= &stop_a_enabled,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
-	{KERN_PPC_POWERSAVE_NAP, "powersave-nap", &powersave_nap, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_PPC_L2CR, "l2cr", NULL, 0,
-	 0644, NULL, &proc_dol2crvec},
-#endif
-	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_PRINTK, "printk", &console_loglevel, 4*sizeof(int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
+		.procname	= "powersave-nap",
+		.data		= &powersave_nap,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_PPC_L2CR,
+		.procname	= "l2cr",
+		.mode		= 0644,
+		.proc_handler	= &proc_dol2crvec,
+	},
+#endif
+	{
+		.ctl_name	= KERN_CTLALTDEL,
+		.procname	= "ctrl-alt-del",
+		.data		= &C_A_D,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_PRINTK,
+		.procname	= "printk",
+		.data		= &console_loglevel,
+		.maxlen		= 4*sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef CONFIG_KMOD
-	{KERN_MODPROBE, "modprobe", &modprobe_path, 256,
-	 0644, NULL, &proc_dostring, &sysctl_string },
+	{
+		.ctl_name	= KERN_MODPROBE,
+		.procname	= "modprobe",
+		.data		= &modprobe_path,
+		.maxlen		= 256,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
 #endif
 #ifdef CONFIG_HOTPLUG
-	{KERN_HOTPLUG, "hotplug", &hotplug_path, 256,
-	 0644, NULL, &proc_dostring, &sysctl_string },
+	{
+		.ctl_name	= KERN_HOTPLUG,
+		.procname	= "hotplug",
+		.data		= &hotplug_path,
+		.maxlen		= 256,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
 #endif
 #ifdef CONFIG_CHR_DEV_SG
-	{KERN_SG_BIG_BUFF, "sg-big-buff", &sg_big_buff, sizeof (int),
-	 0444, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_SG_BIG_BUFF,
+		.procname	= "sg-big-buff",
+		.data		= &sg_big_buff,
+		.maxlen		= sizeof (int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
-	{KERN_ACCT, "acct", &acct_parm, 3*sizeof(int),
-	0644, NULL, &proc_dointvec},
-#endif
-	{KERN_RTSIGNR, "rtsig-nr", &nr_queued_signals, sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{KERN_RTSIGMAX, "rtsig-max", &max_queued_signals, sizeof(int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_ACCT,
+		.procname	= "acct",
+		.data		= &acct_parm,
+		.maxlen		= 3*sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+	{
+		.ctl_name	= KERN_RTSIGNR,
+		.procname	= "rtsig-nr",
+		.data		= &nr_queued_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_RTSIGMAX,
+		.procname	= "rtsig-max",
+		.data		= &max_queued_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef CONFIG_SYSVIPC
-	{KERN_SHMMAX, "shmmax", &shm_ctlmax, sizeof (size_t),
-	 0644, NULL, &proc_doulongvec_minmax},
-	{KERN_SHMALL, "shmall", &shm_ctlall, sizeof (size_t),
-	 0644, NULL, &proc_doulongvec_minmax},
-	{KERN_SHMMNI, "shmmni", &shm_ctlmni, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_MSGMAX, "msgmax", &msg_ctlmax, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_MSGMNI, "msgmni", &msg_ctlmni, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_MSGMNB, "msgmnb", &msg_ctlmnb, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_SEM, "sem", &sem_ctls, 4*sizeof (int),
-	 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= KERN_SHMMAX,
+		.procname	= "shmmax",
+		.data		= &shm_ctlmax,
+		.maxlen		= sizeof (size_t),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax,
+	},
+	{
+		.ctl_name	= KERN_SHMALL,
+		.procname	= "shmall",
+		.data		= &shm_ctlall,
+		.maxlen		= sizeof (size_t),
+		.mode		= 0644,
+		.proc_handler	= &proc_doulongvec_minmax,
+	},
+	{
+		.ctl_name	= KERN_SHMMNI,
+		.procname	= "shmmni",
+		.data		= &shm_ctlmni,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_MSGMAX,
+		.procname	= "msgmax",
+		.data		= &msg_ctlmax,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_MSGMNI,
+		.procname	= "msgmni",
+		.data		= &msg_ctlmni,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_MSGMNB,
+		.procname	=  "msgmnb",
+		.data		= &msg_ctlmnb,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_SEM,
+		.procname	= "sem",
+		.data		= &sem_ctls,
+		.maxlen		= 4*sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
-	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
-	 0644, NULL, &proc_dointvec},
-#endif	 
-	{KERN_CADPID, "cad_pid", &cad_pid, sizeof (int),
-	 0600, NULL, &proc_dointvec},
-	{KERN_MAX_THREADS, "threads-max", &max_threads, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{KERN_RANDOM, "random", NULL, 0, 0555, random_table},
-	{KERN_OVERFLOWUID, "overflowuid", &overflowuid, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
-	 &minolduid, &maxolduid},
-	{KERN_OVERFLOWGID, "overflowgid", &overflowgid, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
-	 &minolduid, &maxolduid},
+	{
+		.ctl_name	= KERN_SYSRQ,
+		.procname	= "sysrq",
+		.data		= &sysrq_enabled,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+	{
+		.ctl_name	= KERN_CADPID,
+		.procname	= "cad_pid",
+		.data		= &cad_pid,
+		.maxlen		= sizeof (int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_MAX_THREADS,
+		.procname	= "threads-max",
+		.data		= &max_threads,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_RANDOM,
+		.procname	= "random",
+		.mode		= 0555,
+		.child		= random_table,
+	},
+	{
+		.ctl_name	= KERN_OVERFLOWUID,
+		.procname	= "overflowuid",
+		.data		= &overflowuid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &minolduid,
+		.extra2		= &maxolduid,
+	},
+	{
+		.ctl_name	= KERN_OVERFLOWGID,
+		.procname	= "overflowgid",
+		.data		= &overflowgid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &minolduid,
+		.extra2		= &maxolduid,
+	},
 #ifdef CONFIG_ARCH_S390
 #ifdef CONFIG_MATHEMU
-	{KERN_IEEE_EMULATION_WARNINGS,"ieee_emulation_warnings",
-	 &sysctl_ieee_emulation_warnings,sizeof(int),0644,NULL,&proc_dointvec},
-#endif
-	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
-	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
-#endif
-	{KERN_PIDMAX, "pid_max", &pid_max, sizeof (int),
-	 0600, NULL, &proc_dointvec},
-	{KERN_PANIC_ON_OOPS,"panic_on_oops",
-	 &panic_on_oops,sizeof(int),0644,NULL,&proc_dointvec},
-	{0}
+	{
+		.ctl_name	= KERN_IEEE_EMULATION_WARNINGS,
+		.procname	= "ieee_emulation_warnings",
+		.data		= &sysctl_ieee_emulation_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+	{
+		.ctl_name	= KERN_S390_USER_DEBUG_LOGGING,
+		.procname	= "userprocess_debug",
+		.data		= &sysctl_userprocess_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
+	{
+		.ctl_name	= KERN_PIDMAX,
+		.procname	= "pid_max",
+		.data		= &pid_max,
+		.maxlen		= sizeof (int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_PANIC_ON_OOPS,
+		.procname	= "panic_on_oops",
+		.data		= &panic_on_oops,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 /* Constants for minimum and maximum testing in vm_table.
@@ -276,23 +561,60 @@
 
 
 static ctl_table vm_table[] = {
-	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
-	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
-	{VM_OVERCOMMIT_RATIO, "overcommit_ratio",
-	 &sysctl_overcommit_ratio, sizeof(sysctl_overcommit_ratio), 0644,
-	 NULL, &proc_dointvec},
-	{VM_PAGE_CLUSTER, "page-cluster", 
-	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
-	{VM_DIRTY_BACKGROUND, "dirty_background_ratio",
-	 &dirty_background_ratio, sizeof(dirty_background_ratio),
-	 0644, NULL, &proc_dointvec_minmax,  &sysctl_intvec, NULL,
-	 &zero, &one_hundred },
-	{VM_DIRTY_RATIO, "dirty_ratio", &vm_dirty_ratio,
-	 sizeof(vm_dirty_ratio), 0644, NULL, &proc_dointvec_minmax,
-	 &sysctl_intvec, NULL, &zero, &one_hundred },
-	{VM_DIRTY_WB_CS, "dirty_writeback_centisecs",
-	 &dirty_writeback_centisecs, sizeof(dirty_writeback_centisecs), 0644,
-	 NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	{
+		.ctl_name	= VM_OVERCOMMIT_MEMORY,
+		.procname	= "overcommit_memory",
+		.data		= &sysctl_overcommit_memory,
+		.maxlen		= sizeof(sysctl_overcommit_memory),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_OVERCOMMIT_RATIO,
+		.procname	= "overcommit_ratio",
+		.data		= &sysctl_overcommit_ratio,
+		.maxlen		= sizeof(sysctl_overcommit_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_PAGE_CLUSTER,
+		.procname	= "page-cluster", 
+		.data		= &page_cluster,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_DIRTY_BACKGROUND,
+		.procname	= "dirty_background_ratio",
+		.data		= &dirty_background_ratio,
+		.maxlen		= sizeof(dirty_background_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
+	{
+		.ctl_name	= VM_DIRTY_RATIO,
+		.procname	= "dirty_ratio",
+		.data		= &vm_dirty_ratio,
+		.maxlen		= sizeof(vm_dirty_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
+	{
+		.ctl_name	= VM_DIRTY_WB_CS,
+		.procname	= "dirty_writeback_centisecs",
+		.data		= &dirty_writeback_centisecs,
+		.maxlen		= sizeof(dirty_writeback_centisecs),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
 	 /* Here, we define the range of possible values for
 	    dirty_writeback_centisecs.
 
@@ -305,63 +627,158 @@
 	    some nicely documented throttling code in wb_kupdate().
 
 	    There is no maximum legal value for dirty_writeback. */
-	 &one , NULL},
-	{VM_DIRTY_EXPIRE_CS, "dirty_expire_centisecs",
-	 &dirty_expire_centisecs, sizeof(dirty_expire_centisecs), 0644,
-	 NULL, &proc_dointvec},
-	{ VM_NR_PDFLUSH_THREADS, "nr_pdflush_threads",
-	  &nr_pdflush_threads, sizeof nr_pdflush_threads,
-	  0444 /* read-only*/, NULL, &proc_dointvec},
-	{VM_SWAPPINESS, "swappiness", &vm_swappiness, sizeof(vm_swappiness),
-	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL, &zero,
-	 &one_hundred },
+	 	.extra1		= &one,
+	},
+	{
+		.ctl_name	= VM_DIRTY_EXPIRE_CS,
+		.procname	= "dirty_expire_centisecs",
+		.data		= &dirty_expire_centisecs,
+		.maxlen		= sizeof(dirty_expire_centisecs),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_NR_PDFLUSH_THREADS,
+		.procname	= "nr_pdflush_threads",
+		.data		= &nr_pdflush_threads,
+		.maxlen		= sizeof nr_pdflush_threads,
+		.mode		= 0444 /* read-only*/,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_SWAPPINESS,
+		.procname	= "swappiness",
+		.data		= &vm_swappiness,
+		.maxlen		= sizeof(vm_swappiness),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
 #ifdef CONFIG_HUGETLB_PAGE
-	 {VM_HUGETLB_PAGES, "nr_hugepages", &htlbpage_max, sizeof(int), 0644,
-	  NULL, &hugetlb_sysctl_handler},
-#endif
-	{VM_LOWER_ZONE_PROTECTION, "lower_zone_protection",
-	 &sysctl_lower_zone_protection, sizeof(sysctl_lower_zone_protection),
-	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL, &zero,
-	 NULL, },
-	{0}
+	 {
+		.ctl_name	= VM_HUGETLB_PAGES,
+		.procname	= "nr_hugepages",
+		.data		= &htlbpage_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &hugetlb_sysctl_handler,
+	 },
+#endif
+	{
+		.ctl_name	= VM_LOWER_ZONE_PROTECTION,
+		.procname	= "lower_zone_protection",
+		.data		= &sysctl_lower_zone_protection,
+		.maxlen		= sizeof(sysctl_lower_zone_protection),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table proc_table[] = {
-	{0}
+	{ .ctl_name = 0 }
 };
 
 static ctl_table fs_table[] = {
-	{FS_NRINODE, "inode-nr", &inodes_stat, 2*sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{FS_STATINODE, "inode-state", &inodes_stat, 7*sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{FS_NRFILE, "file-nr", &files_stat, 3*sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{FS_MAXFILE, "file-max", &files_stat.max_files, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{FS_DENTRY, "dentry-state", &dentry_stat, 6*sizeof(int),
-	 0444, NULL, &proc_dointvec},
-	{FS_OVERFLOWUID, "overflowuid", &fs_overflowuid, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
-	 &minolduid, &maxolduid},
-	{FS_OVERFLOWGID, "overflowgid", &fs_overflowgid, sizeof(int), 0644, NULL,
-	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
-	 &minolduid, &maxolduid},
-	{FS_LEASES, "leases-enable", &leases_enable, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{FS_DIR_NOTIFY, "dir-notify-enable", &dir_notify_enable,
-	 sizeof(int), 0644, NULL, &proc_dointvec},
-	{FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
-	 0644, NULL, &proc_dointvec},
-	{0}
+	{
+		.ctl_name	= FS_NRINODE,
+		.procname	= "inode-nr",
+		.data		= &inodes_stat,
+		.maxlen		= 2*sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_STATINODE,
+		.procname	= "inode-state",
+		.data		= &inodes_stat,
+		.maxlen		= 7*sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_NRFILE,
+		.procname	= "file-nr",
+		.data		= &files_stat,
+		.maxlen		= 3*sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_MAXFILE,
+		.procname	= "file-max",
+		.data		= &files_stat.max_files,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DENTRY,
+		.procname	= "dentry-state",
+		.data		= &dentry_stat,
+		.maxlen		= 6*sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_OVERFLOWUID,
+		.procname	= "overflowuid",
+		.data		= &fs_overflowuid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &minolduid,
+		.extra2		= &maxolduid,
+	},
+	{
+		.ctl_name	= FS_OVERFLOWGID,
+		.procname	= "overflowgid",
+		.data		= &fs_overflowgid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &minolduid,
+		.extra2		= &maxolduid,
+	},
+	{
+		.ctl_name	= FS_LEASES,
+		.procname	= "leases-enable",
+		.data		= &leases_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_DIR_NOTIFY,
+		.procname	= "dir-notify-enable",
+		.data		= &dir_notify_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_LEASE_TIME,
+		.procname	= "lease-break-time",
+		.data		= &lease_break_time,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 static ctl_table debug_table[] = {
-	{0}
+	{ .ctl_name = 0 }
 };
 
 static ctl_table dev_table[] = {
-	{0}
+	{ .ctl_name = 0 }
 };  
 
 extern void init_irq_proc (void);
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
