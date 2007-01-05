Return-Path: <linux-kernel-owner+w=401wt.eu-S1161148AbXAERKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbXAERKd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbXAERKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:10:33 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:51007 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161148AbXAERKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:10:32 -0500
Message-id: <16079316021425814645@wsc.cz>
Subject: [PATCH 1/7] Char: moxa, macros cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri,  5 Jan 2007 18:10:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, macros cleanup

Remove yet defined or unused macros and whitespace cleanup around the rest.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 49a3eb961ed6dca0e44778f26910e9e4ed6fd491
tree 4821c6a4d633c3421c0636d245209a8019b88f73
parent a2336fb414c46f0eaf7e6868141ab26b143ed4ce
author Jiri Slaby <jirislaby@gmail.com> Wed, 03 Jan 2007 12:25:16 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 05 Jan 2007 17:38:42 +0059

 drivers/char/moxa.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 42de5bf..da2a1d1 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -46,23 +46,20 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-#define		MOXA_VERSION		"5.1k"
+#define MOXA_VERSION		"5.1k"
 
-#define MOXAMAJOR       172
-#define MOXACUMAJOR     173
+#define MOXAMAJOR		172
+#define MOXACUMAJOR		173
 
-#define put_to_user(arg1, arg2) put_user(arg1, (unsigned long *)arg2)
-#define get_from_user(arg1, arg2) get_user(arg1, (unsigned int *)arg2)
-
-#define MAX_BOARDS 		4	/* Don't change this value */
+#define MAX_BOARDS		4	/* Don't change this value */
 #define MAX_PORTS_PER_BOARD	32	/* Don't change this value */
-#define MAX_PORTS 		128	/* Don't change this value */
+#define MAX_PORTS		(MAX_BOARDS * MAX_PORTS_PER_BOARD)
 
 /*
  *    Define the Moxa PCI vendor and device IDs.
  */
-#define MOXA_BUS_TYPE_ISA		0
-#define MOXA_BUS_TYPE_PCI		1
+#define MOXA_BUS_TYPE_ISA	0
+#define MOXA_BUS_TYPE_PCI	1
 
 enum {
 	MOXA_BOARD_C218_PCI = 1,
@@ -157,13 +154,8 @@ static struct mxser_mstatus GMStatus[MAX_PORTS];
 
 #define SERIAL_DO_RESTART
 
-
-#define SERIAL_TYPE_NORMAL	1
-
 #define WAKEUP_CHARS		256
 
-#define PORTNO(x)		((x)->index)
-
 static int verbose = 0;
 static int ttymajor = MOXAMAJOR;
 /* Variables for insmod */
@@ -461,7 +453,7 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	int port;
 	int retval;
 
-	port = PORTNO(tty);
+	port = tty->index;
 	if (port == MAX_PORTS) {
 		return (0);
 	}
@@ -499,7 +491,7 @@ static void moxa_close(struct tty_struct *tty, struct file *filp)
 	struct moxa_str *ch;
 	int port;
 
-	port = PORTNO(tty);
+	port = tty->index;
 	if (port == MAX_PORTS) {
 		return;
 	}
@@ -663,7 +655,7 @@ static int moxa_tiocmget(struct tty_struct *tty, struct file *file)
 	int port;
 	int flag = 0, dtr, rts;
 
-	port = PORTNO(tty);
+	port = tty->index;
 	if ((port != MAX_PORTS) && (!ch))
 		return (-EINVAL);
 
@@ -689,7 +681,7 @@ static int moxa_tiocmset(struct tty_struct *tty, struct file *file,
 	int port;
 	int dtr, rts;
 
-	port = PORTNO(tty);
+	port = tty->index;
 	if ((port != MAX_PORTS) && (!ch))
 		return (-EINVAL);
 
@@ -714,7 +706,7 @@ static int moxa_ioctl(struct tty_struct *tty, struct file *file,
 	void __user *argp = (void __user *)arg;
 	int retval;
 
-	port = PORTNO(tty);
+	port = tty->index;
 	if ((port != MAX_PORTS) && (!ch))
 		return (-EINVAL);
 
@@ -1361,9 +1353,6 @@ static void receive_data(struct moxa_str *ch)
 /*
  *    Query
  */
-#define QueryPort	MAX_PORTS
-
-
 
 struct mon_str {
 	int tick;
@@ -1475,7 +1464,7 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 	int MoxaPortTxQueue(int), MoxaPortRxQueue(int);
 	void __user *argp = (void __user *)arg;
 
-	if (port == QueryPort) {
+	if (port == MAX_PORTS) {
 		if ((cmd != MOXA_GET_CONF) && (cmd != MOXA_INIT_DRIVER) &&
 		    (cmd != MOXA_LOAD_BIOS) && (cmd != MOXA_FIND_BOARD) && (cmd != MOXA_LOAD_C320B) &&
 		 (cmd != MOXA_LOAD_CODE) && (cmd != MOXA_GETDATACOUNT) &&
