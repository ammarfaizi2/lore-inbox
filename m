Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268670AbRHBDqu>; Wed, 1 Aug 2001 23:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268681AbRHBDql>; Wed, 1 Aug 2001 23:46:41 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:22995 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268670AbRHBDq1>; Wed, 1 Aug 2001 23:46:27 -0400
Message-ID: <3B68CD17.7B32617F@yahoo.co.uk>
Date: Wed, 01 Aug 2001 23:46:31 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH to fix bug: "serial" does not show up in /proc/interrupts
Content-Type: multipart/mixed;
 boundary="------------52B06FAF0E5F0699FF3AC080"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------52B06FAF0E5F0699FF3AC080
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sorry ... here is the same patch but with the diff done
from the parent of the code hierarchy.

---------------------------------------------------
--- linux-2.4.7-ac3/drivers/char/serial.c_ORIG  Wed Aug  1 23:02:09 2001
+++ linux-2.4.7-ac3/drivers/char/serial.c       Wed Aug  1 23:11:01 2001
@@ -4852,10 +4852,13 @@

 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);

+/* serial_pci_driver_name[] gets truncated to ""  if the pci probe fails */
+static char serial_pci_driver_name[] = "serial";
+
 static struct pci_driver serial_pci_driver = {
-       name:           "serial",
+       name:           serial_pci_driver_name,
        probe:          serial_init_one,
-       remove:        serial_remove_one,
+       remove:         serial_remove_one,
        id_table:       serial_pci_tbl,
 };
---------------------------------------------------

> Here is a patch to fix the serial driver so that its name
> appears in /proc/interrupts.  The bug was caused by code
> that was overwriting the string literal "serial" with "".
> gcc merges all the "serial" strings together into one, so
> the "serial" sent to irq_request() was being ""ed as a
> side-effect.
> 
> Here is the patch to 2.4.7-ac3 both inline and attached.
> // Thomas Hood  <jdthood_AT_yahoo.co.uk>
--------------52B06FAF0E5F0699FF3AC080
Content-Type: text/plain; charset=us-ascii;
 name="toms-serial-patch-20010801-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toms-serial-patch-20010801-2"

--- linux-2.4.7-ac3/drivers/char/serial.c_ORIG	Wed Aug  1 23:02:09 2001
+++ linux-2.4.7-ac3/drivers/char/serial.c	Wed Aug  1 23:11:01 2001
@@ -4852,10 +4852,13 @@
 
 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
 
+/* serial_pci_driver_name[] gets truncated to ""  if the pci probe fails */
+static char serial_pci_driver_name[] = "serial";
+
 static struct pci_driver serial_pci_driver = {
-       name:           "serial",
+       name:           serial_pci_driver_name,
        probe:          serial_init_one,
-       remove:	       serial_remove_one,
+       remove:         serial_remove_one,
        id_table:       serial_pci_tbl,
 };
 

--------------52B06FAF0E5F0699FF3AC080--

