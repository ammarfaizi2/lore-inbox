Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWG1DGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWG1DGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWG1DGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:06:40 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:53482 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751324AbWG1DGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:06:39 -0400
Message-Id: <200607280306.k6S36HKp007931@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/7] UML - Use ARRAY_SIZE more assiduously
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:06:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a bunch of missed ARRAY_SIZE opportunities.

Also, some formatting fixes in the affected areas of code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/mem.c	2006-07-13 14:00:34.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/mem.c	2006-07-13 14:00:37.000000000 -0400
@@ -223,8 +223,9 @@ void paging_init(void)
 
 	empty_zero_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
 	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
-	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
+	for(i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
+
 	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
Index: linux-2.6.17/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/chan_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/chan_kern.c	2006-07-13 14:04:47.000000000 -0400
@@ -544,7 +544,7 @@ static struct chan *parse_chan(struct li
 
 	ops = NULL;
 	data = NULL;
-	for(i = 0; i < sizeof(chan_table)/sizeof(chan_table[0]); i++){
+	for(i = 0; i < ARRAY_SIZE(chan_table); i++){
 		entry = &chan_table[i];
 		if(!strncmp(str, entry->key, strlen(entry->key))){
 			ops = entry->ops;
Index: linux-2.6.17/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/mconsole_kern.c	2006-07-12 10:47:56.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/mconsole_kern.c	2006-07-13 14:05:07.000000000 -0400
@@ -497,7 +497,7 @@ static void mconsole_get_config(int (*ge
 	}
 
 	error = NULL;
-	size = sizeof(default_buf)/sizeof(default_buf[0]);
+	size = ARRAY_SIZE(default_buf);
 	buf = default_buf;
 
 	while(1){
Index: linux-2.6.17/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/mconsole_user.c	2006-07-12 10:47:56.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/mconsole_user.c	2006-07-13 14:15:24.000000000 -0400
@@ -16,6 +16,7 @@
 #include "user.h"
 #include "mconsole.h"
 #include "umid.h"
+#include "user_util.h"
 
 static struct mconsole_command commands[] = {
 	/* With uts namespaces, uts information becomes process-specific, so
@@ -65,14 +66,14 @@ static struct mconsole_command *mconsole
 	struct mconsole_command *cmd;
 	int i;
 
-	for(i=0;i<sizeof(commands)/sizeof(commands[0]);i++){
+	for(i = 0; i < ARRAY_SIZE(commands); i++){
 		cmd = &commands[i];
 		if(!strncmp(req->request.data, cmd->command, 
 			    strlen(cmd->command))){
-			return(cmd);
+			return cmd;
 		}
 	}
-	return(NULL);
+	return NULL;
 }
 
 #define MIN(a,b) ((a)<(b) ? (a):(b))
Index: linux-2.6.17/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/pcap_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/pcap_kern.c	2006-07-13 14:06:19.000000000 -0400
@@ -76,7 +76,7 @@ int pcap_setup(char *str, char **mac_out
 	if(host_if != NULL)
 		init->host_if = host_if;
 
-	for(i = 0; i < sizeof(options)/sizeof(options[0]); i++){
+	for(i = 0; i < ARRAY_SIZE(options); i++){
 		if(options[i] == NULL)
 			continue;
 		if(!strcmp(options[i], "promisc"))
Index: linux-2.6.17/arch/um/kernel/reboot.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/reboot.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/reboot.c	2006-07-13 14:07:02.000000000 -0400
@@ -22,7 +22,7 @@ static void kill_idlers(int me)
 	struct task_struct *p;
 	int i;
 
-	for(i = 0; i < sizeof(idle_threads)/sizeof(idle_threads[0]); i++){
+	for(i = 0; i < ARRAY_SIZE(idle_threads); i++){
 		p = idle_threads[i];
 		if((p != NULL) && (p->thread.mode.tt.extern_pid != me))
 			os_kill_process(p->thread.mode.tt.extern_pid, 0);
@@ -62,14 +62,3 @@ void machine_halt(void)
 {
 	machine_power_off();
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.17/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tlb.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/tlb.c	2006-07-13 14:07:26.000000000 -0400
@@ -137,10 +137,11 @@ void fix_range_common(struct mm_struct *
         int r, w, x;
         struct host_vm_op ops[1];
         void *flush = NULL;
-        int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
+        int op_index = -1, last_op = ARRAY_SIZE(ops) - 1;
         int ret = 0;
 
-        if(mm == NULL) return;
+        if(mm == NULL)
+		return;
 
         ops[0].type = NONE;
         for(addr = start_addr; addr < end_addr && !ret;){
Index: linux-2.6.17/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/mem.c	2006-07-12 12:14:37.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/mem.c	2006-07-14 10:19:36.000000000 -0400
@@ -114,14 +114,14 @@ static void which_tmpdir(void)
 	}
 
 	while(1){
-		found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), ' ');
+		found = next(fd, buf, ARRAY_SIZE(buf), ' ');
 		if(found != 1)
 			break;
 
 		if(!strncmp(buf, "/dev/shm", strlen("/dev/shm")))
 			goto found;
 
-		found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), '\n');
+		found = next(fd, buf, ARRAY_SIZE(buf), '\n');
 		if(found != 1)
 			break;
 	}
@@ -135,7 +135,7 @@ err:
 	return;
 
 found:
-	found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), ' ');
+	found = next(fd, buf, ARRAY_SIZE(buf), ' ');
 	if(found != 1)
 		goto err;
 
Index: linux-2.6.17/arch/um/sys-i386/bugs.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/bugs.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/bugs.c	2006-07-13 14:15:11.000000000 -0400
@@ -13,6 +13,7 @@
 #include "sysdep/ptrace.h"
 #include "task.h"
 #include "os.h"
+#include "user_util.h"
 
 #define MAXTOKEN 64
 
@@ -104,17 +105,17 @@ int cpu_feature(char *what, char *buf, i
 static int check_cpu_flag(char *feature, int *have_it)
 {
 	char buf[MAXTOKEN], c;
-	int fd, len = sizeof(buf)/sizeof(buf[0]);
+	int fd, len = ARRAY_SIZE(buf);
 
 	printk("Checking for host processor %s support...", feature);
 	fd = os_open_file("/proc/cpuinfo", of_read(OPENFLAGS()), 0);
 	if(fd < 0){
 		printk("Couldn't open /proc/cpuinfo, err = %d\n", -fd);
-		return(0);
+		return 0;
 	}
 
 	*have_it = 0;
-	if(!find_cpuinfo_line(fd, "flags", buf, sizeof(buf) / sizeof(buf[0])))
+	if(!find_cpuinfo_line(fd, "flags", buf, ARRAY_SIZE(buf)))
 		goto out;
 
 	c = token(fd, buf, len - 1, ' ');
@@ -138,7 +139,7 @@ static int check_cpu_flag(char *feature,
 	if(*have_it == 0) printk("No\n");
 	else if(*have_it == 1) printk("Yes\n");
 	os_close_file(fd);
-	return(1);
+	return 1;
 }
 
 #if 0 /* This doesn't work in tt mode, plus it's causing compilation problems
Index: linux-2.6.17/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/ldt.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/ldt.c	2006-07-13 14:10:54.000000000 -0400
@@ -424,9 +424,8 @@ void ldt_get_host_info(void)
 			size++;
 	}
 
-	if(size < sizeof(dummy_list)/sizeof(dummy_list[0])) {
+	if(size < ARRAY_SIZE(dummy_list))
 		host_ldt_entries = dummy_list;
-	}
 	else {
 		size = (size + 1) * sizeof(dummy_list[0]);
 		host_ldt_entries = (short *)kmalloc(size, GFP_KERNEL);
Index: linux-2.6.17/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.17.orig/arch/um/sys-i386/ptrace_user.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/sys-i386/ptrace_user.c	2006-07-13 14:15:26.000000000 -0400
@@ -15,6 +15,7 @@
 #include "user.h"
 #include "os.h"
 #include "uml-config.h"
+#include "user_util.h"
 
 int ptrace_getregs(long pid, unsigned long *regs_out)
 {
@@ -51,7 +52,7 @@ static void write_debugregs(int pid, uns
 	int nregs, i;
 
 	dummy = NULL;
-	nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
+	nregs = ARRAY_SIZE(dummy->u_debugreg);
 	for(i = 0; i < nregs; i++){
 		if((i == 4) || (i == 5)) continue;
 		if(ptrace(PTRACE_POKEUSR, pid, &dummy->u_debugreg[i],
@@ -68,7 +69,7 @@ static void read_debugregs(int pid, unsi
 	int nregs, i;
 
 	dummy = NULL;
-	nregs = sizeof(dummy->u_debugreg)/sizeof(dummy->u_debugreg[0]);
+	nregs = ARRAY_SIZE(dummy->u_debugreg);
 	for(i = 0; i < nregs; i++){
 		regs[i] = ptrace(PTRACE_PEEKUSR, pid,
 				 &dummy->u_debugreg[i], 0);

