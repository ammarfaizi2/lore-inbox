Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVAHICb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVAHICb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVAHHwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:52:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:37509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261846AbVAHFsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:11 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163257205@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <11051632573313@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.48, 2005/01/06 17:27:58-08:00, david-b@pacbell.net

[PATCH] USB: fix serial gadget oops during enumeration

This prevents the serial gadget driver from oopsing during enumeration
when spinlocks are configured, and slab poisoning is active...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
--- a/drivers/usb/gadget/serial.c	2005-01-07 15:38:19 -08:00
+++ b/drivers/usb/gadget/serial.c	2005-01-07 15:38:19 -08:00
@@ -2322,11 +2322,11 @@
 					wake_up_interruptible(&port->port_tty->read_wait);
 					wake_up_interruptible(&port->port_tty->write_wait);
 				}
+				spin_unlock_irqrestore(&port->port_lock, flags);
 			} else {
 				kfree(port);
 			}
 
-			spin_unlock_irqrestore(&port->port_lock, flags);
 		}
 	}
 }

