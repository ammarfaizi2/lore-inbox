Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUJ3BiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUJ3BiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUJ2Tgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:36:40 -0400
Received: from ltgp.iram.es ([150.214.224.138]:9090 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263439AbUJ2SkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:40:12 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 29 Oct 2004 20:37:15 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041029183715.GA31244@iram.es>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:46:06AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Oct 2004, linux-os wrote:
> > 
> > Linus, please check this out.
> 
> Yes, I concur. However, I'd suggest changing the "addl $4,%esp" into a 
> "popl %ecx", which is smaller and apparently faster on some CPU's (ecx 
> obviously gets immediately overwritten by the next popl).

Rather popl %eax or popl %edx then, a basic and MMX Pentium 
cannot pair:

	popl %ecx
	popl %ecx

for the simple reason that two instructions that have the
same destination register can't be paired.

OTOH, the other argument about reading or not memory in
this thread are a red herring. An additional memory read 
is cheap for data that is guaranteed to be in a cache line 
used by adjacent (in time) instructions.

Otherwise regparm(1) might even be better, movl %ecx,%eax is
the same size as push+pop, is faster, and may even reduce
stack usage by 4 bytes.

