Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWJEN7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWJEN7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJEN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:59:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:41391 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751096AbWJEN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:59:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qH+PSjwULuPKufTaFI6GWImc0MHqEeoh1dpd0g2zEYEreK4bmgdi8DIgXx+PNN+o0FktDyRSkuT1n8ceGoEGr96otDuEiqcOXB6cW0N5mf/LnKQENswZNkCWNd1DEe+4mR6bGpFd1CNTeFIq4lRoaCnHkoAELzV4OkJz3Movldc=
Date: Thu, 5 Oct 2006 17:59:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061005135924.GB5335@martell.zuzino.mipt.ru>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org> <20061004202938.GF352@slug> <20061004203311.GI28596@parisc-linux.org> <20061004212633.GG352@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004212633.GG352@slug>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:26:33PM +0000, Frederik Deweerdt wrote:
> On Wed, Oct 04, 2006 at 02:33:11PM -0600, Matthew Wilcox wrote:
> > On Wed, Oct 04, 2006 at 08:29:38PM +0000, Frederik Deweerdt wrote:
> > > I see. Just to be sure that I got the matter right, does the issue boils
> > > down to a choice between:
> >
> > woah, woah, woah, you're getting yourself confused here.
> yep :), I clearly missed the point you made there:
> http://lkml.org/lkml/2006/10/3/404
> I've re-read it, hope I've got it right this time.
> >
> > You're looking at what the architectures do here.  We're not concerned
> > with that, we're concerned with what the device drivers do with whatever
> > value the architecture has stuck in pdev->irq.
> Not sure I get it still though. Is the issue more than just the location
> of the irq validation code? If yes, could you explain what are the
> differences between your proposal and Jeff's ?
>
> Anyway, let me have another try at summing up the issue:
>
> #1
> - generic irq validation code in include/linux/pci.h
> - arch specific irq validation code in include/asm/pci.h
> - is_irq_valid() called by pci_request_irq()

s/is_irq_valid/valid_irq/g methinks.

> BTW this is much like it's done for pci_resource_to_user()
>
> #2
> - generic irq validation code in include/linux/interrupt.h
> - arch specific irq validation code in include/asm/interrupt.h
> - include/linux/pci.h includes linux/interrupt.h
> - is_irq_valid() called by pci_request_irq() - and maybe others? -

