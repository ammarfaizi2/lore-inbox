Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbUJ2Tnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUJ2Tnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263476AbUJ2TlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:41:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:15828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbUJ2TQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:16:03 -0400
Date: Fri, 29 Oct 2004 12:15:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Steinmetz <ast@domdv.de>
cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <418292C7.2090707@domdv.de>
Message-ID: <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Andreas Steinmetz wrote:

> Linus Torvalds wrote:
> > Somebody should check what the Pentium M does. It might just notice that 
> > "lea 4(%esp),%esp" is the same as "add 4 to esp", but it's entirely 
> > possible that lea will confuse its stack engine logic and cause 
> > stack-related address generation stalls..
> 
> Now especially Intel tells everybody in their Pentium Optimization 
> manuals to *use* lea whereever possible as this operation doesn't depend 
> on the ALU and is processed in other parts of the CPU.
> 
> Sample quote from said manual (P/N 248966-05):
> "Use the lea instruction and the full range of addressing modes to do 
> address calculation"

Does it say this about %esp?

The stack pointer is SPECIAL, guys. It's special exactly because there is
potentially extra hardware in CPU's that track its value _independently_
of the actual physical register.

Just for fun, google for 'x86 "stack engine"', and you'll hit for example 
http://arstechnica.com/articles/paedia/cpu/pentium-m.ars/5 which talks 
about this and perhaps explains it in ways that I apparently haven't been 
able to.

			Linus
