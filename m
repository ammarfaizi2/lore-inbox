Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVCOMC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVCOMC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVCOMC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:02:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38624 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261185AbVCOMCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:02:40 -0500
Date: Tue, 15 Mar 2005 13:02:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp_restore crap
Message-ID: <20050315120217.GE1344@elf.ucw.cz>
References: <1110857069.29123.5.camel@gaston> <1110857516.29138.9.camel@gaston> <20050315110309.GA1344@elf.ucw.cz> <200503151251.01109.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503151251.01109.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Please kill that swsusp_restore() call that itself calls
> > > > flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
> > > > arch specific, and that's all swsusp_restore() does. Then, the asm just
> > > > calls this before returning to C code, so it makes no sense to have a
> > > > hook there. The x86 asm can have it's own call to some arch stuff if it
> > > > wants or just do the tlb flush in asm...
> > > 
> > > Better, here is a patch... (note: flush_tlb_global() is an x86'ism,
> > > doesn't exist on ppc, thus breaks compile, and that has nothing to do in
> > > the generic code imho, it should be clearly defined as the
> > > responsibility of the asm code).
> > 
> > x86-64 needs this, too.... Otherwise it looks okay.
> 
> It breaks compilation on i386 either, because nr_copy_pages_check
> is static in swsusp.c.  May I propose the following patch instead (tested on
> x86-64 and i386)?


> +asmlinkage int __swsusp_flush_tlb(void)
> +{
> +	swsusp_restore_check();

Someone will certainly forget this one, and it is probably
nicer/easier to just move BUG_ON into swsusp_suspend(), just after
restore_processor_state() or something like that...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
