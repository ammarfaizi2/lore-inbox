Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTDRXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDRXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:08:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263298AbTDRXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:08:20 -0400
Subject: [PATCH][2.5.67][TRIVIAL] eliminate a few compiler warnings
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050708007.29162.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Apr 2003 16:20:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch eliminates 20 or so compiler warnings.  It is a mix of
removing unused variables and matching up type definitions.

I don't have much of the hardware touched by the hardware, so I can't
tell if the patch breaks anything.

Andy

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1103  -> 1.1104 
#	drivers/char/isicom.c	1.13    -> 1.14   
#	arch/i386/kernel/cpu/cpufreq/powernow-k6.c	1.14    -> 1.15   
#	drivers/scsi/advansys.c	1.28    -> 1.29   
#	drivers/scsi/nsp32.c	1.8     -> 1.9    
#	drivers/char/generic_serial.c	1.8     -> 1.9    
#	drivers/char/ipmi/ipmi_msghandler.c	1.4     -> 1.5    
#	drivers/ide/pci/hpt366.c	1.17    -> 1.18   
#	drivers/block/paride/pf.c	1.39    -> 1.40   
#	drivers/cdrom/cdu31a.c	1.35    -> 1.36   
#	arch/i386/kernel/cpu/cpufreq/longrun.c	1.13    -> 1.14   
#	drivers/block/paride/pd.c	1.48    -> 1.49   
#	drivers/block/paride/pcd.c	1.33    -> 1.34   
#	drivers/net/hamradio/baycom_epp.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/18	andyp@andyp.pdx.osdl.net	1.1104
# Eliminate several compile-time warnings.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/cpufreq/longrun.c
b/arch/i386/kernel/cpu/cpufreq/longrun.c
--- a/arch/i386/kernel/cpu/cpufreq/longrun.c	Fri Apr 18 16:07:40 2003
+++ b/arch/i386/kernel/cpu/cpufreq/longrun.c	Fri Apr 18 16:07:40 2003
@@ -224,7 +224,6 @@
 static int longrun_cpu_init(struct cpufreq_policy *policy)
 {
 	int                     result = 0;
-	struct cpuinfo_x86 *c = cpu_data;
 
 	/* capability check */
 	if (policy->cpu != 0)
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Fri Apr 18 16:07:40
2003
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Fri Apr 18 16:07:40
2003
@@ -142,7 +142,6 @@
 
 static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpuinfo_x86 *c = cpu_data;
 	unsigned int i;
 
 	if (policy->cpu != 0)
diff -Nru a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
--- a/drivers/block/paride/pcd.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/block/paride/pcd.c	Fri Apr 18 16:07:40 2003
@@ -761,7 +761,7 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	spin_lock_irqsave(&pcd_lock, saved_flags);
 	end_request(pcd_req, success);
diff -Nru a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/block/paride/pd.c	Fri Apr 18 16:07:40 2003
@@ -757,7 +757,7 @@
 
 static int pd_next_buf(void)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	pd_count--;
 	pd_run--;
@@ -777,7 +777,7 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	spin_lock_irqsave(&pd_lock, saved_flags);
 	end_request(pd_req, success);
diff -Nru a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
--- a/drivers/block/paride/pf.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/block/paride/pf.c	Fri Apr 18 16:07:40 2003
@@ -812,7 +812,7 @@
 
 static int pf_next_buf(void)
 {
-	long saved_flags;
+	unsigned long saved_flags;
 
 	pf_count--;
 	pf_run--;
@@ -832,7 +832,8 @@
 
 static inline void next_request(int success)
 {
-	long saved_flags;
+	unsigned long saved_flags;
+
 	spin_lock_irqsave(&pf_spin_lock, saved_flags);
 	end_request(pf_req, success);
 	pf_busy = 0;
diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/cdrom/cdu31a.c	Fri Apr 18 16:07:40 2003
@@ -451,7 +451,7 @@
  */
 static int scd_reset(struct cdrom_device_info *cdi)
 {
-	int retry_count;
+	unsigned long retry_count;
 
 	reset_drive();
 
@@ -712,7 +712,7 @@
 {
 	unsigned char res_reg[12];
 	unsigned int res_size;
-	unsigned int retry_count;
+	unsigned long retry_count;
 
 
 	printk("cdu31a: Resetting drive on error\n");
@@ -740,7 +740,7 @@
  */
 static int write_params(unsigned char *params, int num_params)
 {
-	unsigned int retry_count;
+	unsigned long retry_count;
 
 
 	retry_count = SONY_READY_RETRIES;
@@ -772,7 +772,7 @@
 {
 	unsigned char a, b;
 	int i;
-	unsigned int retry_count;
+	unsigned long retry_count;
 
 
 	while (handle_sony_cd_attention());
@@ -900,7 +900,7 @@
 	       unsigned int num_params,
 	       unsigned char *result_buffer, unsigned int *result_size)
 {
-	unsigned int retry_count;
+	unsigned long retry_count;
 	int num_retries;
 	int recursive_call;
 	unsigned long flags;
@@ -1148,7 +1148,7 @@
 {
 	unsigned char params[6];
 	unsigned int read_size;
-	unsigned int retry_count;
+	unsigned long retry_count;
 
 
 #if DEBUG
@@ -1339,7 +1339,7 @@
 		unsigned int nblocks,
 		unsigned char res_reg[], int *res_size)
 {
-	unsigned int retry_count;
+	unsigned long retry_count;
 	unsigned int bytesleft;
 	unsigned int offset;
 	unsigned int skip;
@@ -2372,7 +2372,7 @@
 static void
 read_audio_data(char *buffer, unsigned char res_reg[], int *res_size)
 {
-	unsigned int retry_count;
+	unsigned long retry_count;
 	int result_read;
 
 
@@ -3206,7 +3206,7 @@
 get_drive_configuration(unsigned short base_io,
 			unsigned char res_reg[], unsigned int *res_size)
 {
-	int retry_count;
+	unsigned long retry_count;
 
 
 	/* Set the base address */
@@ -3308,6 +3308,7 @@
 	int i;
 	int drive_found;
 	int tmp_irq;
+	void *ret;
 
 
 	/*
@@ -3344,7 +3345,10 @@
 		i = 0;
 		while ((cdu31a_addresses[i].base != 0)
 		       && (!drive_found)) {
-			if (check_region(cdu31a_addresses[i].base, 4)) {
+			ret = request_region(cdu31a_addresses[i].base,
+					     4,
+					     "cdu31a");
+			if (!ret) {
 				i++;
 				continue;
 			}
@@ -3363,9 +3367,6 @@
 	}
 
 	if (!drive_found)
-		goto errout3;
-
-	if (!request_region(cdu31a_port, 4, "cdu31a"))
 		goto errout3;
 
 	if (register_blkdev(MAJOR_NR, "cdu31a"))
diff -Nru a/drivers/char/generic_serial.c
b/drivers/char/generic_serial.c
--- a/drivers/char/generic_serial.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/char/generic_serial.c	Fri Apr 18 16:07:40 2003
@@ -347,7 +347,7 @@
 static int gs_wait_tx_flushed (void * ptr, int timeout) 
 {
 	struct gs_port *port = ptr;
-	long end_jiffies;
+	unsigned long end_jiffies;
 	int jiffies_to_transmit, charsleft = 0, rv = 0;
 	int rcib;
 
diff -Nru a/drivers/char/ipmi/ipmi_msghandler.c
b/drivers/char/ipmi/ipmi_msghandler.c
--- a/drivers/char/ipmi/ipmi_msghandler.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/char/ipmi/ipmi_msghandler.c	Fri Apr 18 16:07:40 2003
@@ -174,7 +174,7 @@
 int
 ipmi_register_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
+	unsigned long flags;
 	int rv = -EBUSY;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
@@ -193,7 +193,7 @@
 int
 ipmi_unregister_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
+	unsigned long flags;
 	int rv = -EINVAL;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
@@ -1023,7 +1023,7 @@
 	int              rv;
 	ipmi_smi_t       new_intf;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long     flags;
 
 
 	/* Make sure the driver is actually initialized, this handles
diff -Nru a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/char/isicom.c	Fri Apr 18 16:07:40 2003
@@ -159,12 +159,12 @@
 								
 			inw(base+0x8);
 			
-			for(i=jiffies+HZ/100;time_before(jiffies, i););
+			for(i=jiffies+HZ/100;time_before(jiffies, (unsigned long) i););
 				
 			outw(0,base+0x8); /* Reset */
 			
 			for(j=1;j<=3;j++) {
-				for(i=jiffies+HZ;time_before(jiffies, i););
+				for(i=jiffies+HZ;time_before(jiffies, (unsigned long) i););
 				printk(".");
 			}	
 			signature=(inw(base+0x4)) & 0xff;	
diff -Nru a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/ide/pci/hpt366.c	Fri Apr 18 16:07:40 2003
@@ -1105,7 +1105,6 @@
 		    (findev->device == dev->device) &&
 		    ((findev->devfn - dev->devfn) == 1) &&
 		    (PCI_FUNC(findev->devfn) & 1)) {
-			u8 irq = 0, irq2 = 0;
 			if (findev->irq != dev->irq) {
 				/* FIXME: we need a core pci_set_interrupt() */
 				findev->irq = dev->irq;
diff -Nru a/drivers/net/hamradio/baycom_epp.c
b/drivers/net/hamradio/baycom_epp.c
--- a/drivers/net/hamradio/baycom_epp.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/net/hamradio/baycom_epp.c	Fri Apr 18 16:07:40 2003
@@ -376,7 +376,6 @@
 	char portarg[16];
         char *argv[] = { eppconfig_path, "-s", "-p", portarg, "-m",
modearg,
 			 NULL };
-        int ret;
 
 	/* set up arguments */
 	sprintf(modearg, "%sclk,%smodem,fclk=%d,bps=%d,divider=%d%s,extstat",
@@ -1164,7 +1163,6 @@
 static int baycom_ioctl(struct net_device *dev, struct ifreq *ifr, int
cmd)
 {
 	struct baycom_state *bc;
-	struct baycom_ioctl bi;
 	struct hdlcdrv_ioctl hi;
 
 	baycom_paranoia_check(dev, "baycom_ioctl", -EINVAL);
diff -Nru a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
--- a/drivers/scsi/advansys.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/scsi/advansys.c	Fri Apr 18 16:07:40 2003
@@ -8370,7 +8370,6 @@
     int                    totlen;
     int                    len;
     int                    chip_scsi_id;
-    int                    i;
 
     boardp = ASC_BOARDP(shp);
 
diff -Nru a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
--- a/drivers/scsi/nsp32.c	Fri Apr 18 16:07:40 2003
+++ b/drivers/scsi/nsp32.c	Fri Apr 18 16:07:40 2003
@@ -2418,7 +2418,6 @@
 static void nsp32_msgout_occur(nsp32_hw_data *data)
 {
 	unsigned int base = data->BaseAddress;
-	unsigned short command;
 	long new_sgtp;
 	int i;
 	



