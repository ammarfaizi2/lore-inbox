Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWEVWIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWEVWIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWEVWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:08:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:29038 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751193AbWEVWIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:08:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ulA+E3H1A9zY7lusqeZ5z/FKj0TsJd75eE1hp15nZno8k2rOAeBYKwW2haIB+JFc67qocWtQErTzQB3D5cLwJuKoGOhzvEDDzVOwsntHbtY4jQNlC+J4/oTCTJxPCNeUrLunGE+4DdqIUX3oRjLF3liVhCdjZnaxj2tmjfbkUtk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3][resend] moxa: remove pointless casts
Date: Tue, 23 May 2006 00:09:22 +0200
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@redhat.com>, Martin Mares <mj@ucw.cz>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Moxa Technologies <support@moxa.com.tw>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230009.22548.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This patch was originaly send on 15/05-2006 - this is a resend.
 Patch still applies cleanly to 2.6.17-rc4-mm3)


Remove a bunch of pointless casts from moxa driver.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>
---

 drivers/char/mxser.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

--- linux-2.6.17-rc4-mm1-orig/drivers/char/mxser.c	2006-05-13 21:28:25.000000000 +0200
+++ linux-2.6.17-rc4-mm1/drivers/char/mxser.c	2006-05-15 22:32:50.000000000 +0200
@@ -877,7 +877,7 @@ static int mxser_init(void)
 
 static void mxser_do_softint(void *private_)
 {
-	struct mxser_struct *info = (struct mxser_struct *) private_;
+	struct mxser_struct *info = private_;
 	struct tty_struct *tty;
 
 	tty = info->tty;
@@ -972,7 +972,7 @@ static int mxser_open(struct tty_struct 
  */
 static void mxser_close(struct tty_struct *tty, struct file *filp)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 
 	unsigned long timeout;
 	unsigned long flags;
@@ -1078,7 +1078,7 @@ static void mxser_close(struct tty_struc
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	int c, total = 0;
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (!tty || !info->xmit_buf)
@@ -1114,7 +1114,7 @@ static int mxser_write(struct tty_struct
 
 static void mxser_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (!tty || !info->xmit_buf)
@@ -1141,7 +1141,7 @@ static void mxser_put_char(struct tty_st
 
 static void mxser_flush_chars(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf || (tty->hw_stopped && (info->type != PORT_16550A) && (!info->IsMoxaMustChipFlag)))
@@ -1157,7 +1157,7 @@ static void mxser_flush_chars(struct tty
 
 static int mxser_write_room(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	int ret;
 
 	ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1;
@@ -1168,13 +1168,13 @@ static int mxser_write_room(struct tty_s
 
 static int mxser_chars_in_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	return info->xmit_cnt;
 }
 
 static void mxser_flush_buffer(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	char fcr;
 	unsigned long flags;
 
@@ -1197,7 +1197,7 @@ static void mxser_flush_buffer(struct tt
 
 static int mxser_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct __user *p_cuser;
@@ -1581,7 +1581,7 @@ static int mxser_ioctl_special(unsigned 
 
 static void mxser_stoprx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 
 
@@ -1615,7 +1615,7 @@ static void mxser_stoprx(struct tty_stru
 
 static void mxser_startrx(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 
 	info->ldisc_stop_rx = 0;
@@ -1656,7 +1656,7 @@ static void mxser_startrx(struct tty_str
  */
 static void mxser_throttle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = (struct mxser_struct *)tty->driver_data;
+	//struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 	//MX_LOCK(&info->slock);
 	mxser_stoprx(tty);
@@ -1665,7 +1665,7 @@ static void mxser_throttle(struct tty_st
 
 static void mxser_unthrottle(struct tty_struct *tty)
 {
-	//struct mxser_struct *info = (struct mxser_struct *)tty->driver_data;
+	//struct mxser_struct *info = tty->driver_data;
 	//unsigned long flags;
 	//MX_LOCK(&info->slock);
 	mxser_startrx(tty);
@@ -1674,7 +1674,7 @@ static void mxser_unthrottle(struct tty_
 
 static void mxser_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	if ((tty->termios->c_cflag != old_termios->c_cflag) || (RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
@@ -1711,7 +1711,7 @@ static void mxser_set_termios(struct tty
  */
 static void mxser_stop(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1724,7 +1724,7 @@ static void mxser_stop(struct tty_struct
 
 static void mxser_start(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1740,7 +1740,7 @@ static void mxser_start(struct tty_struc
  */
 static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
 	int lsr;
 
@@ -1803,7 +1803,7 @@ static void mxser_wait_until_sent(struct
  */
 void mxser_hangup(struct tty_struct *tty)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 
 	mxser_flush_buffer(tty);
 	mxser_shutdown(info);
@@ -1821,7 +1821,7 @@ void mxser_hangup(struct tty_struct *tty
  */
 static void mxser_rs_break(struct tty_struct *tty, int break_state)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -2886,7 +2886,7 @@ static void mxser_send_break(struct mxse
 
 static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned char control, status;
 	unsigned long flags;
 
@@ -2909,7 +2909,7 @@ static int mxser_tiocmget(struct tty_str
 
 static int mxser_tiocmset(struct tty_struct *tty, struct file *file, unsigned int set, unsigned int clear)
 {
-	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
+	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
 


