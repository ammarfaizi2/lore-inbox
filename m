Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCaAF2>; Sun, 30 Mar 2003 19:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbTCaAF2>; Sun, 30 Mar 2003 19:05:28 -0500
Received: from dp.samba.org ([66.70.73.150]:27784 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261327AbTCaAF1>;
	Sun, 30 Mar 2003 19:05:27 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16007.34687.590218.260862@nanango.paulus.ozlabs.org>
Date: Mon, 31 Mar 2003 10:10:39 +1000 (EST)
To: petkan@users.sourceforge.net
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] small fix to pegasus.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using cpu_to_le16p on a __u8 variable is wrong, and gives a compile
warning on PPC.  It's better to use cpu_to_le16 in this case.  Here is
a patch to fix it.  Please apply.

Paul.

diff -urN linux-2.5/drivers/usb/net/pegasus.c pmac-2.5/drivers/usb/net/pegasus.c
--- linux-2.5/drivers/usb/net/pegasus.c	2003-03-21 19:48:22.000000000 +1100
+++ pmac-2.5/drivers/usb/net/pegasus.c	2003-03-21 20:49:46.000000000 +1100
@@ -233,7 +233,7 @@
 
 	pegasus->dr.bRequestType = PEGASUS_REQT_WRITE;
 	pegasus->dr.bRequest = PEGASUS_REQ_SET_REG;
-	pegasus->dr.wValue = cpu_to_le16p(&data);
+	pegasus->dr.wValue = cpu_to_le16(data);
 	pegasus->dr.wIndex = cpu_to_le16p(&indx);
 	pegasus->dr.wLength = cpu_to_le16(1);
 	pegasus->ctrl_urb->transfer_buffer_length = 1;
