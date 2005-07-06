Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVGFFXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVGFFXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVGFFVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:21:02 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58812 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261644AbVGFDlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:41:49 -0400
Subject: Re: [PATCH] [7/48] Suspend2 2.1.9.8 for 2.6.12:
	352-disable-pdflush-during-suspend.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507052134290.2149@montezuma.fsmlabs.com>
References: <11206164401583@foobar.com>
	 <Pine.LNX.4.61.0507052134290.2149@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120621388.4860.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 13:43:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 13:34, Zwane Mwaikambo wrote:
> On Wed, 6 Jul 2005, Nigel Cunningham wrote:
> 
> > diff -ruNp 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c
> > --- 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c	2005-06-20 11:47:32.000000000 +1000
> > +++ 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c	2005-07-04 23:14:20.000000000 +1000
> > @@ -26,6 +26,7 @@
> >  #include <linux/init.h>
> >  #include <linux/hash.h>
> >  #include <linux/highmem.h>
> > +#include <linux/suspend.h>
> >  #include <asm/tlbflush.h>
> >  
> >  static mempool_t *page_pool, *isa_page_pool;
> > @@ -95,7 +96,10 @@ static void flush_all_zero_pkmaps(void)
> >  
> >  		set_page_address(page, NULL);
> >  	}
> > -	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> > +	if (test_suspend_state(SUSPEND_FREEZE_SMP))
> > +		__flush_tlb();
> > +	else
> > +		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
> >  }
> >  
> >  static inline unsigned long map_new_virtual(struct page *page)
> 
> What state are the other processors in when you hit this path?

Looping in arch specific code, waiting for an atomic_t to tell them it's
time to restore state and carry on. They're there the whole time CPU0 is
restoring the image and highmem.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

