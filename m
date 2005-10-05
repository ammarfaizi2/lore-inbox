Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVJEMMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVJEMMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVJEMMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:12:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41445 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965124AbVJEMMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:12:52 -0400
Date: Wed, 5 Oct 2005 14:12:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Free swap suspend from depending upon PageReserved.
Message-ID: <20051005121222.GA22580@elf.ucw.cz>
References: <1128506536.5514.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128506536.5514.13.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's the patch we've previously discussed, which removes the
> dependancy of swap suspend on PageReserved.

This ends up in Linus' changelog, so "we've previously discussed"
is not okay here. Missing signed-off. What is benefit of this?

swsusp part looks okay, but will Andrew like the generic part? I guess
I'd prefer to postpone this one (unless we are last user of
PageReserved) -- I do not see too big benefit and there's potential
for breakage.

> @@ -353,7 +357,7 @@ static void __init pagetable_init (void)
>  #endif
>  }
>  
> -#ifdef CONFIG_SOFTWARE_SUSPEND
> +#ifdef CONFIG_PM
>  /*
>   * Swap suspend & friends need this for resume because things like the intel-agp
>   * driver might have split up a kernel 4MB mapping.

This is wrong, right? It 

> @@ -540,6 +544,7 @@ void __init mem_init(void)
>  	int codesize, reservedpages, datasize, initsize;
>  	int tmp;
>  	int bad_ppro;
> +	void * addr;

Please make it void *addr;.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
