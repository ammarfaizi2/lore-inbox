Return-Path: <linux-kernel-owner+w=401wt.eu-S1761146AbWLHTBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761146AbWLHTBF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761152AbWLHTBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:01:05 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:60391 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761146AbWLHTBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:01:03 -0500
Date: Fri, 8 Dec 2006 13:01:01 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 1/2] IPMI: remove zero inits
Message-ID: <20061208190101.GB14675@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Remove all =0 and =NULL from static initializers.
They are not needed and removing them saves space in the object files.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_bt_sm.c
@@ -37,8 +37,10 @@
 #define BT_DEBUG_ENABLE	1	/* Generic messages */
 #define BT_DEBUG_MSG	2	/* Prints all request/response buffers */
 #define BT_DEBUG_STATES	4	/* Verbose look at state changes */
+/* BT_DEBUG_OFF must be zero to correspond to the default uninitialized
+   value */
 
-static int bt_debug = BT_DEBUG_OFF;
+static int bt_debug; /* 0 == BT_DEBUG_OFF */
 
 module_param(bt_debug, int, 0644);
 MODULE_PARM_DESC(bt_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
Index: linux-2.6.19/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_devintf.c
@@ -834,7 +834,7 @@ static const struct file_operations ipmi
 
 #define DEVICE_NAME     "ipmidev"
 
-static int ipmi_major = 0;
+static int ipmi_major;
 module_param(ipmi_major, int, 0);
 MODULE_PARM_DESC(ipmi_major, "Sets the major number of the IPMI device.  By"
 		 " default, or if you set it to zero, it will choose the next"
Index: linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
@@ -53,10 +53,10 @@
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
 
-static int initialized = 0;
+static int initialized;
 
 #ifdef CONFIG_PROC_FS
-static struct proc_dir_entry *proc_ipmi_root = NULL;
+static struct proc_dir_entry *proc_ipmi_root;
 #endif /* CONFIG_PROC_FS */
 
 /* Remain in auto-maintenance mode for this amount of time (in ms). */
@@ -4043,7 +4043,7 @@ static void send_panic_events(char *str)
 }
 #endif /* CONFIG_IPMI_PANIC_EVENT */
 
-static int has_panicked = 0;
+static int has_panicked;
 
 static int panic_event(struct notifier_block *this,
 		       unsigned long         event,
Index: linux-2.6.19/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_poweroff.c
@@ -58,10 +58,10 @@ static int poweroff_powercycle;
 static int ifnum_to_use = -1;
 
 /* Our local state. */
-static int ready = 0;
+static int ready;
 static ipmi_user_t ipmi_user;
 static int ipmi_ifnum;
-static void (*specific_poweroff_func)(ipmi_user_t user) = NULL;
+static void (*specific_poweroff_func)(ipmi_user_t user);
 
 /* Holds the old poweroff function so we can restore it on removal. */
 static void (*old_poweroff_func)(void);
@@ -182,7 +182,7 @@ static int ipmi_request_in_rc_mode(ipmi_
 #define IPMI_MOTOROLA_MANUFACTURER_ID		0x0000A1
 #define IPMI_MOTOROLA_PPS_IPMC_PRODUCT_ID	0x0051
 
-static void (*atca_oem_poweroff_hook)(ipmi_user_t user) = NULL;
+static void (*atca_oem_poweroff_hook)(ipmi_user_t user);
 
 static void pps_poweroff_atca (ipmi_user_t user)
 {
Index: linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
@@ -845,7 +845,7 @@ static void request_events(void *send_in
 	atomic_set(&smi_info->req_events, 1);
 }
 
-static int initialized = 0;
+static int initialized;
 
 static void smi_timeout(unsigned long data)
 {
@@ -1018,13 +1018,13 @@ static int num_ports;
 static int           irqs[SI_MAX_PARMS];
 static int num_irqs;
 static int           regspacings[SI_MAX_PARMS];
-static int num_regspacings = 0;
+static int num_regspacings;
 static int           regsizes[SI_MAX_PARMS];
-static int num_regsizes = 0;
+static int num_regsizes;
 static int           regshifts[SI_MAX_PARMS];
-static int num_regshifts = 0;
+static int num_regshifts;
 static int slave_addrs[SI_MAX_PARMS];
-static int num_slave_addrs = 0;
+static int num_slave_addrs;
 
 #define IPMI_IO_ADDR_SPACE  0
 #define IPMI_MEM_ADDR_SPACE 1
@@ -1668,7 +1668,7 @@ static __devinit void hardcode_find_bmc(
 /* Once we get an ACPI failure, we don't try any more, because we go
    through the tables sequentially.  Once we don't find a table, there
    are no more. */
-static int acpi_failure = 0;
+static int acpi_failure;
 
 /* For GPE-type interrupts. */
 static u32 ipmi_acpi_gpe(void *context)
Index: linux-2.6.19/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_watchdog.c
@@ -134,14 +134,14 @@
 
 static int nowayout = WATCHDOG_NOWAYOUT;
 
-static ipmi_user_t watchdog_user = NULL;
+static ipmi_user_t watchdog_user;
 static int watchdog_ifnum;
 
 /* Default the timeout to 10 seconds. */
 static int timeout = 10;
 
 /* The pre-timeout is disabled by default. */
-static int pretimeout = 0;
+static int pretimeout;
 
 /* Default action is to reset the board on a timeout. */
 static unsigned char action_val = WDOG_TIMEOUT_RESET;
@@ -156,10 +156,10 @@ static unsigned char preop_val = WDOG_PR
 
 static char preop[16] = "preop_none";
 static DEFINE_SPINLOCK(ipmi_read_lock);
-static char data_to_read = 0;
+static char data_to_read;
 static DECLARE_WAIT_QUEUE_HEAD(read_q);
-static struct fasync_struct *fasync_q = NULL;
-static char pretimeout_since_last_heartbeat = 0;
+static struct fasync_struct *fasync_q;
+static char pretimeout_since_last_heartbeat;
 static char expect_close;
 
 static int ifnum_to_use = -1;
@@ -177,7 +177,7 @@ static void ipmi_unregister_watchdog(int
 
 /* If true, the driver will start running as soon as it is configured
    and ready. */
-static int start_now = 0;
+static int start_now;
 
 static int set_param_int(const char *val, struct kernel_param *kp)
 {
@@ -300,16 +300,16 @@ MODULE_PARM_DESC(nowayout, "Watchdog can
 static unsigned char ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
 
 /* If shutting down via IPMI, we ignore the heartbeat. */
-static int ipmi_ignore_heartbeat = 0;
+static int ipmi_ignore_heartbeat;
 
 /* Is someone using the watchdog?  Only one user is allowed. */
-static unsigned long ipmi_wdog_open = 0;
+static unsigned long ipmi_wdog_open;
 
 /* If set to 1, the heartbeat command will set the state to reset and
    start the timer.  The timer doesn't normally run when the driver is
    first opened until the heartbeat is set the first time, this
    variable is used to accomplish this. */
-static int ipmi_start_timer_on_heartbeat = 0;
+static int ipmi_start_timer_on_heartbeat;
 
 /* IPMI version of the BMC. */
 static unsigned char ipmi_version_major;
