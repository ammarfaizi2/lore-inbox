Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWHaMYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWHaMYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWHaMYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:24:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48772 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751195AbWHaMYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:24:52 -0400
Date: Thu, 31 Aug 2006 14:24:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, bluez-devel@lists.sourceforge.net
Subject: bluetooth: small cleanups
Message-ID: <20060831122440.GY3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up bluetooth a bit, no code changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 93ba25b..72a59fd 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -241,15 +236,11 @@ static int hci_uart_send_frame(struct sk
 
 static void hci_uart_destruct(struct hci_dev *hdev)
 {
-	struct hci_uart *hu;
-
 	if (!hdev)
 		return;
 
 	BT_DBG("%s", hdev->name);
-
-	hu = (struct hci_uart *) hdev->driver_data;
-	kfree(hu);
+	kfree(hdev->driver_data);
 }
 
 /* ------ LDISC part ------ */
@@ -272,7 +263,7 @@ static int hci_uart_tty_open(struct tty_
 		return -EEXIST;
 
 	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
-		BT_ERR("Can't allocate controll structure");
+		BT_ERR("Can't allocate control structure");
 		return -ENFILE;
 	}
 
@@ -360,7 +351,7 @@ static void hci_uart_tty_wakeup(struct t
  *     
  * Return Value:    None
  */
-static void hci_uart_tty_receive(struct tty_struct *tty, const __u8 *data, char *flags, int count)
+static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
 {
 	struct hci_uart *hu = (void *)tty->disc_data;
 
@@ -371,11 +362,11 @@ static void hci_uart_tty_receive(struct 
 		return;
 
 	spin_lock(&hu->rx_lock);
 	hu->proto->recv(hu, (void *) data, count);
 	hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
-	if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) && tty->driver->unthrottle)
+	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags) && tty->driver->unthrottle)
 		tty->driver->unthrottle(tty);
 }
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
