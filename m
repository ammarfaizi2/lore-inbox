Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVFVGhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVFVGhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVFVGc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:32:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:26268 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262797AbVFVFWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:04 -0400
Cc: galak@freescale.com
Subject: [PATCH] I2C: Allow for sharing of the interrupt line for i2c-mpc.c
In-Reply-To: <11194174633743@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174631439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Allow for sharing of the interrupt line for i2c-mpc.c

I2C-MPC: Allow for sharing of the interrupt line

On the MPC8548 devices we have multiple I2C-MPC buses however they are on the
same interrupt line.  Made request_irq pass SA_SHIRQ now so the second bus can
register for the same IRQ.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 30aedcb33970367e50b5edf373e9cd1a5cebcbe1
tree 8b94e494c2fd0d8c874500bc1b0733eef64d831b
parent 44bbe87e9017efa050bb1b506c6822f1f3bb94d7
author Kumar Gala <galak@freescale.com> Tue, 03 May 2005 18:50:38 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:55 -0700

 drivers/i2c/busses/i2c-mpc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -325,7 +325,7 @@ static int __devinit mpc_i2c_probe(struc
 	if (i2c->irq != OCP_IRQ_NA)
 	{
 		if ((result = request_irq(ocp->def->irq, mpc_i2c_isr,
-					  0, "i2c-mpc", i2c)) < 0) {
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
@@ -424,7 +424,7 @@ static int fsl_i2c_probe(struct device *
 
 	if (i2c->irq != 0)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  0, "fsl-i2c", i2c)) < 0) {
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;

