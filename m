Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCGTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCGTYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCGTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:11:07 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:5638 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261252AbVCGTHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:43 -0500
Message-Id: <200503072039.j27Kd1bc004018@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 16/16] UML - Make a bunch of driver functions static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:39:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Frank Sorenson - the methods in arch/um/drivers/tty.c should be 
static.  It turns out that all the channels have the same problem, so these 
are all fixed.  These files export only a structure of function pointers, so 
that structure should be the only externally visible symbol.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/fd.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/fd.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/fd.c	2005-03-05 12:26:41.000000000 -0500
@@ -19,7 +19,7 @@
 	char str[sizeof("1234567890\0")];
 };
 
-void *fd_init(char *str, int device, struct chan_opts *opts)
+static void *fd_init(char *str, int device, struct chan_opts *opts)
 {
 	struct fd_chan *data;
 	char *end;
@@ -43,7 +43,7 @@
 	return(data);
 }
 
-int fd_open(int input, int output, int primary, void *d, char **dev_out)
+static int fd_open(int input, int output, int primary, void *d, char **dev_out)
 {
 	struct fd_chan *data = d;
 	int err;
@@ -62,7 +62,7 @@
 	return(data->fd);
 }
 
-void fd_close(int fd, void *d)
+static void fd_close(int fd, void *d)
 {
 	struct fd_chan *data = d;
 	int err;
@@ -76,7 +76,7 @@
 	}
 }
 
-int fd_console_write(int fd, const char *buf, int n, void *d)
+static int fd_console_write(int fd, const char *buf, int n, void *d)
 {
 	struct fd_chan *data = d;
 
Index: linux-2.6.11/arch/um/drivers/null.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/null.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/null.c	2005-03-05 12:26:41.000000000 -0500
@@ -10,23 +10,24 @@
 
 static int null_chan;
 
-void *null_init(char *str, int device, struct chan_opts *opts)
+static void *null_init(char *str, int device, struct chan_opts *opts)
 {
 	return(&null_chan);
 }
 
-int null_open(int input, int output, int primary, void *d, char **dev_out)
+static int null_open(int input, int output, int primary, void *d, 
+		     char **dev_out)
 {
 	*dev_out = NULL;
 	return(os_open_file(DEV_NULL, of_rdwr(OPENFLAGS()), 0));
 }
 
-int null_read(int fd, char *c_out, void *unused)
+static int null_read(int fd, char *c_out, void *unused)
 {
 	return(-ENODEV);
 }
 
-void null_free(void *data)
+static void null_free(void *data)
 {
 }
 
Index: linux-2.6.11/arch/um/drivers/port_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/port_user.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/port_user.c	2005-03-05 12:26:41.000000000 -0500
@@ -28,7 +28,7 @@
 	char dev[sizeof("32768\0")];
 };
 
-void *port_init(char *str, int device, struct chan_opts *opts)
+static void *port_init(char *str, int device, struct chan_opts *opts)
 {
 	struct port_chan *data;
 	void *kern_data;
@@ -65,7 +65,7 @@
 	return(NULL);
 }
 
-void port_free(void *d)
+static void port_free(void *d)
 {
 	struct port_chan *data = d;
 
@@ -73,7 +73,8 @@
 	kfree(data);
 }
 
-int port_open(int input, int output, int primary, void *d, char **dev_out)
+static int port_open(int input, int output, int primary, void *d, 
+		     char **dev_out)
 {
 	struct port_chan *data = d;
 	int fd, err;
@@ -92,7 +93,7 @@
 	return(fd);
 }
 
-void port_close(int fd, void *d)
+static void port_close(int fd, void *d)
 {
 	struct port_chan *data = d;
 
@@ -100,7 +101,7 @@
 	os_close_file(fd);
 }
 
-int port_console_write(int fd, const char *buf, int n, void *d)
+static int port_console_write(int fd, const char *buf, int n, void *d)
 {
 	struct port_chan *data = d;
 
Index: linux-2.6.11/arch/um/drivers/pty.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/pty.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/pty.c	2005-03-05 12:26:41.000000000 -0500
@@ -22,7 +22,7 @@
 	char dev_name[sizeof("/dev/pts/0123456\0")];
 };
 
-void *pty_chan_init(char *str, int device, struct chan_opts *opts)
+static void *pty_chan_init(char *str, int device, struct chan_opts *opts)
 {
 	struct pty_chan *data;
 
@@ -34,7 +34,8 @@
 	return(data);
 }
 
-int pts_open(int input, int output, int primary, void *d, char **dev_out)
+static int pts_open(int input, int output, int primary, void *d, 
+		    char **dev_out)
 {
 	struct pty_chan *data = d;
 	char *dev;
@@ -63,7 +64,7 @@
 	return(fd);
 }
 
-int getmaster(char *line)
+static int getmaster(char *line)
 {
 	char *pty, *bank, *cp;
 	int master, err;
@@ -92,7 +93,8 @@
 	return(-1);
 }
 
-int pty_open(int input, int output, int primary, void *d, char **dev_out)
+static int pty_open(int input, int output, int primary, void *d, 
+		    char **dev_out)
 {
 	struct pty_chan *data = d;
 	int fd, err;
@@ -115,7 +117,7 @@
 	return(fd);
 }
 
-int pty_console_write(int fd, const char *buf, int n, void *d)
+static int pty_console_write(int fd, const char *buf, int n, void *d)
 {
 	struct pty_chan *data = d;
 
Index: linux-2.6.11/arch/um/drivers/tty.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/tty.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/tty.c	2005-03-05 12:26:41.000000000 -0500
@@ -18,7 +18,7 @@
 	struct termios tt;
 };
 
-void *tty_chan_init(char *str, int device, struct chan_opts *opts)
+static void *tty_chan_init(char *str, int device, struct chan_opts *opts)
 {
 	struct tty_chan *data;
 
@@ -38,7 +38,8 @@
 	return(data);
 }
 
-int tty_open(int input, int output, int primary, void *d, char **dev_out)
+static int tty_open(int input, int output, int primary, void *d, 
+		    char **dev_out)
 {
 	struct tty_chan *data = d;
 	int fd, err;
@@ -59,7 +60,7 @@
 	return(fd);
 }
 
-int tty_console_write(int fd, const char *buf, int n, void *d)
+static int tty_console_write(int fd, const char *buf, int n, void *d)
 {
 	struct tty_chan *data = d;
 
Index: linux-2.6.11/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/xterm.c	2005-03-05 12:07:29.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/xterm.c	2005-03-05 12:26:41.000000000 -0500
@@ -31,6 +31,7 @@
 	int direct_rcv;
 };
 
+/* Not static because it's called directly by the tt mode gdb code */
 void *xterm_init(char *str, int device, struct chan_opts *opts)
 {
 	struct xterm_chan *data;
@@ -83,8 +84,11 @@
 "    are 'xterm=gnome-terminal,-t,-x'.\n\n"
 );
 
-/* XXX This badly needs some cleaning up in the error paths */
-int xterm_open(int input, int output, int primary, void *d, char **dev_out)
+/* XXX This badly needs some cleaning up in the error paths
+ * Not static because it's called directly by the tt mode gdb code 
+ */
+int xterm_open(int input, int output, int primary, void *d, 
+		      char **dev_out)
 {
 	struct xterm_chan *data = d;
 	unsigned long stack;
@@ -170,6 +174,7 @@
 	return(new);
 }
 
+/* Not static because it's called directly by the tt mode gdb code */
 void xterm_close(int fd, void *d)
 {
 	struct xterm_chan *data = d;
@@ -183,12 +188,12 @@
 	os_close_file(fd);
 }
 
-void xterm_free(void *d)
+static void xterm_free(void *d)
 {
 	free(d);
 }
 
-int xterm_console_write(int fd, const char *buf, int n, void *d)
+static int xterm_console_write(int fd, const char *buf, int n, void *d)
 {
 	struct xterm_chan *data = d;
 

