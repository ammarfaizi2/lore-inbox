Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWACXsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWACXsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWACXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:12 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:40853 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965049AbWACXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:54 -0500
Message-Id: <200601040037.k040bZAa012540@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/12] UML - use ARRAY_SIZE
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:35 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces instances of "sizeof(foo)/sizeof(foo[0])" with 
ARRAY_SIZE(foo), which expands to the same thing.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2005-12-20 17:31:37.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2005-12-20 17:31:38.000000000 -0500
@@ -84,21 +84,18 @@ static struct lines lines = LINES_INIT(N
 
 static int ssl_config(char *str)
 {
-	return line_config(serial_lines,
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), str);
+	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str);
 }
 
 static int ssl_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return line_get_config(dev, serial_lines,
-			       sizeof(serial_lines)/sizeof(serial_lines[0]),
-			       str, size, error_out);
+	return line_get_config(dev, serial_lines, ARRAY_SIZE(serial_lines), str,
+			       size, error_out);
 }
 
 static int ssl_remove(int n)
 {
-	return line_remove(serial_lines,
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), n);
+	return line_remove(serial_lines, ARRAY_SIZE(serial_lines), n);
 }
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
@@ -205,7 +202,7 @@ int ssl_init(void)
 					 serial_lines,
 					 ARRAY_SIZE(serial_lines));
 
-	lines_init(serial_lines, sizeof(serial_lines)/sizeof(serial_lines[0]));
+	lines_init(serial_lines, ARRAY_SIZE(serial_lines));
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if (new_title != NULL)
@@ -221,16 +218,13 @@ static void ssl_exit(void)
 {
 	if (!ssl_init_done)
 		return;
-	close_lines(serial_lines,
-		    sizeof(serial_lines)/sizeof(serial_lines[0]));
+	close_lines(serial_lines, ARRAY_SIZE(serial_lines));
 }
 __uml_exitcall(ssl_exit);
 
 static int ssl_chan_setup(char *str)
 {
-	return line_setup(serial_lines,
-			  sizeof(serial_lines)/sizeof(serial_lines[0]),
-			  str, 1);
+	return line_setup(serial_lines, ARRAY_SIZE(serial_lines), str, 1);
 }
 
 __setup("ssl", ssl_chan_setup);
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2005-12-20 17:31:37.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2005-12-20 17:31:38.000000000 -0500
@@ -91,18 +91,17 @@ struct line vts[MAX_TTYS] = { LINE_INIT(
 
 static int con_config(char *str)
 {
-	return line_config(vts, sizeof(vts)/sizeof(vts[0]), str);
+	return line_config(vts, ARRAY_SIZE(vts), str);
 }
 
 static int con_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return line_get_config(dev, vts, sizeof(vts)/sizeof(vts[0]), str,
-			       size, error_out);
+	return line_get_config(dev, vts, ARRAY_SIZE(vts), str, size, error_out);
 }
 
 static int con_remove(int n)
 {
-	return line_remove(vts, sizeof(vts)/sizeof(vts[0]), n);
+	return line_remove(vts, ARRAY_SIZE(vts), n);
 }
 
 static int con_open(struct tty_struct *tty, struct file *filp)
@@ -170,7 +169,7 @@ int stdio_init(void)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
-	lines_init(vts, sizeof(vts)/sizeof(vts[0]));
+	lines_init(vts, ARRAY_SIZE(vts));
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if(new_title != NULL)
@@ -186,13 +185,13 @@ static void console_exit(void)
 {
 	if (!con_init_done)
 		return;
-	close_lines(vts, sizeof(vts)/sizeof(vts[0]));
+	close_lines(vts, ARRAY_SIZE(vts));
 }
 __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
-	return line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1);
+	return line_setup(vts, ARRAY_SIZE(vts), str, 1);
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");

