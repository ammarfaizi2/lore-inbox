Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUBZW1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUBZW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:27:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:34476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbUBZW0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:26:55 -0500
Date: Thu, 26 Feb 2004 14:32:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
In-Reply-To: <or1xohpjzn.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
 <Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org> <or1xohpjzn.fsf@free.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Alexandre Oliva wrote:
> 
> There's a reason why I added both asms, one with volatile and one
> without.  I know what I'm doing.  I even tried to explain it in the
> comments.  Did you read them?  Let me try again.

Ok, I'll buy it.

> > There is nothing to say that gcc wouldn't do a re-load or something
> > in between, so you really need to tell the _first_ ask about it.
> 
> The only other reload it could do is an input reload of p4 and p5,
> which, again, doesn't matter, because p4 and p5 are dead anyway.

Ok. That's the missing piece. The thing is wrong, but we don't care, 
because even if gcc saves the old values for some silly reload, they're 
dead and uninteresting.

Ok. I did the silly one-liner, but if the "don't care" approach really 
improves code generation, feel free to send one that fixes both the P5 and 
PII cases..

		Linus
