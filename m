Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbTFNDfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 23:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265606AbTFNDfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 23:35:39 -0400
Received: from dixville.unh.edu ([132.177.137.38]:14545 "EHLO dixville.unh.edu")
	by vger.kernel.org with ESMTP id S265605AbTFNDfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 23:35:38 -0400
Date: Fri, 13 Jun 2003 23:49:20 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [trivial patch][2.5] rmmod 8250 oopses
Message-ID: <20030614034920.GB5364@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.7, required 5,
	BAYES_01, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Removing serial driver modules would oops, please apply:

--- linux-2.5.70-bk12/drivers/serial/core.c	2003-06-13 23:43:26.000000000 -0400
+++ linux-2.5.70-bk12-perso/drivers/serial/core.c	2003-06-13 23:45:06.000000000 -0400
@@ -2189,11 +2189,11 @@
 void uart_unregister_driver(struct uart_driver *drv)
 {
 	struct tty_driver *p = drv->tty_driver;
-	drv->tty_driver = NULL;
 	tty_unregister_driver(p);
 	kfree(drv->state);
 	kfree(drv->tty_driver->termios);
 	kfree(drv->tty_driver);
+	drv->tty_driver = NULL;
 }
 
 struct tty_driver *uart_console_device(struct console *co, int *index)
