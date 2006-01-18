Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWARX77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWARX77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWARX7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:45 -0500
Received: from [151.97.230.9] ([151.97.230.9]:7145 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030468AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 7/8] uml: some harmless sparse warning fixes
Date: Thu, 19 Jan 2006 00:55:20 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235518.4626.28183.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix some simple sparse warnings - a lot more staticness and a misplaced __user.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/chan_kern.c     |    6 +++---
 arch/um/drivers/daemon_kern.c   |    4 ++--
 arch/um/drivers/line.c          |    2 +-
 arch/um/drivers/mcast_kern.c    |    2 +-
 arch/um/drivers/mconsole_kern.c |    9 ++++++---
 arch/um/drivers/ssl.c           |    6 +++---
 arch/um/kernel/exec_kern.c      |    2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index ab0d0b1..7218c75 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -403,7 +403,7 @@ int chan_window_size(struct list_head *c
 	return 0;
 }
 
-void free_one_chan(struct chan *chan, int delay_free_irq)
+static void free_one_chan(struct chan *chan, int delay_free_irq)
 {
 	list_del(&chan->list);
 
@@ -416,7 +416,7 @@ void free_one_chan(struct chan *chan, in
 	kfree(chan);
 }
 
-void free_chan(struct list_head *chans, int delay_free_irq)
+static void free_chan(struct list_head *chans, int delay_free_irq)
 {
 	struct list_head *ele, *next;
 	struct chan *chan;
@@ -497,7 +497,7 @@ struct chan_type {
 	struct chan_ops *ops;
 };
 
-struct chan_type chan_table[] = {
+static struct chan_type chan_table[] = {
 	{ "fd", &fd_ops },
 
 #ifdef CONFIG_NULL_CHAN
diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
index 507e3cb..a61b7b4 100644
--- a/arch/um/drivers/daemon_kern.c
+++ b/arch/um/drivers/daemon_kern.c
@@ -18,7 +18,7 @@ struct daemon_init {
 	char *ctl_sock;
 };
 
-void daemon_init(struct net_device *dev, void *data)
+static void daemon_init(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct daemon_data *dpri;
@@ -64,7 +64,7 @@ static struct net_kern_info daemon_kern_
 	.write			= daemon_write,
 };
 
-int daemon_setup(char *str, char **mac_out, void *data)
+static int daemon_setup(char *str, char **mac_out, void *data)
 {
 	struct daemon_init *init = data;
 	char *remain;
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 46ceb25..6c2d4cc 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -714,7 +714,7 @@ struct winch {
 	struct tty_struct *tty;
 };
 
-irqreturn_t winch_interrupt(int irq, void *data, struct pt_regs *unused)
+static irqreturn_t winch_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	struct winch *winch = data;
 	struct tty_struct *tty;
diff --git a/arch/um/drivers/mcast_kern.c b/arch/um/drivers/mcast_kern.c
index 217438c..e80fdda 100644
--- a/arch/um/drivers/mcast_kern.c
+++ b/arch/um/drivers/mcast_kern.c
@@ -26,7 +26,7 @@ struct mcast_init {
 	int ttl;
 };
 
-void mcast_init(struct net_device *dev, void *data)
+static void mcast_init(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct mcast_data *dpri;
diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index e3d5765..e87ecf0 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -327,7 +327,7 @@ void mconsole_stop(struct mc_request *re
 
 /* This list is populated by __initcall routines. */
 
-LIST_HEAD(mconsole_devices);
+static LIST_HEAD(mconsole_devices);
 
 void mconsole_register_dev(struct mc_device *new)
 {
@@ -561,6 +561,8 @@ void mconsole_sysrq(struct mc_request *r
 }
 #endif
 
+#ifdef CONFIG_MODE_SKAS
+
 static void stack_proc(void *arg)
 {
 	struct task_struct *from = current, *to = arg;
@@ -574,7 +576,7 @@ static void stack_proc(void *arg)
  *  Dumps a stacks registers to the linux console.
  *  Usage stack <pid>.
  */
-void do_stack(struct mc_request *req)
+static void do_stack_trace(struct mc_request *req)
 {
 	char *ptr = req->request.data;
 	int pid_requested= -1;
@@ -605,6 +607,7 @@ void do_stack(struct mc_request *req)
 	}
 	with_console(req, stack_proc, to);
 }
+#endif /* CONFIG_MODE_SKAS */
 
 void mconsole_stack(struct mc_request *req)
 {
@@ -613,7 +616,7 @@ void mconsole_stack(struct mc_request *r
 	 */
 	CHOOSE_MODE(mconsole_reply(req, "Sorry, this doesn't work in TT mode",
 				   1, 0),
-		    do_stack(req));
+		    do_stack_trace(req));
 }
 
 /* Changed by mconsole_setup, which is __setup, and called before SMP is
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index a32ef55..a4d6415 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -33,7 +33,7 @@ static struct tty_driver *ssl_driver;
 
 #define NR_PORTS 64
 
-void ssl_announce(char *dev_name, int dev)
+static void ssl_announce(char *dev_name, int dev)
 {
 	printk(KERN_INFO "Serial line %d assigned device '%s'\n", dev,
 	       dev_name);
@@ -98,7 +98,7 @@ static int ssl_remove(int n)
 	return line_remove(serial_lines, ARRAY_SIZE(serial_lines), n);
 }
 
-int ssl_open(struct tty_struct *tty, struct file *filp)
+static int ssl_open(struct tty_struct *tty, struct file *filp)
 {
 	return line_open(serial_lines, tty);
 }
@@ -182,7 +182,7 @@ static struct console ssl_cons = {
 	.index		= -1,
 };
 
-int ssl_init(void)
+static int ssl_init(void)
 {
 	char *new_title;
 
diff --git a/arch/um/kernel/exec_kern.c b/arch/um/kernel/exec_kern.c
index efd222f..e751e29 100644
--- a/arch/um/kernel/exec_kern.c
+++ b/arch/um/kernel/exec_kern.c
@@ -34,7 +34,7 @@ void start_thread(struct pt_regs *regs, 
 extern void log_exec(char **argv, void *tty);
 
 static long execve1(char *file, char __user * __user *argv,
-		    char *__user __user *env)
+		    char __user *__user *env)
 {
         long error;
 

