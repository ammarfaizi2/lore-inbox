Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131212AbRATLE5>; Sat, 20 Jan 2001 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132973AbRATLEr>; Sat, 20 Jan 2001 06:04:47 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:26508 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131212AbRATLEd>; Sat, 20 Jan 2001 06:04:33 -0500
Date: Sat, 20 Jan 2001 03:04:30 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: wolfgang@ces.ch, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] linux-2.4.1-pre9/drivers/usb/serial/mct_u232.c usb_device_id table broken by new format
Message-ID: <20010120030430.A3456@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	The format of usb_device_id tables was recently changed
(just before 2.4.0, I think) to include a match_flags field.  A bit
set to one in that field indicates that a given member of the structure
contains a valid value that must match.  A bit set to zero indicates
a wildcard (skip the comparison).  Compiling a driver that uses the old
format results in that driver having a usb_device_id structure that
has an all zeroes match_flags, which means don't compare anything.
That is, it is a completely wildcard and will match every USB interface.

	As of 2.4.1-pre9, there appears to be only USB driver that
was missed: drivers/usb/serial/mct_u232.c.  This patch fixes the problem.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-mct.diff"

--- linux-2.4.1-pre9/drivers/usb/serial/mct_u232.c	Thu Dec  7 16:13:38 2000
+++ linux/drivers/usb/serial/mct_u232.c	Sat Jan 20 02:52:44 2001
@@ -102,7 +102,7 @@
  * All of the device info needed for the MCT USB-RS232 converter.
  */
 static __devinitdata struct usb_device_id id_table [] = {
-	{ idVendor: MCT_U232_VID, idProduct: MCT_U232_PID },
+	{ USB_DEVICE(MCT_U232_VID, MCT_U232_PID) },
 	{ }					/* Terminating entry */
 };
 

--ReaqsoxgOBHFXBhH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
