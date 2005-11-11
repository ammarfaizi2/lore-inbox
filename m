Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVKKRVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVKKRVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKKRVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:21:39 -0500
Received: from i121.durables.org ([64.81.244.121]:25241 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750939AbVKKRVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:21:38 -0500
Date: Fri, 11 Nov 2005 09:21:17 -0800
From: Matt Mackall <mpm@selenic.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] misc: Allow dropping panic text strings from kernel image
Message-ID: <20051111172117.GX11462@waste.org>
References: <12.282480653@selenic.com> <Pine.LNX.4.62.0511111202220.3956@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511111202220.3956@numbat.sonytel.be>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 12:03:25PM +0100, Geert Uytterhoeven wrote:
> On Fri, 11 Nov 2005, Matt Mackall wrote:
> > Index: 2.6.14-misc/kernel/panic.c
> > ===================================================================
> > --- 2.6.14-misc.orig/kernel/panic.c	2005-11-09 11:27:15.000000000 -0800
> > +++ 2.6.14-misc/kernel/panic.c	2005-11-10 23:26:41.000000000 -0800
> > @@ -94,7 +106,11 @@ NORET_TYPE void panic(const char * fmt, 
> >  	smp_send_stop();
> >  #endif
> >  
> > +#ifdef CONFIG_FULL_PANIC
> >  	notifier_call_chain(&panic_notifier_list, 0, buf);
> > +#else
> > +	notifier_call_chain(&panic_notifier_list, 0, "");
> > +#endif
> 
> If you `#define buf ""' above, you can kill this #ifdef.

I don't know that trading an ifdef for a define is an improvement.

-- 
Mathematics is the supreme nostalgia of our time.
