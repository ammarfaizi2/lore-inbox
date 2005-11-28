Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVK1A7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVK1A7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVK1A7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:59:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751204AbVK1A73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:59:29 -0500
Date: Sun, 27 Nov 2005 16:59:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: benh@kernel.crashing.org, mbuesch@freenet.de, david-b@pacbell.net,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
Message-Id: <20051127165909.15be4d7f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0511271654280.16475-100000@netrider.rowland.org>
References: <1133126726.7768.127.camel@gaston>
	<Pine.LNX.4.44L0.0511271654280.16475-100000@netrider.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> For now, you can workaround the bug by adding:
> 
>  	spin_lock_init(&ehci_lock);
> 
>  as the first line of drivers/usb/host/ehci-pci.c:ehci_pci_reset().

Yup.

--- devel/drivers/usb/host/ehci-pci.c~gregkh-usb-usb-pm-09-fix	2005-11-25 19:03:59.000000000 -0800
+++ devel-akpm/drivers/usb/host/ehci-pci.c	2005-11-25 19:03:59.000000000 -0800
@@ -129,6 +129,8 @@ static int ehci_pci_reset(struct usb_hcd
 	u32			temp;
 	int			retval;
 
+	spin_lock_init(&ehci->lock);
+
 	ehci->caps = hcd->regs;
 	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
 	dbg_hcs_params(ehci, "reset");
_

