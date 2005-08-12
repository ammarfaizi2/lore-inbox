Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVHLQdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVHLQdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVHLQdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:33:13 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:12711 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751231AbVHLQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:33:13 -0400
Date: Fri, 12 Aug 2005 11:32:57 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linuppc-embedded@freescale.com,
       vbordug@ru.mvista.com
Subject: [PATCH] cpm_uart: Fix spinlock initialization
Message-ID: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lack of spin_lock_init causes badness in the preempt configuration.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d6dee08c314c1952921adc99e8f5ff6c332341ef
tree 96ca76ab7d75cf808287af50c88ed7d1aed49923
parent 51a75dcea8fe0407f06467de36e258616cda68f9
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 11:26:44 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 12 Aug 2005 11:26:44 -0500

 drivers/serial/cpm_uart/cpm_uart_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1087,6 +1087,7 @@ static int __init cpm_uart_console_setup
 	port =
 	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
 	pinfo = (struct uart_cpm_port *)port;
+	spin_lock_init(&port->lock);
 
 	pinfo->flags |= FLAG_CONSOLE;
 
