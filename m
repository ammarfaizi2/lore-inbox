Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUJ2Tnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUJ2Tnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbUJ2TkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:40:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:39120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261633AbUJ2TMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:12:14 -0400
Date: Fri, 29 Oct 2004 12:12:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, linux-os wrote:
> 
> Linus, there is no way in hell that you are going to move
> a value from memory into a register (pop ecx) faster than
> you are going to do anything to the stack-pointer or
> any other register.

Sorry, but you're wrong.

Learn about modern CPU's some day, and realize that cached accesses are 
fast, and pipeline stalls are relatively much more expensive.

Now, if it was uncached, you'd have a point.

Also think about why

	call xxx
	jmp yy

is often much faster than

	push $yy
	jmp xxx

and other small interesting facts about how CPU's actually work these 
days.

		Linus
