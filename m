Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVATPKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVATPKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVATPKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:10:09 -0500
Received: from users.linvision.com ([62.58.92.114]:38039 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262150AbVATPJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:09:08 -0500
Date: Thu, 20 Jan 2005 15:54:22 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: lkml@bitwizard.nl, greg@kroah.com, bryder@sgi.com, kuba@mareimbrium.org,
       ftdi-usb-sio-devel@lists.sourceforge.net
Cc: edwin@harddisk-recovery.nl
Subject: Bug when using custom baud rates.... 
Message-ID: <20050120145422.GB18037@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When using custom baud rates, the code does: 


       if ((new_serial.baud_base != priv->baud_base) ||
            (new_serial.baud_base < 9600))
                return -EINVAL;

Which translates to english as: 

	If you changed the baud-base, OR the new one is
	invalid, return invalid. 

but it should be:

	If you changed the baud-base, OR the new one is
	invalid, return invalid. 

Patch attached. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ftdi_fix

diff -ur linux-2.4.28.clean/drivers/usb/serial/ftdi_sio.c linux-2.4.28.ftdi_fix/drivers/usb/serial/ftdi_sio.c
--- linux-2.4.28.clean/drivers/usb/serial/ftdi_sio.c	Wed Jan 19 16:31:03 2005
+++ linux-2.4.28.ftdi_fix/drivers/usb/serial/ftdi_sio.c	Thu Jan 20 15:47:49 2005
@@ -981,7 +981,7 @@
 		goto check_and_exit;
 	}
 
-	if ((new_serial.baud_base != priv->baud_base) ||
+	if ((new_serial.baud_base != priv->baud_base) &&
 	    (new_serial.baud_base < 9600))
 		return -EINVAL;
 
Only in linux-2.4.28.ftdi_fix/drivers/usb/serial: ftdi_sio.c~

--8t9RHnE3ZwKMSgU+--
