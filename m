Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbTDJVTM (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTDJVTM (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:19:12 -0400
Received: from palrel11.hp.com ([156.153.255.246]:29155 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264170AbTDJVTL (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:19:11 -0400
Date: Thu, 10 Apr 2003 14:30:53 -0700
To: Russell King <rmk@arm.linux.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5] Minor fix for driver/serial/core.c
Message-ID: <20030410213053.GA8537@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Russell,

	The following command will do nothing at all on 2.5.X :
		setserial /dev/ttyS0 uart none

	I sent you the bug fix for that a few months ago, but as
2.5.67 this trivial bug is still not fixed. The patch is below...

	Have fun...

	Jean

---------------------------------------------------------

--- linux/drivers/serial/core.d1.c      Thu Apr 10 14:16:47 2003
+++ linux/drivers/serial/core.c Thu Apr 10 14:24:01 2003
@@ -784,6 +784,9 @@ uart_set_info(struct uart_state *state, 
                 */
                if (port->type != PORT_UNKNOWN)
                        retval = port->ops->request_port(port);
+               else
+                       /* Always success - Jean II */
+                       retval = 0;
 
                /*
                 * If we fail to request resources for the

	
