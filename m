Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVLHO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVLHO6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVLHO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:58:23 -0500
Received: from ns.suse.de ([195.135.220.2]:30441 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932176AbVLHO6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:58:23 -0500
Date: Thu, 8 Dec 2005 15:58:21 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051208145821.GA15169@suse.de>
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk> <43953440.9070102@in.ibm.com> <20051206171633.GB19664@flint.arm.linux.org.uk> <20051207222246.GA22558@suse.de> <20051207233911.GP6793@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051207233911.GP6793@flint.arm.linux.org.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Dec 07, Russell King wrote:

> Easily.  Have a look at the internals of uart_handle_break() in
> include/linux/serial_core.h

This one works for me, tested with 2.6.5.


 drivers/serial/8250.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.15-rc5-olh/drivers/serial/8250.c
===================================================================
--- linux-2.6.15-rc5-olh.orig/drivers/serial/8250.c
+++ linux-2.6.15-rc5-olh/drivers/serial/8250.c
@@ -1154,6 +1154,13 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
+		/* Handle the SysRq ^O Hack, but only on the system console */
+		if (ch == '\x0f' && uart_handle_break(&up->port))
+			goto ignore_char;
+#endif
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
