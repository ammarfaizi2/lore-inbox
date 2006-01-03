Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWACINt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWACINt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 03:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWACINs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 03:13:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2959 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751221AbWACINs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 03:13:48 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: rmk+serial@arm.linux.org.uk
Subject: [PATCH] fix warning in 8250.c
Date: Tue, 3 Jan 2006 10:12:48 +0200
User-Agent: KMail/1.8.2
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BIjuD6MvX1MDQUp"
Message-Id: <200601031012.49068.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BIjuD6MvX1MDQUp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  CC      drivers/serial/8250.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: 'transmit_chars' declared inline after being called
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: previous declaration of 'transmit_chars' was here

Since this function is not small, inlining effect is way below noise floor.
Let's just remove _INLINE_.
--
vda

--Boundary-00=_BIjuD6MvX1MDQUp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.15-rc7.inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.15-rc7.inline.patch"

  CC      drivers/serial/8250.o
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: 'transmit_chars' declared inline after being called
/.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: previous declaration of 'transmit_chars' was here


diff -urpN linux-2.6.15-rc7.src/drivers/serial/8250.c linux-2.6.15-rc7.fix/drivers/serial/8250.c
--- linux-2.6.15-rc7.src/drivers/serial/8250.c	Fri Dec 30 14:18:03 2005
+++ linux-2.6.15-rc7.fix/drivers/serial/8250.c	Sun Jan  1 16:56:17 2006
@@ -1217,7 +1217,7 @@ receive_chars(struct uart_8250_port *up,
 	*status = lsr;
 }
 
-static _INLINE_ void transmit_chars(struct uart_8250_port *up)
+static void transmit_chars(struct uart_8250_port *up)
 {
 	struct circ_buf *xmit = &up->port.info->xmit;
 	int count;

--Boundary-00=_BIjuD6MvX1MDQUp--
