Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVLFMPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVLFMPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVLFMPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:15:25 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:31876 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964967AbVLFMPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:15:12 -0500
Date: Tue, 6 Dec 2005 10:03:28 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: [PATCH 09/10] usb-serial: removes spin lock 'lock' from usb-serial
 driver.
Message-Id: <20051206100328.58543f0f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Removes spin lock 'lock' and its initialization from the usb-serial driver.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/usb-serial.c |    2 --
 drivers/usb/serial/usb-serial.h |    2 --
 2 files changed, 4 deletions(-)

diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-12-04 20:05:26.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.c	2005-12-04 20:10:12.000000000 -0200
@@ -26,7 +26,6 @@
 #include <linux/tty_flip.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
@@ -784,7 +783,6 @@ int usb_serial_probe(struct usb_interfac
 		memset(port, 0x00, sizeof(struct usb_serial_port));
 		port->number = i + serial->minor;
 		port->serial = serial;
-		spin_lock_init(&port->lock);
 		sema_init(&port->sem, 1);
 		INIT_WORK(&port->work, usb_serial_port_softint, port);
 		serial->port[i] = port;
diff -Nparu -X /home/lcapitulino/kernels/dontdiff a/drivers/usb/serial/usb-serial.h a~/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	2005-12-04 20:08:56.000000000 -0200
+++ a~/drivers/usb/serial/usb-serial.h	2005-12-04 20:10:23.000000000 -0200
@@ -31,7 +31,6 @@
  * usb_serial_port: structure for the specific ports of a device.
  * @serial: pointer back to the struct usb_serial owner of this port.
  * @tty: pointer to the corresponding tty for this port.
- * @lock: spinlock to grab when updating portions of this structure.
  * @sem: semaphore used to synchronize serial_open() and serial_close()
  *	access for this port.
  * @number: the number of the port (the minor number).
@@ -63,7 +62,6 @@
 struct usb_serial_port {
 	struct usb_serial *	serial;
 	struct tty_struct *	tty;
-	spinlock_t		lock;
 	struct semaphore        sem;
 	unsigned char		number;
 


-- 
Luiz Fernando N. Capitulino
