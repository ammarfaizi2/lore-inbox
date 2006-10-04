Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWJDJJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWJDJJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWJDJJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:09:27 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:53241 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161185AbWJDJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:09:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=fesq2u1V2uDoF0xhUiE3YyzgPnxtvOq7Vt/LPSTKcTR0GSRBlPlC9rE7RblVfik6OCthsFzM1B/LYY4qkxaf2UbezDH7sukv9qC69lmkPKHNmSRP25uKKIgwOmviYD4HnIhEL/xgRBwo6lWEal4RytU6NA+LGcGfeusi/gMBM3E=
Date: Wed, 4 Oct 2006 09:09:06 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, arjan@infradead.org,
       matthew@wil.cx, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       rdunlap@xenotime.net, gregkh@suse.de
Subject: Re: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061004090906.GA3158@slug>
References: <4522E637.9090103@garzik.org> <20061003224146.GK2785@slug> <452348D7.7020205@garzik.org> <20061003.232748.111208658.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003.232748.111208658.davem@davemloft.net>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:27:48PM -0700, David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Wed, 04 Oct 2006 01:38:31 -0400
> 
> > As for why the flag may be missing -- PCI MSI interrupts are never 
> > shared.  However, it won't _hurt_ anything to set the flag needlessly, 
> > AFAIK.
> 
> That's right.
Just to make sure I understood: does this means that the code at lines
296 and 297 in e1000_main.c can be safely removed?

 296 if (adapter->have_msi)
 297 	flags &= ~IRQF_SHARED;
 298 #endif
 299 if ((err = request_irq(adapter->pdev->irq, &e1000_intr, flags,
 300 	netdev->name, netdev)))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
