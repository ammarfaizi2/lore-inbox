Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUJ3AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUJ3AVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUJ3AUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:20:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:40934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbUJ3APJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:15:09 -0400
Date: Fri, 29 Oct 2004 17:15:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Andreas Steinmetz <ast@domdv.de>, linux-os@analogic.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.61.0410291639430.8616@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.58.0410291705210.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de>
 <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <418292C7.2090707@domdv.de>
 <Pine.LNX.4.58.0410291212350.28839@ppc970.osdl.org> <41829C91.5030709@domdv.de>
 <Pine.LNX.4.61.0410291639430.8616@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, dean gaudet wrote:
> 
> for p4 model 0 through 2 it was faster to avoid lea and shl and generate 
> code like:
> 
> 	add %ebx,%ebx
> 	add %ebx,%ebx
> 	add %ebx,%ebx
> 	add %ebx,%ebx

I think that is true only for the lea's that have a shifted input. The
weakness of the original P4 is its shifter, not lea itself. And for a
simple lea like 4(%esp), it's likely no worse than a regular "add", and
there lea has the advantage that you can put the result in another
register, which can be advantageous in other circumstances.

So lea actually _is_ useful for doing adds, in many cases. Of course, on
older CPU's you'll see the effect of the address generation adder being
one cycle "off" (earlier) the regular ALU execution unit, so lea often
causes AGI stalls.  I don't think this is an issue on the P6 or P4 because 
of how they actually end up implementing the lea in the regular ALU path. 

How the hell did we get to worrying about this in the first place?

		Linus
