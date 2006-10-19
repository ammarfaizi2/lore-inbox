Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWJSIot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWJSIot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWJSIot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:44:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030326AbWJSIos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:44:48 -0400
Date: Thu, 19 Oct 2006 01:44:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 185] Sometimes kernel freezes sometime lists OOPS -
 hostap_cs
Message-Id: <20061019014446.36410c81.akpm@osdl.org>
In-Reply-To: <200610191012.49544.cijoml@volny.cz>
References: <200610171747.34177.cijoml@volny.cz>
	<20061018235604.47886be9.akpm@osdl.org>
	<200610191012.49544.cijoml@volny.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 10:12:49 +0200
CIJOML <cijoml@volny.cz> wrote:

> it is nsc-ircc:
> 
> nsc-ircc, chip->init
> nsc-ircc, Found chip at base=0x02e
> nsc-ircc, driver loaded (Dag Brattli)
> nsc-ircc, Using dongle: HP HSDL-2300, HP HSDL-3600/HSDL-3610

Well you could try this I suppose...

--- a/drivers/net/irda/nsc-ircc.c~a
+++ a/drivers/net/irda/nsc-ircc.c
@@ -2160,7 +2160,8 @@ static int nsc_ircc_net_open(struct net_
 	
 	iobase = self->io.fir_base;
 	
-	if (request_irq(self->io.irq, nsc_ircc_interrupt, 0, dev->name, dev)) {
+	if (request_irq(self->io.irq, nsc_ircc_interrupt, IRQF_SHARED,
+			dev->name, dev)) {
 		IRDA_WARNING("%s, unable to allocate irq=%d\n",
 			     driver_name, self->io.irq);
 		return -EAGAIN;
@@ -2354,7 +2355,7 @@ static int nsc_ircc_resume(struct platfo
 	nsc_ircc_init_dongle_interface(self->io.fir_base, self->io.dongle_id);
 
 	if (netif_running(self->netdev)) {
-		if (request_irq(self->io.irq, nsc_ircc_interrupt, 0,
+		if (request_irq(self->io.irq, nsc_ircc_interrupt, IRQF_SHARED,
 				self->netdev->name, self->netdev)) {
  		    	IRDA_WARNING("%s, unable to allocate irq=%d\n",
 				     driver_name, self->io.irq);
_


Did this all work under any previous kernel?  If so, which version?

It'd be useful to see the full `dmesg -s 1000000' output for both good and
bad kernels, and /proc/interrupts for the good kernel.

