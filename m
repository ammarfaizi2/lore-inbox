Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbUK1RNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUK1RNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbUK1RMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:12:16 -0500
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:1922 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261531AbUK1RLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:11:23 -0500
Date: Sun, 28 Nov 2004 18:11:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [1/6]
Message-ID: <20041128171106.GD1214@elf.ucw.cz>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128162558.GF28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162558.GF28881@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  device-tree.diff 
> >    base from suspend2 with a little changed.
> > 
> >  core.diff
> >   1: redefine struct pbe for using _no_ continuous as pagedir.
> >   2: make shrink memory as little as possible.
> >   3: using a bitmap speed up collide check in page relocating.
> >   4: pagecache saving ready.
> > 
> >  i386.diff
> >  ppc.diff
> >   i386 and powerpc suspend update.
> > 
> >  pagecachs_addon.diff
> >   if enable page caches saving, must using it, it making saving
> >   pagecaches safe. idea from suspend2.
> > 
> >   ppcfix.diff
> >   fix compile error. 
> >   $ gcc -v
> >    .... 
> >    gcc version 2.95.4 20011002 (Debian prerelease)
> > 
> > I'm using 2.6.9-ck3 With above patch, swsusp1 works prefect in my 
> > PowerPC and x86 PC with Highmem and prepempt option enabled.
> > 
> > I hope the core.diff@1,@2,@3 i386.diff ppc.diff will merge into 
> > mainline kernel ASAP, :). from I view point device-tree.diff is 
> > very usefuly when using pagecache saving and pagecachs_addon.diff
> > that's really hack for making pagecache saving safe.
> > 
> 
> --- 2.6.9-lzf/arch/ppc/syslib/open_pic.c	2004-11-26 12:32:58.000000000 +0800
> +++ 2.6.9/arch/ppc/syslib/open_pic.c	2004-11-28 23:16:58.000000000 +0800
> @@ -776,7 +776,8 @@ static void openpic_mapirq(u_int irq, cp
>  	if (ISR[irq] == 0)
>  		return;
>  	if (!cpus_empty(keepmask)) {
> -		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
> +		cpumask_t irqdest;
> +		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
>  		cpus_and(irqdest, irqdest, keepmask);
>  		cpus_or(physmask, physmask, irqdest);
>  	}

ACK. Send this to Andrew Morton, Cc: Rusty trivial patch monkey
Russell <trivial@rustcorp.com.au>.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
