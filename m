Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbVJTGDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbVJTGDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbVJTGDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:03:20 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:27662
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S1751757AbVJTGDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:03:19 -0400
From: David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.13092.785385.20266@dl2.hq2.avtrex.com>
Date: Wed, 19 Oct 2005 23:03:16 -0700
To: linux-mips@linux-mips.org
CC: linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 3/11 serial/8250 Set UART_CAP_FIFO in early_serial_setup
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

The Xilleon's (32bit MIPS SOC) serial ports do not work right if the
fifo is not enabled.  This prevented early serial support from
working.

The fix is to set UART_CAP_FIFO in early_serial_setup iff the hardware
says it supports it.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Set UART_CAP_FIFO in early_serial_setup() if the port has that
capability.  Needed by xilleon port.

---
commit e65836c84865cbcf3abc445984bacc583624e347
tree 9c198c5858e4c8c500327e7947c69921355dea9b
parent 2a66e82b3d2b02aca88cc2f60286fba0c114139d
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 14:02:44 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 14:02:44 -0700

 drivers/serial/8250.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2283,6 +2283,8 @@ int __init early_serial_setup(struct uar
 	serial8250_isa_init_ports();
 	serial8250_ports[port->line].port	= *port;
 	serial8250_ports[port->line].port.ops	= &serial8250_pops;
+        if (uart_config[port->type].flags & UART_CAP_FIFO)
+            serial8250_ports[port->line].capabilities |= UART_CAP_FIFO;
 	return 0;
 }
 





