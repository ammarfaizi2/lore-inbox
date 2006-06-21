Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWFUV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWFUV2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWFUV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:28:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:47286 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751445AbWFUV2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:28:19 -0400
X-Authenticated: #704063
Subject: [Patch] Off by one in drivers/usb/serial/usb-serial.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
Content-Type: text/plain
Date: Wed, 21 Jun 2006 23:28:17 +0200
Message-Id: <1150925298.24697.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity id #554. since serial table
is defines as serial_table[SERIAL_TTY_MINORS] we
should make sure we dont acess with an index
of SERIAL_TTY_MINORS.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/usb/serial/usb-serial.c.orig	2006-06-21 23:24:07.000000000 +0200
+++ linux-2.6.17-git2/drivers/usb/serial/usb-serial.c	2006-06-21 23:25:12.000000000 +0200
@@ -83,7 +83,7 @@ static struct usb_serial *get_free_seria
 
 		good_spot = 1;
 		for (j = 1; j <= num_ports-1; ++j)
-			if ((i+j >= SERIAL_TTY_MINORS) || (serial_table[i+j])) {
+			if ((i+j >= SERIAL_TTY_MINORS-1)||(serial_table[i+j])) {
 				good_spot = 0;
 				i += j;
 				break;


