Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbVBEJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbVBEJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVBEJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:37:16 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:22930 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263248AbVBEJcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:32:52 -0500
Date: Sat, 5 Feb 2005 10:32:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.11-rc3-mm1: fix swsusp with gcc 3.4
Message-ID: <20050205093236.GB1158@elf.ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <20050204201135.GD19408@stusta.de> <200502042251.54316.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502042251.54316.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >...
> > > Changes since 2.6.11-rc2-mm2:
> > >...
> > > +swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
> > > 
> > >  swsusp fix
> > >...
> > 
> > This broke compilation with gcc 3.4:
> [-- snip --]
> 
> BTW, it requires the following bugfix, on top of the Adrian's patch.

ACK on both patches. [The following bugfix is not that critical -- it
only leaks one page per suspend -- that's why I did not scream that
much.]
								Pavel


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> --- linux-2.6.11-rc3-mm1/kernel/power/swsusp.c	2005-02-04 22:33:52.000000000 +0100
> +++ new/kernel/power/swsusp.c	2005-02-04 22:32:36.000000000 +0100
> @@ -614,9 +614,9 @@
>  	struct pbe *pbe;
>  
>  	while (pblist) {
> -		pbe = pblist + PB_PAGE_SKIP;
> -		pblist = pbe->next;
> +		pbe = (pblist + PB_PAGE_SKIP)->next;
>  		free_page((unsigned long)pblist);
> +		pblist = pbe;
>  	}
>  }
>  
> 
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
