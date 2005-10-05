Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVJEMya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVJEMya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVJEMya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:54:30 -0400
Received: from [203.171.93.254] ([203.171.93.254]:15512 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S965162AbVJEMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:54:29 -0400
Subject: Re: [PATCH] Free swap suspend from depending upon PageReserved.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051005121222.GA22580@elf.ucw.cz>
References: <1128506536.5514.13.camel@localhost>
	 <20051005121222.GA22580@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128516721.10363.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 05 Oct 2005 22:52:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-10-05 at 22:12, Pavel Machek wrote:
> Hi!
> 
> > Here's the patch we've previously discussed, which removes the
> > dependancy of swap suspend on PageReserved.
> 
> This ends up in Linus' changelog, so "we've previously discussed"
> is not okay here. Missing signed-off. What is benefit of this?

I wasn't seeking to get it merged immediately, but was seeking comments.

> swsusp part looks okay, but will Andrew like the generic part? I guess
> I'd prefer to postpone this one (unless we are last user of
> PageReserved) -- I do not see too big benefit and there's potential
> for breakage.

There have already been patches to remove work toward removing
PageReserved. If swap suspend isn't the last user, it won't be far from
it.

> > @@ -353,7 +357,7 @@ static void __init pagetable_init (void)
> >  #endif
> >  }
> >  
> > -#ifdef CONFIG_SOFTWARE_SUSPEND
> > +#ifdef CONFIG_PM
> >  /*
> >   * Swap suspend & friends need this for resume because things like the intel-agp
> >   * driver might have split up a kernel 4MB mapping.
> 
> This is wrong, right? It 

No. I use it too. From your perspective though, I suppose it is wrong.

> > @@ -540,6 +544,7 @@ void __init mem_init(void)
> >  	int codesize, reservedpages, datasize, initsize;
> >  	int tmp;
> >  	int bad_ppro;
> > +	void * addr;
> 
> Please make it void *addr;.

Ok.

If noone else suggests changes, I'll properly submit it.

Regards,

Nigel

> 								Pavel
-- 


