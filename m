Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVAIBad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVAIBad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVAIBad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:30:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262181AbVAIBaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:30:25 -0500
Date: Sat, 8 Jan 2005 16:28:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050108182841.GD2701@logos.cnet>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:46:19AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 7 Jan 2005, Marcelo Tosatti wrote:
> > 
> > Only problem is that current do_brk() callers dont take the lock - you would
> > need a version of do_brk() that doesnt warn for them? 
> 
> No, I'd just fix them up.

What do you mean by "fix them up" ? With your minimal fix the other do_brk() callers 
do not have the lock, you dont mean "fix" by grabbing the lock? 

> They mostly don't _need_ the lock (at least not the binary loader ones),
> since at executable loading time you're guaranteed to be the only user
> anyway,

OK - the old mappings have been unmapped at this point, correct? There are no 
mappings at all?

I think you also need to fix some cases in arch/sparc{64},arch/mips? as Alan said. 

> but hey, we get the lock for do_mmap() there for the same reason:  
> to just keep things consistent (and I think we used to have a warning in
> do_mmap() a long time ago when we were chasing down some other bug, so
> doign the same thing for do_brk() is just very consistent).

I think the rule "always have mmap_sem locked when calling do_brk()" is simpler and
easier to understand, but hey, you prefer the minimal fix.

I was also not sure if it was safe to NOT have the lock except for execve() as 
you mention.

> Another issue is likely that we should make the whole "uselib()"
> interfaces configurable. I don't think modern binaries use it (where
> "modern" probably means "compiled within the last 8 years" ;).


