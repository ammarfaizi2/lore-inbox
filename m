Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUJKO0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUJKO0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJKO0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:26:48 -0400
Received: from smtp06.auna.com ([62.81.186.16]:29321 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269008AbUJKOWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:22:30 -0400
Date: Mon, 11 Oct 2004 14:22:26 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc4-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org> (from akpm@osdl.org on
	Mon Oct 11 12:25:02 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097504546l.6177l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.11, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/
> 
> - I wasn't going to do any -mm's until after 2.6.9 comes out.  But we need
>   this one so that people who have patches in -mm can check that I haven't
>   failed to push anything critical.  If there's a patch in here which you
>   think should be in 2.6.9, please let me know.
> 
> - I won't be taking any patches apart from 2.6.9 bugfixes, please.  So I
>   can concentrate on 2.6.9 bugfixes and so you can, too.
> 

Some warnings on build (some inherited from plain -rc4), and a patch still needed
below:

  CC      kernel/module.o
kernel/module.c: In function `who_is_doing_it':
kernel/module.c:1487: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result

  CC      fs/binfmt_elf.o
fs/binfmt_elf.c: In function `padzero':
fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
include/asm/uaccess.h: In function `create_elf_tables':
fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:758: warning: ignoring return value of `clear_user', declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1226: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result

  CC [M]  drivers/char/agp/backend.o
drivers/char/agp/backend.c: In function `agp_add_bridge':
drivers/char/agp/backend.c:281: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:577)
drivers/char/agp/backend.c: In function `agp_remove_bridge':
drivers/char/agp/backend.c:301: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)

  CC [M]  drivers/ieee1394/raw1394.o
include/asm/uaccess.h: In function `raw1394_read':
drivers/ieee1394/raw1394.c:446: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
  CC [M]  drivers/ieee1394/sbp2.o
In file included from drivers/ieee1394/sbp2.c:78:
drivers/ieee1394/sbp2.h:61:1: warning: "ABORT_TASK_SET" redefined
In file included from drivers/ieee1394/../scsi/scsi.h:31,
                 from drivers/ieee1394/sbp2.c:67:
include/scsi/scsi.h:255:1: warning: this is the location of the previous definition
In file included from drivers/ieee1394/sbp2.c:78:
drivers/ieee1394/sbp2.h:62:1: warning: "LOGICAL_UNIT_RESET" redefined
In file included from drivers/ieee1394/../scsi/scsi.h:31,
                 from drivers/ieee1394/sbp2.c:67:
include/scsi/scsi.h:267:1: warning: this is the location of the previous definition

  CC      drivers/scsi/aic7xxx/aic7xxx_osm.o
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_register_host':
drivers/scsi/aic7xxx/aic7xxx_osm.c:1746: warning: ignoring return value of `scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_osm.c: At top level:
drivers/scsi/aic7xxx/aic7xxx_osm.c:429: warning: 'aic7xxx' defined but not used
drivers/scsi/aic7xxx/aic7xxx_osm.c:435: warning: 'dummy_buffer' defined but not used
  CC      drivers/scsi/aic7xxx/aic7xxx_proc.o
  CC      drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c: In function `ahc_linux_pci_dev_probe':
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:224: warning: large integer implicitly truncated to unsigned type

  CC [M]  net/ipv4/netfilter/ip_tables.o
net/ipv4/netfilter/ip_tables.c: In function `do_replace':
net/ipv4/netfilter/ip_tables.c:1133: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result



This cleans the profile optimization, directly for -mm1:

diff -ruN linux-2.6.9-rc3-mm3/include/linux/profile.h linux-2.6.9-rc3-mm3-prof/include/linux/profile.h
--- linux-2.6.9-rc3-mm3/include/linux/profile.h	2004-09-30 09:46:41.000000000 +0200
+++ linux-2.6.9-rc3-mm3-prof/include/linux/profile.h	2004-10-07 19:41:36.254643765 +0200
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <asm/errno.h>
+#include <asm/atomic.h>
 
 #define CPU_PROFILING	1
 #define SCHED_PROFILING	2
@@ -17,8 +18,8 @@
 
 /* init basic kernel profiler */
 void __init profile_init(void);
-void profile_tick(int, struct pt_regs *);
-void profile_hit(int, void *);
+void FASTCALL(__profile_hit(void *));
+
 #ifdef CONFIG_PROC_FS
 void create_prof_cpu_mask(struct proc_dir_entry *);
 #else
@@ -101,6 +102,26 @@
 
 #endif /* CONFIG_PROFILING */
 
+static inline void profile_hit(int type, void *pc)
+{
+	extern int prof_on;
+	extern atomic_t *prof_buffer;
+
+	if (prof_on == type && prof_buffer)
+		__profile_hit(pc);
+}
+
+static inline void profile_tick(int type, struct pt_regs *regs)
+{
+	extern cpumask_t prof_cpu_mask;
+
+	if (type != CPU_PROFILING)
+		return;
+	profile_hook(regs);
+	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
+		profile_hit(type, (void *)profile_pc(regs));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PROFILE_H */
diff -ruN linux-2.6.9-rc3-mm3/kernel/profile.c linux-2.6.9-rc3-mm3-prof/kernel/profile.c
--- linux-2.6.9-rc3-mm3/kernel/profile.c	2004-10-07 14:45:02.176576637 +0200
+++ linux-2.6.9-rc3-mm3-prof/kernel/profile.c	2004-10-07 19:41:36.253643976 +0200
@@ -34,10 +34,10 @@
 #define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
-static atomic_t *prof_buffer;
+atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
-static int prof_on;
-static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+int prof_on;
+cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
@@ -284,14 +284,12 @@
 	up(&profile_flip_mutex);
 }
 
-void profile_hit(int type, void *__pc)
+void fastcall __profile_hit(void *__pc)
 {
 	unsigned long primary, secondary, flags, pc = (unsigned long)__pc;
 	int i, j, cpu;
 	struct profile_hit *hits;
 
-	if (prof_on != type || !prof_buffer)
-		return;
 	pc = min((pc - (unsigned long)_stext) >> prof_shift, prof_len - 1);
 	i = primary = (pc & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
 	secondary = (~(pc << 1) & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
@@ -381,25 +379,17 @@
 #define profile_flip_buffers()		do { } while (0)
 #define profile_discard_flip_buffers()	do { } while (0)
 
-inline void profile_hit(int type, void *__pc)
+void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
 
+	if (prof_on != type || !prof_buffer)
+		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
 #endif /* !CONFIG_SMP */
 
-void profile_tick(int type, struct pt_regs *regs)
-{
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
-	if (prof_on != type || !prof_buffer)
-		return;
-	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
-		profile_hit(type, (void *)profile_pc(regs));
-}
-
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


