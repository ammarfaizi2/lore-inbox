Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSKOSGh>; Fri, 15 Nov 2002 13:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbSKOSGh>; Fri, 15 Nov 2002 13:06:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:26628 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266546AbSKOSGe>;
	Fri, 15 Nov 2002 13:06:34 -0500
Date: Fri, 15 Nov 2002 19:12:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115181247.GB8763@elf.ucw.cz>
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <1037366172.877.30.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037366172.877.30.camel@zion>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > The following dropped hunk from Pavel should repair it:
> > > 
> > > [cc: list trimmed to spare the uninterested]
> > > 
> > > Hmm, there are some oddities here in count_and_copy_data_pages(). It
> > > looks like the CONFIG_HIGHMEM panic() is there because copy_page() is
> > > done without kmapping, and the CONFIG_DISCONTIGMEM panic() is there
> > > because the pgdat list etc. are not walked according to VM
> > > conventions.
> > 
> > How much memory is needed for HIGHMEM to be neccessary? Is it 1GB? If
> > so, I can well imagine 1GB laptop....
> 
> Depends on the arch & other matters. 768Mb on PPC at least, and
> it starting to be common within laptops as well.

I just hope we'll never ever see 64GB i386 laptop...

... We'll probably have to write simpler equivalent of kmap_atomic for
use in suspend_asm.S. It is not really *so* deep magic.

> > This certainly does not work. We'd need to do some deep magic in
> > suspend_asm.S to copy pages back. [Well, deep magic... Same
> > kmap_atomic.] But suspend_asm.S has to guarantee not touching any
> > memory so the change is not quite trivial.
> 
> At worst, that could be an arch provided routine. On most PPC32's
> I can then just disable data translation on the MMU and access
> all pages without kmap'ing them. But that's not terribly portable
> and each arch would need different kind of hacking.

It is arch-specific already. What's worse, resume has to be written in
assembly, so you can't simply write kmap_atomic() there. See
arch/i386/kernel/suspend_asm.S.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
