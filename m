Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUAUXdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUAUXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:31:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:254 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S266190AbUAUXbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:31:04 -0500
Date: Wed, 21 Jan 2004 15:31:02 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: [BUG 2.6.1] missing 'console_driver' with CONFIG_VT but no CONFIG_VT_CONSOLE
Message-ID: <20040121153102.D29705@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


See drivers/char/vt.c.

'console_driver' is defined only when CONFIG_VT_CONSOLE is set.
However it is used by vty_init() which is outside the scope
of CONFIG_VT_CONSOLE.

I think the fix is to move console_driver definition outside
CONFIG_VT_CONSOLE.  See the attachment.  Hopefully someone with
more knowledge on this can validate that.

Jun

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru drivers/char/vt.c.orig drivers/char/vt.c
--- drivers/char/vt.c.orig	Wed Nov  5 14:29:51 2003
+++ drivers/char/vt.c	Wed Jan 21 15:27:06 2004
@@ -2086,6 +2086,8 @@
 	schedule_console_callback();
 }
 
+struct tty_driver *console_driver;
+
 #ifdef CONFIG_VT_CONSOLE
 
 /*
@@ -2185,8 +2187,6 @@
 	clear_bit(0, &printing);
 }
 
-struct tty_driver *console_driver;
-
 static struct tty_driver *vt_console_device(struct console *c, int *index)
 {
 	*index = c->index ? c->index-1 : fg_console;

--fUYQa+Pmc3FrFX/N--
