Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWGMKPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWGMKPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWGMKPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:15:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751443AbWGMKPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:15:30 -0400
Date: Thu, 13 Jul 2006 03:15:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Message-Id: <20060713031523.0ab0c4cb.akpm@osdl.org>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27043F5DEE@uk-email.terastack.bluearc.com>
References: <89E85E0168AD994693B574C80EDB9C27043F5DEE@uk-email.terastack.bluearc.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 08:56:01 +0100
"Andy Chittenden" <AChittenden@bluearc.com> wrote:

> > On Wed, 12 Jul 2006 08:58:52 +0100
> > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > 
> > > I tried to install the linux-image-2.6.17-1-amd64-k8-smp 
> > debian package
> > > on a ASUS M2NPV-VM motherboard based system and it hung 
> > during boot. The
> > > last message on the console was:
> > > 
> > >  io scheduler cfq registered
> > 
> > Suggest you add initcall_debug to the kernel boot command 
> > line.  That'll
> > tell us which initcall got stuck.
> 
> I was only able to scrounge 5 minutes on this system this morning.
> Here's the last few messages output with initcall_debug on:
> 
> Calling initcall .... init+0x0/0xc()
> Calling initcall .... noop_init+0x0/0xc()
> io scheduler noop registered
> Calling initcall .... as_init+0x0/0x4f()
> io scheduler anticipatory registered (default)
> Calling initcall .... deadline_init+0x0/0x4f()
> io scheduler deadline registered
> Calling initcall .... cfq_init+0x0/0xcc()
> io scheduler cfq registered
> Calling initcall .... pci_init+0x0/0x2b()
> 
> What other info can I grab? (Although I have to fit in with that
> system's production schedule so I may not be able to come back with that
> until later on today/tomorrow).

Seems one of the quirks has gone bad.  The below should tell us which one. 
You'll need to correlate it with the machine's lspci output please.


--- a/drivers/pci/pci.c~a
+++ a/drivers/pci/pci.c
@@ -925,6 +925,7 @@ static int __devinit pci_init(void)
 	struct pci_dev *dev = NULL;
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+		printk("%s: fix up %s\n", __FUNCTION__, pci_name(dev));
 		pci_fixup_device(pci_fixup_final, dev);
 	}
 	return 0;
_

