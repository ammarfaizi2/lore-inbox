Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUEPEbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUEPEbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 00:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUEPEbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 00:31:48 -0400
Received: from taco.zianet.com ([216.234.192.159]:37383 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S262388AbUEPEbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 00:31:46 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sat, 15 May 2004 22:31:13 -0600
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <Pine.LNX.4.58.0405151914280.10718@ppc970.osdl.org> <Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405152029110.10718@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405152231.15099.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 09:44 pm, Linus Torvalds wrote:
> 
> On Sat, 15 May 2004, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 15 May 2004, Steven Cole wrote:
> > > 
> > > In the spirit of 'rounding up the usual suspects', I'll unset CONFIG_PREEMT
> > > and try again.
> > 
> > Or it could be any number of other config options. Do you have anything 
> > else interesting enabled?
> 
> Ahh, looking at an earlier email I see that you have CONFIG_REGPARM=y too.
> 
> That could easily be pretty dangerous - there have been both compiler bugs
> in this area, and just kernel bugs (missing "asmlinkage" things causing
> bad calling conventions and really nasty bugs).
> 
> So please try without both PREEMPT and REGPARM. Considering that it's
> apparently very repeatable for you, I'd be more inclined to worry about 
> REGPARM than PREEMPT, but it's best to try with both disabled.
> 
> I also worry about that PDC202XX controller, but that 1352 is a strange
> number (divisible by 8, but not by a cacheline or 512-byte sector or
> something like that), so it doesn't _sound_ like something like DMA
> failure or chipset programming, but who the hell knows..
> 
> 		Linus
> 
> 

OK, will do.  I ran the bk exerciser script for over an hour with 2.6.6-current
and no CONFIG_PREEMPT and no errors.  The script only reported one
iteration finished, while I got it to do 36 iterations over several hours earlier
today (with a 2.6.3-4mdk vendor kernel), so I'm going to add some timing 
tests to the script to see if things are really slowing down with current kernels,
or if it's just my worried imaginings.

Going back through my sent mail, it looks like I first reported the originally
noticed failture as a bk bug to LM on 4/15/04 if that helps with kernel versions.
I usually do a bk pull and kernel build every night or so "just for fun".

Steven
