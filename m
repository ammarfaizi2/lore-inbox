Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVIJVUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVIJVUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVIJVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:20:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:4583 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932209AbVIJVUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:20:02 -0400
Date: Sat, 10 Sep 2005 14:19:32 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Message-ID: <20050910211932.GA13679@kroah.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4323482E.2090409@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 04:55:10PM -0400, Jeff Garzik wrote:
> Jiri Slaby wrote:
> >diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
> >--- a/include/asm-i386/ide.h
> >+++ b/include/asm-i386/ide.h
> >@@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
> > 
> > static __inline__ unsigned long ide_default_io_base(int index)
> > {
> >-	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> >+	struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
> >+	unsigned int a = !pdev;
> >+
> >+	pci_dev_put(pdev);
> 
> 
> Looks like we need to resurrect pci_present() from the ancient past.

Heh, ick, no :)

Jiri, any other way to do this instead?

thanks,

greg k-h
