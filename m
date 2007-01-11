Return-Path: <linux-kernel-owner+w=401wt.eu-S965278AbXAKBDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbXAKBDQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAKBDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:03:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:38401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965278AbXAKBDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:03:16 -0500
From: Neil Brown <neilb@suse.de>
To: Andi Kleen <ak@suse.de>
Date: Thu, 11 Jan 2007 12:02:53 +1100
Message-ID: <17829.36029.240912.274302@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Neil Brown <neilb@suse.de>, Sean Reifschneider <jafo@tummy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
In-Reply-To: message from Andi Kleen on Thursday January 11
References: <20070110234238.GB10791@tummy.com>
	<17829.34481.340913.519675@notabene.brown>
	<200701110140.51842.ak@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 11, ak@suse.de wrote:
> > Just a 'me too' at this point. 
> > The X server on my shiny new notebook (Core 2 Duo) occasionally dies
> > with 'select' repeatedly returning ERESTARTNOHAND.  It is most
> > annoying!
> 
> Normally it should be only visible in strace. Did you see it without
> strace?

No, only in strace.

> 
> > 
> > You don't mention in the Email which kernel version you use but I see
> > from the web page you reference it is 2.6.19.1.  I'm using
> > 2.6.18.something.
> > 
> > I thought I'd have a quick look at the code, comparing i386 to x86-64
> > and guess what I found.....
> > 
> > On x86-64, regs->rax is "unsigned long", so the following is
> > needed....
> 
> regs->rax is unsigned long.
> I don't think your patch will make any difference. What do you think
> it will change?

If regs->rax is unsigned long, then I would think the compiler would
be allowed to convert

   switch (regs->rax) {
	case -514 : whatever;
   }

to a no-op, as regs->rax will never have a negative value.

However it appears that the current compiler doesn't make that
optimisation so I guess I was too hasty.

Still, I think it would be safer to have the cast, in case the compiler
decided to be clever.... or does the C standard ensure against that?

Sorry for the noise,

NeilBrown
