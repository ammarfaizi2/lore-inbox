Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263461AbUJ2SMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbUJ2SMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUJ2SI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:08:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:36766 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263383AbUJ2SGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:06:45 -0400
Date: Fri, 29 Oct 2004 11:06:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, linux-os wrote:
> > with the following:
> >
> > leal 4(%esp),%esp
> 
> Probably so because I'm pretty certain that the 'pop' (a memory
> access) is not going to be faster than a simple register operation.

Bzzt, wrong answer.

It's not "simple register operation". It's really about the fact that 
modern CPU's are smarter - yet dumber - then you think. They do things 
like speculate the value of %esp in order to avoid having to calculate it, 
and it's entirely possible that "pop" is much faster, simply because I 
guarantee you that a CPU will speculate %esp correctly across a "pop", but 
the same is not necessarily true for "lea %esp".

Somebody should check what the Pentium M does. It might just notice that 
"lea 4(%esp),%esp" is the same as "add 4 to esp", but it's entirely 
possible that lea will confuse its stack engine logic and cause 
stack-related address generation stalls..

		Linus
