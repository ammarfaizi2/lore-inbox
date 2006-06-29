Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWF2TUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWF2TUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWF2TUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:20:20 -0400
Received: from [141.84.69.5] ([141.84.69.5]:22544 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932263AbWF2TUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:18 -0400
Date: Thu, 29 Jun 2006 21:19:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix ISTALLION=y
Message-ID: <20060629191937.GK19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following problems:

<--  snip  -->

...
  CC      drivers/char/istallion.o
drivers/char/istallion.c: In function ‘stli_initbrds’:
drivers/char/istallion.c:4150: error: implicit declaration of function ‘stli_parsebrd’
drivers/char/istallion.c:4150: error: ‘stli_brdsp’ undeclared (first use in this function)
drivers/char/istallion.c:4150: error: (Each undeclared identifier is reported only once
drivers/char/istallion.c:4150: error: for each function it appears in.)
drivers/char/istallion.c:4164: error: implicit declaration of function ‘stli_argbrds’

<--  snip  -->

While I was at it, I also removed the #ifdef MODULE around the 
initialation code to allow it to perhaps work when built into the 
kernel and made a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/istallion.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- linux-2.6.17-mm4-full/drivers/char/istallion.c.old	2006-06-29 11:36:43.000000000 +0200
+++ linux-2.6.17-mm4-full/drivers/char/istallion.c	2006-06-29 11:49:32.000000000 +0200
@@ -283,7 +283,6 @@
 
 /*****************************************************************************/
 
-#ifdef MODULE
 /*
  *	Define some string labels for arguments passed from the module
  *	load line. These allow for easy board definitions, and easy
@@ -382,8 +381,6 @@
 module_param_array(board3, charp, NULL, 0);
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,memaddr]");
 
-#endif
-
 /*
  *	Set up a default memory address table for EISA board probing.
  *	The default addresses are all bellow 1Mbyte, which has to be the
@@ -644,14 +641,8 @@
  *	Prototype all functions in this driver!
  */
 
-#ifdef MODULE
-static void	stli_argbrds(void);
 static int	stli_parsebrd(stlconf_t *confp, char **argp);
-
-static unsigned long	stli_atol(char *str);
-#endif
-
-int		stli_init(void);
+static int	stli_init(void);
 static int	stli_open(struct tty_struct *tty, struct file *filp);
 static void	stli_close(struct tty_struct *tty, struct file *filp);
 static int	stli_write(struct tty_struct *tty, const unsigned char *buf, int count);
@@ -787,8 +778,6 @@
 
 static struct class *istallion_class;
 
-#ifdef MODULE
-
 /*
  *	Loadable module initialization stuff.
  */
@@ -958,8 +947,6 @@
 	return(1);
 }
 
-#endif
-
 /*****************************************************************************/
 
 static int stli_open(struct tty_struct *tty, struct file *filp)
@@ -4698,7 +4685,7 @@
 
 /*****************************************************************************/
 
-int __init stli_init(void)
+static int __init stli_init(void)
 {
 	int i;
 	printk(KERN_INFO "%s: version %s\n", stli_drvtitle, stli_drvversion);

