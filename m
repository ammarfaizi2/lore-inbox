Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUKXK47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUKXK47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUKXK47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:56:59 -0500
Received: from gprs214-63.eurotel.cz ([160.218.214.63]:55424 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262608AbUKXK44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:56:56 -0500
Date: Wed, 24 Nov 2004 11:56:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATH] 11-24 swsusp update 1/3
Message-ID: <20041124105643.GA5374@elf.ucw.cz>
References: <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165823.GA10609@hugang.soulinfo.com> <20041123221430.GF25926@elf.ucw.cz> <20041124080256.GA3455@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124080256.GA3455@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Either drop this one or explain why it is good idea. It seems to be
> > independend on the rest.
> This code I just copy from old ppc swsusp port, I don't why, :).

So drop the patch...

> > 
> > > @@ -144,9 +151,13 @@
> > >  	}
> > >  
> > >  	/* Free memory before shutting down devices. */
> > > -	free_some_memory();
> > > +	/* free_some_memory(); */
> > 
> > Needs to be if (!swsusp_pagecache), right?
> I think we can drop this one, In write_page_caches has same code, and do
> the best.

So at least delete it properly; no need to comment it out.

>  > +			if (swsusp_pbe_pgdir->orig_address == 0) return;
> > > +			for (i = 0; i < PAGE_SIZE / (sizeof(unsigned long)); i+=4) {
> > > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i)) = 
> > > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i));
> > > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+1)) = 
> > > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+1));
> > > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+2)) = 
> > > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+2));
> > > +				*(((unsigned long *)(swsusp_pbe_pgdir->orig_address) + i+3)) = 
> > > +					*(((unsigned long *)(swsusp_pbe_pgdir->address) + i+3));
> > 
> > Do you really have to do manual loop unrolling? Why can't C code be
> > same for i386 and ppc?
> here is stupid code, update in my new patch, I using memcopy in i386, it 
> create small assemble code.

Warning: memcpy() may uses MMX or SSE or something on some cpus....

> > Please avoid "return (0);". Using "return 0;" will do just fine.
> fixed.
> 
> here is my patch relative with your big diff, hope can merge. 

I have already too big difference against mainline, so I can only
merge trivial patches at this point. When 2.6.10 comes out, I'd like
to merge "no-high-order-allocation" patch, and "pagecache writer"
sometime after that...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
