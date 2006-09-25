Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWIYSgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWIYSgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWIYSgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:21 -0400
Received: from [198.99.130.12] ([198.99.130.12]:52628 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751433AbWIYSgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:01 -0400
Message-Id: <200609251834.k8PIYQXg005021@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/8] UML - Const more data
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make lots of structures const in order to make it obvious that they need
no locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/chan_kern.c	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/chan_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -110,7 +110,7 @@ static void not_configged_free(void *dat
 	       "UML\n");
 }
 
-static struct chan_ops not_configged_ops = {
+static const struct chan_ops not_configged_ops = {
 	.init		= not_configged_init,
 	.open		= not_configged_open,
 	.close		= not_configged_close,
@@ -373,7 +373,7 @@ int console_write_chan(struct list_head 
 }
 
 int console_open_chan(struct line *line, struct console *co,
-		      struct chan_opts *opts)
+		      const struct chan_opts *opts)
 {
 	int err;
 
@@ -494,10 +494,10 @@ int chan_config_string(struct list_head 
 
 struct chan_type {
 	char *key;
-	struct chan_ops *ops;
+	const struct chan_ops *ops;
 };
 
-static struct chan_type chan_table[] = {
+static const struct chan_type chan_table[] = {
 	{ "fd", &fd_ops },
 
 #ifdef CONFIG_NULL_CHAN
@@ -534,10 +534,10 @@ static struct chan_type chan_table[] = {
 };
 
 static struct chan *parse_chan(struct line *line, char *str, int device,
-			       struct chan_opts *opts)
+			       const struct chan_opts *opts)
 {
-	struct chan_type *entry;
-	struct chan_ops *ops;
+	const struct chan_type *entry;
+	const struct chan_ops *ops;
 	struct chan *chan;
 	void *data;
 	int i;
@@ -582,7 +582,7 @@ static struct chan *parse_chan(struct li
 }
 
 int parse_chan_pair(char *str, struct line *line, int device,
-		    struct chan_opts *opts)
+		    const struct chan_opts *opts)
 {
 	struct list_head *chans = &line->chan_list;
 	struct chan *new, *chan;
Index: linux-2.6.18-mm/arch/um/drivers/daemon.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/daemon.h	2006-09-22 09:19:50.000000000 -0400
@@ -18,7 +18,7 @@ struct daemon_data {
 	void *dev;
 };
 
-extern struct net_user_info daemon_user_info;
+extern const struct net_user_info daemon_user_info;
 
 extern int daemon_user_write(int fd, void *buf, int len, 
 			     struct daemon_data *pri);
Index: linux-2.6.18-mm/arch/um/drivers/daemon_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/daemon_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -57,7 +57,7 @@ static int daemon_write(int fd, struct s
 				 (struct daemon_data *) &lp->user));
 }
 
-static struct net_kern_info daemon_kern_info = {
+static const struct net_kern_info daemon_kern_info = {
 	.init			= daemon_init,
 	.protocol		= eth_protocol,
 	.read			= daemon_read,
Index: linux-2.6.18-mm/arch/um/drivers/daemon_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/daemon_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -182,7 +182,7 @@ static int daemon_set_mtu(int mtu, void 
 	return(mtu);
 }
 
-struct net_user_info daemon_user_info = {
+const struct net_user_info daemon_user_info = {
 	.init		= daemon_user_init,
 	.open		= daemon_open,
 	.close	 	= NULL,
Index: linux-2.6.18-mm/arch/um/drivers/fd.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/fd.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/fd.c	2006-09-22 09:19:50.000000000 -0400
@@ -20,7 +20,7 @@ struct fd_chan {
 	char str[sizeof("1234567890\0")];
 };
 
-static void *fd_init(char *str, int device, struct chan_opts *opts)
+static void *fd_init(char *str, int device, const struct chan_opts *opts)
 {
 	struct fd_chan *data;
 	char *end;
@@ -77,7 +77,7 @@ static void fd_close(int fd, void *d)
 	}
 }
 
-struct chan_ops fd_ops = {
+const struct chan_ops fd_ops = {
 	.type		= "fd",
 	.init		= fd_init,
 	.open		= fd_open,
Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -279,7 +279,7 @@ static int hostmixer_release(struct inod
 
 /* kernel module operations */
 
-static struct file_operations hostaudio_fops = {
+static const struct file_operations hostaudio_fops = {
         .owner          = THIS_MODULE,
         .llseek         = no_llseek,
         .read           = hostaudio_read,
@@ -291,7 +291,7 @@ static struct file_operations hostaudio_
         .release        = hostaudio_release,
 };
 
-static struct file_operations hostmixer_fops = {
+static const struct file_operations hostmixer_fops = {
         .owner          = THIS_MODULE,
         .llseek         = no_llseek,
         .ioctl          = hostmixer_ioctl_mixdev,
Index: linux-2.6.18-mm/arch/um/drivers/line.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/line.c	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/line.c	2006-09-22 09:19:50.000000000 -0400
@@ -251,7 +251,7 @@ void line_set_termios(struct tty_struct 
 	/* nothing */
 }
 
-static struct {
+static const struct {
 	int  cmd;
 	char *level;
 	char *name;
@@ -405,7 +405,7 @@ static irqreturn_t line_write_interrupt(
 
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
-	struct line_driver *driver = line->driver;
+	const struct line_driver *driver = line->driver;
 	int err = 0, flags = IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM;
 
 	if (input)
@@ -558,7 +558,7 @@ int line_setup(struct line *lines, unsig
 }
 
 int line_config(struct line *lines, unsigned int num, char *str,
-		struct chan_opts *opts)
+		const struct chan_opts *opts)
 {
 	struct line *line;
 	char *new;
Index: linux-2.6.18-mm/arch/um/drivers/mcast.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mcast.h	2006-09-22 09:19:50.000000000 -0400
@@ -13,7 +13,7 @@ struct mcast_data {
 	void *dev;
 };
 
-extern struct net_user_info mcast_user_info;
+extern const struct net_user_info mcast_user_info;
 
 extern int mcast_user_write(int fd, void *buf, int len, 
 			    struct mcast_data *pri);
Index: linux-2.6.18-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mcast_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -61,7 +61,7 @@ static int mcast_write(int fd, struct sk
 				 (struct mcast_data *) &lp->user);
 }
 
-static struct net_kern_info mcast_kern_info = {
+static const struct net_kern_info mcast_kern_info = {
 	.init			= mcast_init,
 	.protocol		= eth_protocol,
 	.read			= mcast_read,
Index: linux-2.6.18-mm/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast_user.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mcast_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -152,7 +152,7 @@ static int mcast_set_mtu(int mtu, void *
 	return(mtu);
 }
 
-struct net_user_info mcast_user_info = {
+const struct net_user_info mcast_user_info = {
 	.init		= mcast_user_init,
 	.open		= mcast_open,
 	.close	 	= mcast_close,
Index: linux-2.6.18-mm/arch/um/drivers/mmapper_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mmapper_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/mmapper_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -85,7 +85,7 @@ mmapper_release(struct inode *inode, str
 	return 0;
 }
 
-static struct file_operations mmapper_fops = {
+static const struct file_operations mmapper_fops = {
 	.owner		= THIS_MODULE,
 	.read		= mmapper_read,
 	.write		= mmapper_write,
@@ -95,7 +95,7 @@ static struct file_operations mmapper_fo
 	.release	= mmapper_release,
 };
 
-static struct miscdevice mmapper_dev = {
+static const struct miscdevice mmapper_dev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "mmapper",
 	.fops		= &mmapper_fops
Index: linux-2.6.18-mm/arch/um/drivers/null.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/null.c	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/null.c	2006-09-22 09:19:50.000000000 -0400
@@ -10,7 +10,7 @@
 
 static int null_chan;
 
-static void *null_init(char *str, int device, struct chan_opts *opts)
+static void *null_init(char *str, int device, const struct chan_opts *opts)
 {
 	return(&null_chan);
 }
@@ -31,7 +31,7 @@ static void null_free(void *data)
 {
 }
 
-struct chan_ops null_ops = {
+const struct chan_ops null_ops = {
 	.type		= "null",
 	.init		= null_init,
 	.open		= null_open,
Index: linux-2.6.18-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pcap_kern.c	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/pcap_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -46,7 +46,7 @@ static int pcap_write(int fd, struct sk_
 	return(-EPERM);
 }
 
-static struct net_kern_info pcap_kern_info = {
+static const struct net_kern_info pcap_kern_info = {
 	.init			= pcap_init,
 	.protocol		= eth_protocol,
 	.read			= pcap_read,
Index: linux-2.6.18-mm/arch/um/drivers/pcap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pcap_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/pcap_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -120,7 +120,7 @@ int pcap_user_read(int fd, void *buffer,
 	return(hdata.len);
 }
 
-struct net_user_info pcap_user_info = {
+const struct net_user_info pcap_user_info = {
 	.init		= pcap_user_init,
 	.open		= pcap_open,
 	.close	 	= NULL,
Index: linux-2.6.18-mm/arch/um/drivers/port_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/port_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -27,7 +27,7 @@ struct port_chan {
 	char dev[sizeof("32768\0")];
 };
 
-static void *port_init(char *str, int device, struct chan_opts *opts)
+static void *port_init(char *str, int device, const struct chan_opts *opts)
 {
 	struct port_chan *data;
 	void *kern_data;
@@ -100,7 +100,7 @@ static void port_close(int fd, void *d)
 	os_close_file(fd);
 }
 
-struct chan_ops port_ops = {
+const struct chan_ops port_ops = {
 	.type		= "port",
 	.init		= port_init,
 	.open		= port_open,
Index: linux-2.6.18-mm/arch/um/drivers/pty.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pty.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/pty.c	2006-09-22 09:19:50.000000000 -0400
@@ -22,7 +22,7 @@ struct pty_chan {
 	char dev_name[sizeof("/dev/pts/0123456\0")];
 };
 
-static void *pty_chan_init(char *str, int device, struct chan_opts *opts)
+static void *pty_chan_init(char *str, int device, const struct chan_opts *opts)
 {
 	struct pty_chan *data;
 
@@ -118,7 +118,7 @@ static int pty_open(int input, int outpu
 	return(fd);
 }
 
-struct chan_ops pty_ops = {
+const struct chan_ops pty_ops = {
 	.type		= "pty",
 	.init		= pty_chan_init,
 	.open		= pty_open,
@@ -131,7 +131,7 @@ struct chan_ops pty_ops = {
 	.winch		= 0,
 };
 
-struct chan_ops pts_ops = {
+const struct chan_ops pts_ops = {
 	.type		= "pts",
 	.init		= pty_chan_init,
 	.open		= pts_open,
Index: linux-2.6.18-mm/arch/um/drivers/random.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/random.c	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/random.c	2006-09-22 09:19:50.000000000 -0400
@@ -68,7 +68,7 @@ static ssize_t rng_dev_read (struct file
 	return ret;
 }
 
-static struct file_operations rng_chrdev_ops = {
+static const struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
 	.read		= rng_dev_read,
Index: linux-2.6.18-mm/arch/um/drivers/slip.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slip.h	2006-09-22 09:19:50.000000000 -0400
@@ -12,7 +12,7 @@ struct slip_data {
 	struct slip_proto slip;
 };
 
-extern struct net_user_info slip_user_info;
+extern const struct net_user_info slip_user_info;
 
 extern int slip_user_read(int fd, void *buf, int len, struct slip_data *pri);
 extern int slip_user_write(int fd, void *buf, int len, struct slip_data *pri);
Index: linux-2.6.18-mm/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slip_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -60,7 +60,7 @@ static int slip_write(int fd, struct sk_
 			       (struct slip_data *) &lp->user));
 }
 
-struct net_kern_info slip_kern_info = {
+const struct net_kern_info slip_kern_info = {
 	.init			= slip_init,
 	.protocol		= slip_protocol,
 	.read			= slip_read,
Index: linux-2.6.18-mm/arch/um/drivers/slip_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slip_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -241,7 +241,7 @@ static void slip_del_addr(unsigned char 
 	close_addr(addr, netmask, pri->name);
 }
 
-struct net_user_info slip_user_info = {
+const struct net_user_info slip_user_info = {
 	.init		= slip_user_init,
 	.open		= slip_open,
 	.close	 	= slip_close,
Index: linux-2.6.18-mm/arch/um/drivers/slirp.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slirp.h	2006-09-22 09:19:50.000000000 -0400
@@ -24,7 +24,7 @@ struct slirp_data {
 	struct slip_proto slip;
 };
 
-extern struct net_user_info slirp_user_info;
+extern const struct net_user_info slirp_user_info;
 
 extern int slirp_user_read(int fd, void *buf, int len, struct slirp_data *pri);
 extern int slirp_user_write(int fd, void *buf, int len,
Index: linux-2.6.18-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slirp_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -64,7 +64,7 @@ static int slirp_write(int fd, struct sk
 			       (struct slirp_data *) &lp->user));
 }
 
-struct net_kern_info slirp_kern_info = {
+const struct net_kern_info slirp_kern_info = {
 	.init			= slirp_init,
 	.protocol		= slirp_protocol,
 	.read			= slirp_read,
Index: linux-2.6.18-mm/arch/um/drivers/slirp_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp_user.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/slirp_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -126,7 +126,7 @@ static int slirp_set_mtu(int mtu, void *
 	return(mtu);
 }
 
-struct net_user_info slirp_user_info = {
+const struct net_user_info slirp_user_info = {
 	.init		= slirp_user_init,
 	.open		= slirp_open,
 	.close	 	= slirp_close,
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2006-09-22 09:19:50.000000000 -0400
@@ -22,7 +22,7 @@
 #include "irq_user.h"
 #include "mconsole_kern.h"
 
-static int ssl_version = 1;
+static const int ssl_version = 1;
 
 /* Referenced only by tty_driver below - presumably it's locked correctly
  * by the tty driver.
@@ -122,7 +122,7 @@ void ssl_hangup(struct tty_struct *tty)
 }
 #endif
 
-static struct tty_operations ssl_ops = {
+static const struct tty_operations ssl_ops = {
 	.open 	 		= ssl_open,
 	.close 	 		= line_close,
 	.write 	 		= line_write,
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-09-22 09:19:50.000000000 -0400
@@ -109,7 +109,7 @@ static int con_open(struct tty_struct *t
 
 static int con_init_done = 0;
 
-static struct tty_operations console_ops = {
+static const struct tty_operations console_ops = {
 	.open 	 		= con_open,
 	.close 	 		= line_close,
 	.write 	 		= line_write,
Index: linux-2.6.18-mm/arch/um/drivers/tty.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/tty.c	2006-09-11 10:47:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/tty.c	2006-09-22 09:19:50.000000000 -0400
@@ -18,7 +18,7 @@ struct tty_chan {
 	struct termios tt;
 };
 
-static void *tty_chan_init(char *str, int device, struct chan_opts *opts)
+static void *tty_chan_init(char *str, int device, const struct chan_opts *opts)
 {
 	struct tty_chan *data;
 
@@ -62,7 +62,7 @@ static int tty_open(int input, int outpu
 	return fd;
 }
 
-struct chan_ops tty_ops = {
+const struct chan_ops tty_ops = {
 	.type		= "tty",
 	.init		= tty_chan_init,
 	.open		= tty_open,
Index: linux-2.6.18-mm/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/xterm.c	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/xterm.c	2006-09-22 09:19:50.000000000 -0400
@@ -31,7 +31,7 @@ struct xterm_chan {
 };
 
 /* Not static because it's called directly by the tt mode gdb code */
-void *xterm_init(char *str, int device, struct chan_opts *opts)
+void *xterm_init(char *str, int device, const struct chan_opts *opts)
 {
 	struct xterm_chan *data;
 
@@ -194,7 +194,7 @@ static void xterm_free(void *d)
 	free(d);
 }
 
-struct chan_ops xterm_ops = {
+const struct chan_ops xterm_ops = {
 	.type		= "xterm",
 	.init		= xterm_init,
 	.open		= xterm_open,
Index: linux-2.6.18-mm/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_kern.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/chan_kern.h	2006-09-22 09:19:50.000000000 -0400
@@ -23,21 +23,21 @@ struct chan {
 	unsigned int opened:1;
 	unsigned int enabled:1;
 	int fd;
-	struct chan_ops *ops;
+	const struct chan_ops *ops;
 	void *data;
 };
 
 extern void chan_interrupt(struct list_head *chans, struct work_struct *task,
 			   struct tty_struct *tty, int irq);
 extern int parse_chan_pair(char *str, struct line *line, int device,
-			   struct chan_opts *opts);
+			   const struct chan_opts *opts);
 extern int open_chan(struct list_head *chans);
 extern int write_chan(struct list_head *chans, const char *buf, int len,
 			     int write_irq);
 extern int console_write_chan(struct list_head *chans, const char *buf, 
 			      int len);
 extern int console_open_chan(struct line *line, struct console *co,
-			     struct chan_opts *opts);
+			     const struct chan_opts *opts);
 extern void deactivate_chan(struct list_head *chans, int irq);
 extern void reactivate_chan(struct list_head *chans, int irq);
 extern void chan_enable_winch(struct list_head *chans, struct tty_struct *tty);
Index: linux-2.6.18-mm/arch/um/include/chan_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/chan_user.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/chan_user.h	2006-09-22 09:19:50.000000000 -0400
@@ -20,7 +20,7 @@ enum chan_init_pri { INIT_STATIC, INIT_A
 
 struct chan_ops {
 	char *type;
-	void *(*init)(char *, int, struct chan_opts *);
+	void *(*init)(char *, int, const struct chan_opts *);
 	int (*open)(int, int, int, void *, char **);
 	void (*close)(int, void *);
 	int (*read)(int, char *, void *);
@@ -31,8 +31,8 @@ struct chan_ops {
 	int winch;
 };
 
-extern struct chan_ops fd_ops, null_ops, port_ops, pts_ops, pty_ops, tty_ops,
-	xterm_ops;
+extern const struct chan_ops fd_ops, null_ops, port_ops, pts_ops, pty_ops,
+	tty_ops, xterm_ops;
 
 extern void generic_close(int fd, void *unused);
 extern int generic_read(int fd, char *c_out, void *unused);
Index: linux-2.6.18-mm/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/kern_util.h	2006-09-22 09:16:06.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/kern_util.h	2006-09-22 09:19:50.000000000 -0400
@@ -21,7 +21,7 @@ struct kern_handlers {
 	kern_hndl timer_handler;
 };
 
-extern struct kern_handlers handlinfo_kern;
+extern const struct kern_handlers handlinfo_kern;
 
 extern int ncpus;
 extern char *linux_prog;
Index: linux-2.6.18-mm/arch/um/include/line.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/line.h	2006-09-12 10:43:38.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/line.h	2006-09-22 09:19:50.000000000 -0400
@@ -52,7 +52,7 @@ struct line {
 
 	int sigio;
 	struct work_struct task;
-	struct line_driver *driver;
+	const struct line_driver *driver;
 	int have_irq;
 };
 
@@ -98,7 +98,7 @@ extern void lines_init(struct line *line
 extern void close_lines(struct line *lines, int nlines);
 
 extern int line_config(struct line *lines, unsigned int sizeof_lines,
-		       char *str, struct chan_opts *opts);
+		       char *str, const struct chan_opts *opts);
 extern int line_id(char **str, int *start_out, int *end_out);
 extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n);
 extern int line_get_config(char *dev, struct line *lines,
Index: linux-2.6.18-mm/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_kern.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/net_kern.h	2006-09-22 09:19:50.000000000 -0400
@@ -54,8 +54,8 @@ struct transport {
 	struct list_head list;
 	char *name;
 	int (*setup)(char *, char **, void *);
-	struct net_user_info *user;
-	struct net_kern_info *kern;
+	const struct net_user_info *user;
+	const struct net_kern_info *kern;
 	int private_size;
 	int setup_size;
 };
Index: linux-2.6.18-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/trap.c	2006-09-22 09:16:06.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/trap.c	2006-09-22 09:19:50.000000000 -0400
@@ -139,7 +139,7 @@ void segv_handler(int sig, union uml_pt_
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
-struct kern_handlers handlinfo_kern = {
+const struct kern_handlers handlinfo_kern = {
 	.relay_signal = relay_signal,
 	.winch = winch,
 	.bus_handler = relay_signal,
Index: linux-2.6.18-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/um_arch.c	2006-09-22 09:16:04.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/um_arch.c	2006-09-22 09:19:50.000000000 -0400
@@ -105,7 +105,7 @@ static void c_stop(struct seq_file *m, v
 {
 }
 
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start	= c_start,
 	.next	= c_next,
 	.stop	= c_stop,
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/etap.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/etap.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/etap.h	2006-09-22 09:19:50.000000000 -0400
@@ -13,7 +13,7 @@ struct ethertap_data {
 	void *dev;
 };
 
-extern struct net_user_info ethertap_user_info;
+extern const struct net_user_info ethertap_user_info;
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -65,7 +65,7 @@ static int etap_write(int fd, struct sk_
 	return(net_send(fd, (*skb)->data, (*skb)->len));
 }
 
-struct net_kern_info ethertap_kern_info = {
+const struct net_kern_info ethertap_kern_info = {
 	.init			= etap_init,
 	.protocol		= eth_protocol,
 	.read			= etap_read,
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/ethertap_user.c	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -216,7 +216,7 @@ static void etap_del_addr(unsigned char 
 	etap_close_addr(addr, netmask, &pri->control_fd);
 }
 
-struct net_user_info ethertap_user_info = {
+const struct net_user_info ethertap_user_info = {
 	.init		= etap_user_init,
 	.open		= etap_open,
 	.close	 	= etap_close,
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap.h	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap.h	2006-09-22 09:19:50.000000000 -0400
@@ -16,7 +16,7 @@ struct tuntap_data {
 	void *dev;
 };
 
-extern struct net_user_info tuntap_user_info;
+extern const struct net_user_info tuntap_user_info;
 
 #endif
 
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap_kern.c	2006-09-12 16:31:36.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_kern.c	2006-09-22 09:19:50.000000000 -0400
@@ -53,7 +53,7 @@ static int tuntap_write(int fd, struct s
 	return(net_write(fd, (*skb)->data, (*skb)->len));
 }
 
-struct net_kern_info tuntap_kern_info = {
+const struct net_kern_info tuntap_kern_info = {
 	.init			= tuntap_init,
 	.protocol		= eth_protocol,
 	.read			= tuntap_read,
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap_user.c	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_user.c	2006-09-22 09:19:50.000000000 -0400
@@ -205,7 +205,7 @@ static int tuntap_set_mtu(int mtu, void 
 	return(mtu);
 }
 
-struct net_user_info tuntap_user_info = {
+const struct net_user_info tuntap_user_info = {
 	.init		= tuntap_user_init,
 	.open		= tuntap_open,
 	.close	 	= tuntap_close,

