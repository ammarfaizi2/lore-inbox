Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWI2VwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWI2VwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWI2VwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:52:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:42970 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422847AbWI2VwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:52:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=C64gc3gmnEmJHOvocqnNcvcuotmlEO1Hmb+X9zQIf2XLi7D6EANzEbfQY840uh1Cqjr3f033xw+miflFnh1pRMinRAym++Eu1EBhzrWYH8iVBpxQDB05QLmQJ/we+FZdQOQXNRw7ULxDPWSUrCrUdreJhnEPOg0vzRDiw2wV1k8=
Date: Fri, 29 Sep 2006 23:50:54 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, "J.A. Magall??n" <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060929235054.GB2020@slug>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159550143.13029.36.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 06:15:42PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-09-29 am 08:39 -0600, ysgrifennodd Matthew Wilcox:
> > On Fri, Sep 29, 2006 at 03:57:38PM +0200, J.A. Magall??n wrote:
> > > aic7xxx oopses on boot:
> > > 
> > > PCI: Setting latency timer of device 0000:00:0e.0 to 64
> > > IRQ handler type mismatch for IRQ 0
> > 
> > Of course, this isn't a scsi problem, it's a peecee hardware problem.
> > Or maybe a PCI subsystem problem.  But it's clearly not aic7xxx's fault.
> 
> AIC7xxx finding it has no IRQ configured is valid (annoying, stupid and
> valid) so the driver should check before requesting "no IRQ"
> 
Alan,

Does this patch makes sense in that case? If yes, I'll put up a patch
for the remaining cases in the drivers/scsi/aic7xxx/ directory.
Also, aic7xxx's coding style would put parenthesis around the returned
value, should I follow it?

Regards,
Frederik

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index ea5687d..38f5ca7 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -185,6 +185,9 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 	int		 error;
 	struct device	*dev = &pdev->dev;
 
+	if (!pdev->irq)
+		return -ENODEV;
+
 	pci = pdev;
 	entry = ahc_find_pci_device(pci);
 	if (entry == NULL)
