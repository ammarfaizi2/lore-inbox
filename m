Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbUBZQCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUBZP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:59:54 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59147 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262802AbUBZP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:59:07 -0500
Date: Thu, 26 Feb 2004 15:59:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
Message-ID: <20040226155902.A19918@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040225185536.57b56716.akpm@osdl.org> <200402261650.15596.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402261650.15596.ender@debian.org>; from ender@debian.org on Thu, Feb 26, 2004 at 04:50:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 04:50:14PM +0100, David Martínez Moreno wrote:
Content-Description: clearsigned data
> 	Attached patch fixes compilation of ini9100u driver and cleans several 
> unneeded definitions. It applies cleanly to 2.6.3-mm4 (I think).
> 
> 	Could you please review, because although simple, I'm scared, I don't really 
> know if my patch is doing the Right Thing (tm)? Thanks. :-)

it's not 100% correct as the driver should support multiple HBAs.
Here's a better one:

--- 1.21/drivers/scsi/ini9100u.c	Wed Feb  4 06:38:11 2004
+++ edited/drivers/scsi/ini9100u.c	Thu Feb 26 17:58:20 2004
@@ -180,15 +180,6 @@
 
 static char *setup_str = (char *) NULL;
 
-static irqreturn_t i91u_intr0(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr1(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr2(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr3(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr4(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr5(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr6(int irq, void *dev_id, struct pt_regs *);
-static irqreturn_t i91u_intr7(int irq, void *dev_id, struct pt_regs *);
-
 static void i91u_panic(char *msg);
 
 static void i91uSCBPost(BYTE * pHcb, BYTE * pScb);
@@ -278,7 +269,7 @@
 	unsigned long flags;
 	
 	spin_lock_irqsave(dev->host_lock, flags);
-	tul_isr((HCS *)hreg->base);
+	tul_isr((HCS *)dev->base);
 	spin_unlock_irqrestore(dev->host_lock, flags);
 	return IRQ_HANDLED;
 }
