Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946029AbWGOMWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946029AbWGOMWm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 08:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWGOMWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 08:22:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26087 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946029AbWGOMWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 08:22:42 -0400
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality
	permits it
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <200607151429.32298.a1426z@gawab.com>
References: <200607112257.22069.a1426z@gawab.com>
	 <200607132351.04721.a1426z@gawab.com>
	 <1152824071.3024.89.camel@laptopd505.fenrus.org>
	 <200607151429.32298.a1426z@gawab.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 14:22:39 +0200
Message-Id: <1152966159.3114.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 14:29 +0300, Al Boldi wrote:
> Arjan van de Ven wrote:
> > > BTW, why does randomize_stack_top() mod against (8192*1024) instead of
> > > (8192) like arch_align_stack()?
> >
> >  because it wants to randomize for 8Mb, unlike arch_align_stack which
> > wants to randomize the last 8Kb within this 8Mb ;)
> 
> Randomizing twice?

a VMA can only be randomized in 4Kb (well page size) granularity, so the
8Mb randomization can only work in that 4Kb unit, the "second"
randomization can work in 16 byte granularity.

> There is even a case where a mere rename or running through an extra shell 
> causes a slowdown.  And that's with randomization turned off.

randomization off will slow stuff down yes... you get cache alias
contention that way.




> 2.4.31 doesn't show these slowdowns.

2.4.31 randomizes the stack with 8Kb.

> What is 2.6 doing?

you're not providing a lot of info ;)

why do you suspect randomization as cause for whatever slowdown you are
seeing? What kind of slowdown are you seeing?


