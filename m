Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWIOWr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWIOWr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWIOWr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:47:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932343AbWIOWr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:47:27 -0400
Date: Fri, 15 Sep 2006 15:45:15 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       zaitcev@redhat.com, <david-b@pacbell.net>
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Message-Id: <20060915154515.ae14372c.zaitcev@redhat.com>
In-Reply-To: <200609141319.53942.rjw@sisk.pl>
References: <200609131558.03391.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org>
	<20060913153158.612ef473.zaitcev@redhat.com>
	<200609141319.53942.rjw@sisk.pl>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.2; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 13:19:53 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> In fact I can reproduce it on two different boxes now.

How about the attached?

-- Pete

diff -urp -X dontdiff linux-2.6.18-rc6/drivers/usb/host/ohci-hcd.c linux-2.6.18-rc6-lem/drivers/usb/host/ohci-hcd.c
--- linux-2.6.18-rc6/drivers/usb/host/ohci-hcd.c	2006-09-06 21:56:32.000000000 -0700
+++ linux-2.6.18-rc6-lem/drivers/usb/host/ohci-hcd.c	2006-09-14 22:48:15.000000000 -0700
@@ -775,7 +775,9 @@ static void ohci_stop (struct usb_hcd *h
 
 	ohci_usb_reset (ohci);
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
-	
+	free_irq(hcd->irq, hcd);
+	hcd->irq = -1;
+
 	remove_debug_files (ohci);
 	unregister_reboot_notifier (&ohci->reboot_notifier);
 	ohci_mem_cleanup (ohci);
