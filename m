Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946381AbWJSTDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946381AbWJSTDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946382AbWJSTDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:03:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:46246 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946381AbWJSTDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:03:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=MmEY6yj0UDfXnIgvCbuV4TzSnzWg4ykbT6UhRmb6LhiZFS3kqA9t0IfQOYEn4db1y7lUzKVtPTY43tt5w+orqmdSZqqKZjloEbaV8HDbpNtC5HfEQwxkPJSt+dFDKHcgniKtatCJgVZHznvybmG0opf6zosXGW2NOo/2h6DDhNM=
Message-ID: <4537CBE3.4080809@gmail.com>
Date: Thu, 19 Oct 2006 12:02:59 -0700
From: David KOENIG <karhudever@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH] Replaced tty->driver_data lines with pci_get_drvdata(tty);
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- From 19b980cb8ac383534e30ec948f03c3fff11da5f1 Mon Sep 17 00:00:00 2001
From: David KOENIG <karhudever@gmail.com>
Date: Thu, 19 Oct 2006 11:55:21 -0700
Subject: [PATCH] Replaced tty->driver_data lines with pci_get_drvdata(tty);

- ---
 fs/compat_ioctl.c            |    2 +-
 net/irda/ircomm/ircomm_tty.c |   24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a91f262..b7c2746 100644
- --- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1270,7 +1270,7 @@ static int do_kdfontop_ioctl(unsigned in
 		return -EPERM;
 	op.data = compat_ptr(((struct console_font_op32 *)&op)->data);
 	op.flags |= KD_FONT_FLAG_OLD;
- -	vc = ((struct tty_struct *)file->private_data)->driver_data;
+	vc = pci_get_drvdata((struct tty_struct *)file->private_data);
 	i = con_font_op(vc, &op);
 	if (i)
 		return i;
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index d50a020..ce7e87a 100644
- --- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -416,7 +416,7 @@ static int ircomm_tty_open(struct tty_st
 	spin_lock_irqsave(&self->spinlock, flags);
 	self->open_count++;

- -	tty->driver_data = self;
+	pci_set_drvdata(tty, self);
 	self->tty = tty;
 	spin_unlock_irqrestore(&self->spinlock, flags);

@@ -490,7 +490,7 @@ #endif
  */
 static void ircomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long flags;

 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
@@ -581,7 +581,7 @@ static void ircomm_tty_close(struct tty_
  */
 static void ircomm_tty_flush_buffer(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);

 	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -670,7 +670,7 @@ static void ircomm_tty_do_softint(void *
 static int ircomm_tty_write(struct tty_struct *tty,
 			    const unsigned char *buf, int count)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long flags;
 	struct sk_buff *skb;
 	int tailroom = 0;
@@ -802,7 +802,7 @@ #endif
  */
 static int ircomm_tty_write_room(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long flags;
 	int ret;

@@ -842,7 +842,7 @@ #endif
  */
 static void ircomm_tty_wait_until_sent(struct tty_struct *tty, int timeout)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long orig_jiffies, poll_time;
 	unsigned long flags;
 	
@@ -879,7 +879,7 @@ static void ircomm_tty_wait_until_sent(s
  */
 static void ircomm_tty_throttle(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);

 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );

@@ -910,7 +910,7 @@ static void ircomm_tty_throttle(struct t
  */
 static void ircomm_tty_unthrottle(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);

 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );

@@ -940,7 +940,7 @@ static void ircomm_tty_unthrottle(struct
  */
 static int ircomm_tty_chars_in_buffer(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long flags;
 	int len = 0;

@@ -1004,7 +1004,7 @@ static void ircomm_tty_shutdown(struct i
  */
 static void ircomm_tty_hangup(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);
 	unsigned long	flags;

 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
@@ -1047,7 +1047,7 @@ static void ircomm_tty_send_xchar(struct
  */
 void ircomm_tty_start(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);

 	ircomm_flow_request(self->ircomm, FLOW_START);
 }
@@ -1060,7 +1060,7 @@ void ircomm_tty_start(struct tty_struct
  */
 static void ircomm_tty_stop(struct tty_struct *tty)
 {
- -	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *)
pci_get_drvdata(tty);

 	IRDA_ASSERT(self != NULL, return;);
 	IRDA_ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
- --
1.4.2


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFN8vimhCgVPlWJY8RAow2AJ92boLp2ooOHk8wUIKe0rn8jTB+LQCeN/QU
Lw1GZZa1TAWMDbv0H+xzpkk=
=ykL2
-----END PGP SIGNATURE-----
