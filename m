Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTGVMXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 08:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbTGVMXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 08:23:24 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:30892 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S270805AbTGVMXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 08:23:22 -0400
Date: Tue, 22 Jul 2003 14:38:21 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] Non-ASCII chars in visor.c messages
Message-ID: <20030722143821.C26218@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

what is the general opinion on printing non-ASCII characters in kernel
messages? I think kernel should print either pure ASCII messages, or
at least UTF-8-encoded ones.

	The visor.c module contains three messages
with non-ASCII character ("e" with acute above, encoded in
ISO 8859-1, in the name of "Sony Clie'" handheld). I propose the attached
patch, which works in all environments (altough UTF-8 variant would be
IMHO fine as well).

	What do you think about it?

-Yenya

--- linux-2.6.0-test1/drivers/usb/serial/visor.c.orig	2003-07-22 14:30:18.835081416 +0200
+++ linux-2.6.0-test1/drivers/usb/serial/visor.c	2003-07-22 14:30:41.597620984 +0200
@@ -169,7 +169,7 @@
  */
 #define DRIVER_VERSION "v2.1"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>"
-#define DRIVER_DESC "USB HandSpring Visor, Palm m50x, Sony Clié driver"
+#define DRIVER_DESC "USB HandSpring Visor, Palm m50x, Sony Clie driver"
 
 /* function prototypes for a handspring visor */
 static int  visor_open		(struct usb_serial_port *port, struct file *filp);
@@ -275,7 +275,7 @@
 /* All of the device info needed for the Handspring Visor, and Palm 4.0 devices */
 static struct usb_serial_device_type handspring_device = {
 	.owner =		THIS_MODULE,
-	.name =			"Handspring Visor / Treo / Palm 4.0 / Clié 4.x",
+	.name =			"Handspring Visor / Treo / Palm 4.0 / Clie 4.x",
 	.short_name =		"visor",
 	.id_table =		id_table,
 	.num_interrupt_in =	NUM_DONT_CARE,
@@ -303,7 +303,7 @@
 /* device info for the Sony Clie OS version 3.5 */
 static struct usb_serial_device_type clie_3_5_device = {
 	.owner =		THIS_MODULE,
-	.name =			"Sony Clié 3.5",
+	.name =			"Sony Clie 3.5",
 	.short_name =		"clie_3.5",
 	.id_table =		clie_id_3_5_table,
 	.num_interrupt_in =	0,

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|__ If you want "aesthetics", go play with microkernels. -Linus Torvalds __|
