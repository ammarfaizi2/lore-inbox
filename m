Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030629AbWJCW3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWJCW3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWJCW3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:29:31 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:28188 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030631AbWJCW3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:29:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Uqq82aEa1UDxFC61ppq30PfVaybG5n2QLvtMc/cTQne5f16QrvQ403G3C0iAyUPzv3PeHbLVG+RxUYP9mBK1gGUXUu6rEGqoKqCKIUQmFtTTF4HogtiLQqtN3AAnzheyFFenYnTGUowaYsNlZ42dQ8Dy7FILE6TrnkEUEOEQ9oU=
Date: Tue, 3 Oct 2006 22:29:10 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #2
Message-ID: <20061003222910.GJ2785@slug>
References: <20061003220732.GE2785@slug> <4522E0E0.9020404@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522E0E0.9020404@garzik.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Index: 2.6.18-mm3/include/linux/interrupt.h
> >===================================================================
> >--- 2.6.18-mm3.orig/include/linux/interrupt.h
> >+++ 2.6.18-mm3/include/linux/interrupt.h
> >@@ -75,6 +75,13 @@ struct irqaction {
> > 	struct proc_dir_entry *dir;
> > };
> > +#ifndef ARCH_VALIDATE_PCI_IRQ
> >+static inline int is_irq_valid(unsigned int irq)
> >+{
> >+	return irq ? 1 : 0;
> >+}
> >+#endif /* ARCH_VALIDATE_PCI_IRQ */
> 
> It's not appropriate to have PCI IRQ stuff in linux/interrupt.h.
> 
> This is precisely why I passed 'struct pci_dev *' to a PCI-specific irq validation function, and prototyped it in linux/pci.h.
> 
My bad, I've mixed your proposal and Matthew's, isn't this just a
matter of:
s/ARCH_VALIDATE_PCI_IRQ/ARCH_VALIDATE_IRQ/ ?

I'll look if there's some non-PCI code that might check the irq's value
and thus might benefit from this.

Regards,
Frederik
