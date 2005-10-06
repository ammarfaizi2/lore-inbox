Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVJFWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVJFWYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 18:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVJFWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 18:24:53 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:5856 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751098AbVJFWYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 18:24:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DO0EAMJJdR7ucfcaXnZzne6h7zWiRqgwKtcYvG6kRKaWNyjygFVNmhUKyWxO2GqXB8V6IjxWELi+QybM3Ui4MTMsEZa2t1pCU9CSAvsNuAvI5VWlZzN60R+Gazo0s4oftdJTM8wJ57QLzkukDH3ZlD3mzuIvv0+/Gpkrlo74P/w=
Message-ID: <4af2d03a0510061524m4611d75bn5b1ce6a4e3ebddf1@mail.gmail.com>
Date: Fri, 7 Oct 2005 00:24:51 +0200
From: Jiri Slaby <jirislaby@gmail.com>
Reply-To: Jiri Slaby <jirislaby@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Cc: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>
In-Reply-To: <4323482E.2090409@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jiri Slaby wrote:
> > diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
> > --- a/include/asm-i386/ide.h
> > +++ b/include/asm-i386/ide.h
> > @@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
> >
> >  static __inline__ unsigned long ide_default_io_base(int index)
> >  {
> > -     if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> > +     struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
> > +     unsigned int a = !pdev;
> > +
> > +     pci_dev_put(pdev);
>
>
> Looks like we need to resurrect pci_present() from the ancient past.
So, what was the result of this debate? I can't see any solution in
that thread, not even in 2.6.14-rc2-mm2.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
