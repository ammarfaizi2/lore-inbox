Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDJJBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDJJBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWDJJBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:01:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:50561 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750857AbWDJJBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:01:09 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: smurf@smurf.noris.de
Content-Type: text/plain
Date: Mon, 10 Apr 2006 11:01:06 +0200
Message-Id: <1144659666.15586.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since the arrays are declared as in_urbs[N_IN_URB]
and out_urbs[N_OUT_URB] both for loops, go one
over the end of the array. This fixes coverity id #555

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.17-rc1/drivers/usb/serial/option.c.orig	2006-04-10 10:57:13.000000000 +0200
+++ linux-2.6.17-rc1/drivers/usb/serial/option.c	2006-04-10 10:57:46.000000000 +0200
@@ -582,14 +582,14 @@ static void option_setup_urbs(struct usb
 	portdata = usb_get_serial_port_data(port);
 
 	/* Do indat endpoints first */
-	for (j = 0; j <= N_IN_URB; ++j) {
+	for (j = 0; j < N_IN_URB; ++j) {
 		portdata->in_urbs[j] = option_setup_urb (serial,
                   port->bulk_in_endpointAddress, USB_DIR_IN, port,
                   portdata->in_buffer[j], IN_BUFLEN, option_indat_callback);
 	}
 
 	/* outdat endpoints */
-	for (j = 0; j <= N_OUT_URB; ++j) {
+	for (j = 0; j < N_OUT_URB; ++j) {
 		portdata->out_urbs[j] = option_setup_urb (serial,
                   port->bulk_out_endpointAddress, USB_DIR_OUT, port,
                   portdata->out_buffer[j], OUT_BUFLEN, option_outdat_callback);


