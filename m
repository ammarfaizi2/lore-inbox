Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAOUyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAOUyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWAOUyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:54:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20117 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750798AbWAOUyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:54:08 -0500
Date: Sun, 15 Jan 2006 21:54:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] let sysfs attributes show up
Message-ID: <Pine.LNX.4.61.0601152151520.4240@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,


I have been wondering why so many sysfs attributes are not visible, e.g. 
those of cdrom.c. What do people think about making some attributes 
visible? I composed a patch in the meantime...

Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>

diff --fast -Ndpru linux-2.6.15~/arch/ia64/sn/kernel/xpc_main.c linux-2.6.15/arch/ia64/sn/kernel/xpc_main.c
--- linux-2.6.15~/arch/ia64/sn/kernel/xpc_main.c	2006-01-12 20:58:15.000000000 +0100
+++ linux-2.6.15/arch/ia64/sn/kernel/xpc_main.c	2006-01-14 18:30:08.703054000 +0100
@@ -1377,11 +1377,11 @@ MODULE_AUTHOR("Silicon Graphics, Inc.");
 MODULE_DESCRIPTION("Cross Partition Communication (XPC) support");
 MODULE_LICENSE("GPL");
 
-module_param(xpc_hb_interval, int, 0);
+module_param(xpc_hb_interval, int, 0644);
 MODULE_PARM_DESC(xpc_hb_interval, "Number of seconds between "
 		"heartbeat increments.");
 
-module_param(xpc_hb_check_interval, int, 0);
+module_param(xpc_hb_check_interval, int, 0644);
 MODULE_PARM_DESC(xpc_hb_check_interval, "Number of seconds between "
 		"heartbeat checks.");
 
diff --fast -Ndpru linux-2.6.15~/drivers/block/floppy.c linux-2.6.15/drivers/block/floppy.c
--- linux-2.6.15~/drivers/block/floppy.c	2006-01-12 23:39:58.000000000 +0100
+++ linux-2.6.15/drivers/block/floppy.c	2006-01-14 18:30:08.743054000 +0100
@@ -4637,9 +4637,9 @@ void cleanup_module(void)
 	wait_for_completion(&device_release);
 }
 
-module_param(floppy, charp, 0);
-module_param(FLOPPY_IRQ, int, 0);
-module_param(FLOPPY_DMA, int, 0);
+module_param(floppy, charp, 0444);
+module_param(FLOPPY_IRQ, int, 0444);
+module_param(FLOPPY_DMA, int, 0444);
 MODULE_AUTHOR("Alain L. Knaff");
 MODULE_SUPPORTED_DEVICE("fd");
 MODULE_LICENSE("GPL");
diff --fast -Ndpru linux-2.6.15~/drivers/block/loop.c linux-2.6.15/drivers/block/loop.c
--- linux-2.6.15~/drivers/block/loop.c	2006-01-12 23:39:58.000000000 +0100
+++ linux-2.6.15/drivers/block/loop.c	2006-01-14 18:30:08.743054000 +0100
@@ -1210,7 +1210,7 @@ static struct block_device_operations lo
 /*
  * And now the modules code and kernel interface.
  */
-module_param(max_loop, int, 0);
+module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
diff --fast -Ndpru linux-2.6.15~/drivers/cdrom/cdrom.c linux-2.6.15/drivers/cdrom/cdrom.c
--- linux-2.6.15~/drivers/cdrom/cdrom.c	2006-01-12 23:40:10.000000000 +0100
+++ linux-2.6.15/drivers/cdrom/cdrom.c	2006-01-14 18:30:08.773054000 +0100
@@ -296,12 +296,12 @@ static int lockdoor = 0;
 static int check_media_type;
 /* automatically restart mrw format */
 static int mrw_format_restart = 1;
-module_param(debug, bool, 0);
-module_param(autoclose, bool, 0);
-module_param(autoeject, bool, 0);
-module_param(lockdoor, bool, 0);
-module_param(check_media_type, bool, 0);
-module_param(mrw_format_restart, bool, 0);
+module_param(debug, bool, 0644);
+module_param(autoclose, bool, 0644);
+module_param(autoeject, bool, 0644);
+module_param(lockdoor, bool, 0644);
+module_param(check_media_type, bool, 0644);
+module_param(mrw_format_restart, bool, 0644);
 
 static DEFINE_SPINLOCK(cdrom_lock);
 
diff --fast -Ndpru linux-2.6.15~/drivers/char/hangcheck-timer.c linux-2.6.15/drivers/char/hangcheck-timer.c
--- linux-2.6.15~/drivers/char/hangcheck-timer.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/char/hangcheck-timer.c	2006-01-14 18:30:08.783054000 +0100
@@ -62,13 +62,13 @@ static int hangcheck_reboot;  /* Default
 static int hangcheck_dump_tasks;  /* Defaults to not dumping SysRQ T */
 
 /* options - modular */
-module_param(hangcheck_tick, int, 0);
+module_param(hangcheck_tick, int, 0644);
 MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
-module_param(hangcheck_margin, int, 0);
+module_param(hangcheck_margin, int, 0644);
 MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the driver will fire.");
-module_param(hangcheck_reboot, int, 0);
+module_param(hangcheck_reboot, int, 0644);
 MODULE_PARM_DESC(hangcheck_reboot, "If nonzero, the machine will reboot when the timer margin is exceeded.");
-module_param(hangcheck_dump_tasks, int, 0);
+module_param(hangcheck_dump_tasks, int, 0644);
 MODULE_PARM_DESC(hangcheck_dump_tasks, "If nonzero, the machine will dump the system task state when the timer margin is exceeded.");
 
 MODULE_AUTHOR("Oracle");
diff --fast -Ndpru linux-2.6.15~/drivers/ide/legacy/ide-cs.c linux-2.6.15/drivers/ide/legacy/ide-cs.c
--- linux-2.6.15~/drivers/ide/legacy/ide-cs.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/ide/legacy/ide-cs.c	2006-01-14 18:30:08.803054000 +0100
@@ -62,7 +62,7 @@ MODULE_AUTHOR("David Hinds <dahinds@user
 MODULE_DESCRIPTION("PCMCIA ATA/IDE card driver");
 MODULE_LICENSE("Dual MPL/GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0)
+#define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0444)
 
 #ifdef PCMCIA_DEBUG
 INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
diff --fast -Ndpru linux-2.6.15~/drivers/input/mousedev.c linux-2.6.15/drivers/input/mousedev.c
--- linux-2.6.15~/drivers/input/mousedev.c	2006-01-14 18:29:31.000000000 +0100
+++ linux-2.6.15/drivers/input/mousedev.c	2006-01-14 18:30:08.803054000 +0100
@@ -44,15 +44,15 @@ module_param(swap_buttons, uint, 0644);
 MODULE_PARM_DESC(swap_buttons, "Swap left and right mouse buttons");
 
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
-module_param(xres, uint, 0);
+module_param(xres, uint, 0644);
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
-module_param(yres, uint, 0);
+module_param(yres, uint, 0644);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
 static unsigned tap_time = 200;
-module_param(tap_time, uint, 0);
+module_param(tap_time, uint, 0644);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
 struct mousedev_hw_data {
diff --fast -Ndpru linux-2.6.15~/drivers/net/8139too.c linux-2.6.15/drivers/net/8139too.c
--- linux-2.6.15~/drivers/net/8139too.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/net/8139too.c	2006-01-14 18:30:08.833054000 +0100
@@ -606,10 +606,10 @@ MODULE_DESCRIPTION ("RealTek RTL-8139 Fa
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-module_param(multicast_filter_limit, int, 0);
-module_param_array(media, int, NULL, 0);
-module_param_array(full_duplex, int, NULL, 0);
-module_param(debug, int, 0);
+module_param(multicast_filter_limit, int, 0644);
+module_param_array(media, int, NULL, 0644);
+module_param_array(full_duplex, int, NULL, 0644);
+module_param(debug, int, 0644);
 MODULE_PARM_DESC (debug, "8139too bitmapped message enable number");
 MODULE_PARM_DESC (multicast_filter_limit, "8139too maximum number of filtered multicast addresses");
 MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
diff --fast -Ndpru linux-2.6.15~/drivers/net/dummy.c linux-2.6.15/drivers/net/dummy.c
--- linux-2.6.15~/drivers/net/dummy.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/net/dummy.c	2006-01-14 18:30:08.843054000 +0100
@@ -94,7 +94,7 @@ static struct net_device_stats *dummy_ge
 static struct net_device **dummies;
 
 /* Number of dummy devices to be set up by this module. */
-module_param(numdummies, int, 0);
+module_param(numdummies, int, 0444);
 MODULE_PARM_DESC(numdummies, "Number of dummy pseudo devices");
 
 static int __init dummy_init_one(int index)
diff --fast -Ndpru linux-2.6.15~/drivers/net/netconsole.c linux-2.6.15/drivers/net/netconsole.c
--- linux-2.6.15~/drivers/net/netconsole.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/net/netconsole.c	2006-01-14 18:30:08.853054000 +0100
@@ -51,7 +51,7 @@ MODULE_DESCRIPTION("Console driver for n
 MODULE_LICENSE("GPL");
 
 static char config[256];
-module_param_string(netconsole, config, 256, 0);
+module_param_string(netconsole, config, 256, 0400);
 MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
 
 static struct netpoll np = {
diff --fast -Ndpru linux-2.6.15~/drivers/net/pcnet32.c linux-2.6.15/drivers/net/pcnet32.c
--- linux-2.6.15~/drivers/net/pcnet32.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/drivers/net/pcnet32.c	2006-01-14 18:30:08.873054000 +0100
@@ -2474,22 +2474,22 @@ static int debug = -1;
 static int tx_start_pt = -1;
 static int pcnet32_have_pci;
 
-module_param(debug, int, 0);
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, DRV_NAME " debug level");
-module_param(max_interrupt_work, int, 0);
+module_param(max_interrupt_work, int, 0444);
 MODULE_PARM_DESC(max_interrupt_work, DRV_NAME " maximum events handled per interrupt");
-module_param(rx_copybreak, int, 0);
+module_param(rx_copybreak, int, 0444);
 MODULE_PARM_DESC(rx_copybreak, DRV_NAME " copy breakpoint for copy-only-tiny-frames");
-module_param(tx_start_pt, int, 0);
+module_param(tx_start_pt, int, 0444);
 MODULE_PARM_DESC(tx_start_pt, DRV_NAME " transmit start point (0-3)");
-module_param(pcnet32vlb, int, 0);
+module_param(pcnet32vlb, int, 0444);
 MODULE_PARM_DESC(pcnet32vlb, DRV_NAME " Vesa local bus (VLB) support (0/1)");
-module_param_array(options, int, NULL, 0);
+module_param_array(options, int, NULL, 0444);
 MODULE_PARM_DESC(options, DRV_NAME " initial option setting(s) (0-15)");
-module_param_array(full_duplex, int, NULL, 0);
+module_param_array(full_duplex, int, NULL, 0444);
 MODULE_PARM_DESC(full_duplex, DRV_NAME " full duplex setting(s) (1)");
 /* Module Parameter for HomePNA cards added by Patrick Simmons, 2004 */
-module_param_array(homepna, int, NULL, 0);
+module_param_array(homepna, int, NULL, 0444);
 MODULE_PARM_DESC(homepna, DRV_NAME " mode for 79C978 cards (1 for HomePNA, 0 for Ethernet, default Ethernet");
 
 MODULE_AUTHOR("Thomas Bogendoerfer");
diff --fast -Ndpru linux-2.6.15~/fs/afs/main.c linux-2.6.15/fs/afs/main.c
--- linux-2.6.15~/fs/afs/main.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/fs/afs/main.c	2006-01-14 18:30:08.903054000 +0100
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL");
 
 static char *rootcell;
 
-module_param(rootcell, charp, 0);
+module_param(rootcell, charp, 0400);
 MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
 
 
diff --fast -Ndpru linux-2.6.15~/fs/cifs/cifsfs.c linux-2.6.15/fs/cifs/cifsfs.c
--- linux-2.6.15~/fs/cifs/cifsfs.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/fs/cifs/cifsfs.c	2006-01-14 18:30:08.943054000 +0100
@@ -63,16 +63,16 @@ struct task_struct * oplockThread = NULL
 extern struct task_struct * dnotifyThread; /* remove sparse warning */
 struct task_struct * dnotifyThread = NULL;
 unsigned int CIFSMaxBufSize = CIFS_MAX_MSGSIZE;
-module_param(CIFSMaxBufSize, int, 0);
+module_param(CIFSMaxBufSize, int, 0444);
 MODULE_PARM_DESC(CIFSMaxBufSize,"Network buffer size (not including header). Default: 16384 Range: 8192 to 130048");
 unsigned int cifs_min_rcv = CIFS_MIN_RCV_POOL;
-module_param(cifs_min_rcv, int, 0);
+module_param(cifs_min_rcv, int, 0444);
 MODULE_PARM_DESC(cifs_min_rcv,"Network buffers in pool. Default: 4 Range: 1 to 64");
 unsigned int cifs_min_small = 30;
-module_param(cifs_min_small, int, 0);
+module_param(cifs_min_small, int, 0444);
 MODULE_PARM_DESC(cifs_min_small,"Small network buffers in pool. Default: 30 Range: 2 to 256");
 unsigned int cifs_max_pending = CIFS_MAX_REQ;
-module_param(cifs_max_pending, int, 0);
+module_param(cifs_max_pending, int, 0444);
 MODULE_PARM_DESC(cifs_max_pending,"Simultaneous requests to server. Default: 50 Range: 2 to 256");
 
 static DECLARE_COMPLETION(cifs_oplock_exited);
diff --fast -Ndpru linux-2.6.15~/fs/jfs/jfs_txnmgr.c linux-2.6.15/fs/jfs/jfs_txnmgr.c
--- linux-2.6.15~/fs/jfs/jfs_txnmgr.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/fs/jfs/jfs_txnmgr.c	2006-01-14 18:30:08.973054000 +0100
@@ -94,12 +94,12 @@ static struct {
 #endif
 
 static int nTxBlock = -1;	/* number of transaction blocks */
-module_param(nTxBlock, int, 0);
+module_param(nTxBlock, int, 0444);
 MODULE_PARM_DESC(nTxBlock,
 		 "Number of transaction blocks (max:65536)");
 
 static int nTxLock = -1;	/* number of transaction locks */
-module_param(nTxLock, int, 0);
+module_param(nTxLock, int, 0444);
 MODULE_PARM_DESC(nTxLock,
 		 "Number of transaction locks (max:65536)");
 
diff --fast -Ndpru linux-2.6.15~/fs/jfs/super.c linux-2.6.15/fs/jfs/super.c
--- linux-2.6.15~/fs/jfs/super.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/fs/jfs/super.c	2006-01-14 18:30:08.983054000 +0100
@@ -51,7 +51,7 @@ static struct file_system_type jfs_fs_ty
 
 #define MAX_COMMIT_THREADS 64
 static int commit_threads = 0;
-module_param(commit_threads, int, 0);
+module_param(commit_threads, int, 0444);
 MODULE_PARM_DESC(commit_threads, "Number of commit threads");
 
 int jfs_stop_threads;
diff --fast -Ndpru linux-2.6.15~/fs/ntfs/super.c linux-2.6.15/fs/ntfs/super.c
--- linux-2.6.15~/fs/ntfs/super.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/fs/ntfs/super.c	2006-01-14 18:30:09.033054000 +0100
@@ -3171,7 +3171,7 @@ MODULE_DESCRIPTION("NTFS 1.2/3.x driver 
 MODULE_VERSION(NTFS_VERSION);
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
-module_param(debug_msgs, bool, 0);
+module_param(debug_msgs, bool, 0644);
 MODULE_PARM_DESC(debug_msgs, "Enable debug messages.");
 #endif
 
diff --fast -Ndpru linux-2.6.15~/kernel/rcupdate.c linux-2.6.15/kernel/rcupdate.c
--- linux-2.6.15~/kernel/rcupdate.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/kernel/rcupdate.c	2006-01-14 18:30:09.053054000 +0100
@@ -558,7 +558,7 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-module_param(maxbatch, int, 0);
+module_param(maxbatch, int, 0644);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
diff --fast -Ndpru linux-2.6.15~/net/bridge/netfilter/ebt_vlan.c linux-2.6.15/net/bridge/netfilter/ebt_vlan.c
--- linux-2.6.15~/net/bridge/netfilter/ebt_vlan.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/bridge/netfilter/ebt_vlan.c	2006-01-14 18:30:09.073054000 +0100
@@ -28,7 +28,7 @@
 static int debug;
 #define MODULE_VERS "0.6"
 
-module_param(debug, int, 0);
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug=1 is turn on debug messages");
 MODULE_AUTHOR("Nick Fedchik <nick@fedchik.org.ua>");
 MODULE_DESCRIPTION("802.1Q match module (ebtables extension), v"
diff --fast -Ndpru linux-2.6.15~/net/core/pktgen.c linux-2.6.15/net/core/pktgen.c
--- linux-2.6.15~/net/core/pktgen.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/core/pktgen.c	2006-01-14 18:30:09.093054000 +0100
@@ -3060,7 +3060,7 @@ module_exit(pg_cleanup);
 MODULE_AUTHOR("Robert Olsson <robert.olsson@its.uu.se");
 MODULE_DESCRIPTION("Packet Generator tool");
 MODULE_LICENSE("GPL");
-module_param(pg_count_d, int, 0);
-module_param(pg_delay_d, int, 0);
-module_param(pg_clone_skb_d, int, 0);
-module_param(debug, int, 0);
+module_param(pg_count_d, int, 0400);
+module_param(pg_delay_d, int, 0400);
+module_param(pg_clone_skb_d, int, 0400);
+module_param(debug, int, 0444);
diff --fast -Ndpru linux-2.6.15~/net/ipv4/ipvs/ip_vs_ftp.c linux-2.6.15/net/ipv4/ipvs/ip_vs_ftp.c
--- linux-2.6.15~/net/ipv4/ipvs/ip_vs_ftp.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/ipv4/ipvs/ip_vs_ftp.c	2006-01-14 18:30:09.123054000 +0100
@@ -52,7 +52,7 @@ module_param_array(ports, int, NULL, 0);
  */
 #ifdef CONFIG_IP_VS_DEBUG
 static int debug=0;
-module_param(debug, int, 0);
+module_param(debug, int, 0644);
 #endif
 
 
diff --fast -Ndpru linux-2.6.15~/net/ipv4/netfilter/iptable_filter.c linux-2.6.15/net/ipv4/netfilter/iptable_filter.c
--- linux-2.6.15~/net/ipv4/netfilter/iptable_filter.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/ipv4/netfilter/iptable_filter.c	2006-01-14 18:30:09.133054000 +0100
@@ -136,7 +136,7 @@ static struct nf_hook_ops ipt_ops[] = {
 
 /* Default to forward because I got too much mail already. */
 static int forward = NF_ACCEPT;
-module_param(forward, bool, 0000);
+module_param(forward, bool, 0644);
 
 static int __init init(void)
 {
diff --fast -Ndpru linux-2.6.15~/net/ipv6/netfilter/ip6table_filter.c linux-2.6.15/net/ipv6/netfilter/ip6table_filter.c
--- linux-2.6.15~/net/ipv6/netfilter/ip6table_filter.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/ipv6/netfilter/ip6table_filter.c	2006-01-14 18:30:09.153054000 +0100
@@ -156,7 +156,7 @@ static struct nf_hook_ops ip6t_ops[] = {
 
 /* Default to forward because I got too much mail already. */
 static int forward = NF_ACCEPT;
-module_param(forward, bool, 0000);
+module_param(forward, bool, 0644);
 
 static int __init init(void)
 {
diff --fast -Ndpru linux-2.6.15~/net/irda/irlan/irlan_common.c linux-2.6.15/net/irda/irlan/irlan_common.c
--- linux-2.6.15~/net/irda/irlan/irlan_common.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/irda/irlan/irlan_common.c	2006-01-14 18:30:09.183054000 +0100
@@ -1190,9 +1190,9 @@ MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.
 MODULE_DESCRIPTION("The Linux IrDA LAN protocol"); 
 MODULE_LICENSE("GPL");
 
-module_param(eth, bool, 0);
+module_param(eth, bool, 0644);
 MODULE_PARM_DESC(eth, "Name devices ethX (0) or irlanX (1)");
-module_param(access, int, 0);
+module_param(access, int, 0644);
 MODULE_PARM_DESC(access, "Access type DIRECT=1, PEER=2, HOSTED=3");
 
 module_init(irlan_init);
diff --fast -Ndpru linux-2.6.15~/net/irda/irmod.c linux-2.6.15/net/irda/irmod.c
--- linux-2.6.15~/net/irda/irmod.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/irda/irmod.c	2006-01-14 18:30:09.203054000 +0100
@@ -61,7 +61,7 @@ extern int  irlap_driver_rcv(struct sk_b
  */
 #ifdef CONFIG_IRDA_DEBUG
 unsigned int irda_debug = IRDA_DEBUG_LEVEL;
-module_param_named(debug, irda_debug, uint, 0);
+module_param_named(debug, irda_debug, uint, 0644);
 MODULE_PARM_DESC(debug, "IRDA debugging level");
 EXPORT_SYMBOL(irda_debug);
 #endif
diff --fast -Ndpru linux-2.6.15~/net/netrom/af_netrom.c linux-2.6.15/net/netrom/af_netrom.c
--- linux-2.6.15~/net/netrom/af_netrom.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/netrom/af_netrom.c	2006-01-14 18:30:09.233054000 +0100
@@ -1442,7 +1442,7 @@ fail:
 
 module_init(nr_proto_init);
 
-module_param(nr_ndevs, int, 0);
+module_param(nr_ndevs, int, 0644);
 MODULE_PARM_DESC(nr_ndevs, "number of NET/ROM devices");
 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
diff --fast -Ndpru linux-2.6.15~/net/rose/af_rose.c linux-2.6.15/net/rose/af_rose.c
--- linux-2.6.15~/net/rose/af_rose.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/rose/af_rose.c	2006-01-14 18:30:09.263054000 +0100
@@ -1547,7 +1547,7 @@ out_proto_unregister:
 }
 module_init(rose_proto_init);
 
-module_param(rose_ndevs, int, 0);
+module_param(rose_ndevs, int, 0644);
 MODULE_PARM_DESC(rose_ndevs, "number of ROSE devices");
 
 MODULE_AUTHOR("Jonathan Naylor G4KLX <g4klx@g4klx.demon.co.uk>");
diff --fast -Ndpru linux-2.6.15~/net/sched/sch_teql.c linux-2.6.15/net/sched/sch_teql.c
--- linux-2.6.15~/net/sched/sch_teql.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/net/sched/sch_teql.c	2006-01-14 18:30:09.283054000 +0100
@@ -451,7 +451,7 @@ static __init void teql_master_setup(str
 
 static LIST_HEAD(master_dev_list);
 static int max_equalizers = 1;
-module_param(max_equalizers, int, 0);
+module_param(max_equalizers, int, 0644);
 MODULE_PARM_DESC(max_equalizers, "Max number of link equalizers");
 
 static int __init teql_init(void)
diff --fast -Ndpru linux-2.6.15~/security/seclvl.c linux-2.6.15/security/seclvl.c
--- linux-2.6.15~/security/seclvl.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/security/seclvl.c	2006-01-14 18:30:09.283054000 +0100
@@ -49,12 +49,12 @@ static int initlvl = 1;
 #else
 static int initlvl;
 #endif
-module_param(initlvl, int, 0);
+module_param(initlvl, int, 0444);
 MODULE_PARM_DESC(initlvl, "Initial secure level (defaults to 1)");
 
 /* Module parameter that defines the verbosity level */
 static int verbosity;
-module_param(verbosity, int, 0);
+module_param(verbosity, int, 0644);
 MODULE_PARM_DESC(verbosity, "Initial verbosity level (0 or 1; defaults to "
 		 "0, which is Quiet)");
 
#<<eof>>

Jan Engelhardt
-- 
