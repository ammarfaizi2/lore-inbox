Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUDJPlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUDJPlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 11:41:10 -0400
Received: from smtp-out-1.tiscali.it ([212.123.84.26]:23209 "EHLO
	rlx-1-3-5.tiscali.it") by vger.kernel.org with ESMTP
	id S262052AbUDJPlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 11:41:05 -0400
Date: Sat, 10 Apr 2004 17:41:07 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ID for ftdi_sio
Message-ID: <20040410154107.GA3983@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040408165123.GA11376@dreamland.darkstar.lan> <20040409191450.GB17546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040409191450.GB17546@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Apr 09, 2004 at 12:14:50PM -0700, Greg KH ha scritto: 
> On Thu, Apr 08, 2004 at 06:51:23PM +0200, Kronos wrote:
> > Hi,
> > I have an USB contactless reader which uses a FTDI chip. It works well with the
> > current ftdi_sio driver, it's just a matter of adding an ID:
> 
> Ick, this patch doesn't apply due to all of the recent ids being added
> to this driver.  Can you re-diff it against the latest -mm tree and
> resend it to me?

Here it is:

--- linux-2.6/drivers/usb/serial/ftdi_sio.h.orig	2004-04-10 17:35:27.000000000 +0200
+++ linux-2.6/drivers/usb/serial/ftdi_sio.h	2004-04-10 17:36:47.000000000 +0200
@@ -191,6 +191,9 @@
 #define LINX_FUTURE_1_PID   0xF44B   /* Linx future device */
 #define LINX_FUTURE_2_PID   0xF44C   /* Linx future device */
 
+/* Inside Accesso contactless reader (http://www.insidefr.com) */
+#define INSIDE_ACCESSO		0xFAD0
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */
--- linux-2.6/drivers/usb/serial/ftdi_sio.c.orig	2004-04-10 17:36:52.000000000 +0200
+++ linux-2.6/drivers/usb/serial/ftdi_sio.c	2004-04-10 17:38:07.000000000 +0200
@@ -354,6 +354,7 @@
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_3, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_4, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UO100_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, INSIDE_ACCESSO, 0, 0x3ff) },
 	{ }						/* Terminating entry */
 };
 
@@ -558,6 +559,7 @@
  	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_0_PID, 0x400, 0xffff) },
  	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_1_PID, 0x400, 0xffff) },
  	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_2_PID, 0x400, 0xffff) },
+	{ USB_DEVICE(FTDI_VID, INSIDE_ACCESSO) },
 	{ }						/* Terminating entry */
 };
 


Luca
-- 
Home: http://kronoz.cjb.net
Al termine di un pranzo di nozze mi hanno dato un
amaro alle erbe cosi' schifoso che perfino sull'etichetta
c'era un frate che vomitava.
