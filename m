Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUJKEca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUJKEca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJKEca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:32:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:32728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268690AbUJKEc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:32:27 -0400
Date: Sun, 10 Oct 2004 21:32:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <1097468590.3249.2.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410102126220.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>  <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
  <1097466354.3539.14.camel@gaston>  <Pine.LNX.4.58.0410102104530.3897@ppc970.osdl.org>
 <1097468590.3249.2.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> But radeonfb ends up suspending the display at a wrong time and you miss
> half of the output, which makes any kind of debugging near to
> impossible.

Agreed.

But notice? It _works_. It's suspendign too damn eagerly, and it's hard to
debug, but it's a "safe" solution to the confusion that does exist. Which
is why I did it.

And please do realize that I'd love to solve the confusion, and remove the
hack. It's a hack, I admit it.  But it's better than just saying "be
confused, be broken, I don't care".

If the hack ends up motivating somebody (hint hint) to solve the problem 
properly, I'll be really happy. Paul suggested one solution (don't call 
down to suspend at all - which is also a hack, but I suspect it might be 
about as good a hack as the current one). I suggested another: using type 
checking to make sure drivers _aren't_ confused. 

The more the merrier. Care to come up with a solution of your own?

And no, I'm not interested in the type "let's fix one driver" kind of 
thing. That's what we've had for the last year or more, and the fact is, 
my laptop _never_ suspended during that time. So I really think it needs a 
_proper_ solution.

		Linus
