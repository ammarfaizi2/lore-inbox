Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWBGPAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWBGPAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWBGPAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:00:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:5532 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965115AbWBGPAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:00:32 -0500
Date: Tue, 7 Feb 2006 08:52:03 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: rmk+serial@arm.linux.org.uk
cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 8250 serial console update uart_8250_port ier
Message-ID: <Pine.LNX.4.44.0602070848060.4804-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some embedded PowerPC (MPC834x) systems an extra byte would some times be
required to flush data out of the fifo. serial8250_console_write() was updating
the IER in hardware withouth also updating the copy in uart_8250_port. This
causes issues functions like serial8250_start_tx() and __stop_tx() to misbehave.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 0614711f0208f50e81d55283add8ae41bc332fc7
tree 1da4194744b9ca1fe59976c6ebffccfee40299eb
parent 45a38d42185df3e328e35e5167f2bfe181361db9
author Kumar Gala <galak@kernel.crashing.org> Tue, 07 Feb 2006 08:51:26 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 07 Feb 2006 08:51:26 -0600

 drivers/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 179c1f0..b1fc97d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2229,6 +2229,7 @@ serial8250_console_write(struct console 
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
+	up->ier |= UART_IER_THRI;
 	serial_out(up, UART_IER, ier | UART_IER_THRI);
 }
 

