Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSDIOhY>; Tue, 9 Apr 2002 10:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSDIOhX>; Tue, 9 Apr 2002 10:37:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7686 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291401AbSDIOhW>; Tue, 9 Apr 2002 10:37:22 -0400
Date: Tue, 9 Apr 2002 10:34:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Event logging vs enhancing printk
In-Reply-To: <91260000.1018310069@flay>
Message-ID: <Pine.LNX.3.96.1020409103009.26415A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Martin J. Bligh wrote:

> I think we're talking about slightly different things. I'd agree that
> one call to printk is atomic, and won't get interspersed with other
> things, but if we output a line via multiple calls to printk, then I 
> think we have a problem. Say CPU 0 executes this bit of code:
> 
> for (i=0; i<10; i++) { printk ("%d ", i); } printk("\n");
> 
> and CPU 1 does "printk("hello\n");" then instead of getting either
> 
> 0 1 2 3 4 5 6 7 8 9
> hello
> 
> or 
> 
> hello 
> 0 1 2 3 4 5 6 7 8 9
> 
> either of which would be fine, we may get
> 
> 0 1 2 3 hello
> 4 5 6 7 8 9
> 
> which I don't think is fine - obviously the example is somewhat 
> trite, but with the real instances of things that build output for one
> line through multiple calls to printk, you can get unreadable garbage,
> if I read the code correctly ?

  You read the code correctly, and it follows the intent just fine. When
doing the printk I don't believe you want to introduce any delay in the
output, since often the system is in deep shit by the time the printk
starts.

  If you want buffering you can add it on a case-by-case basis, but in
general I don't believe you do want a delay, because the output might be
lost on a dying system. Prink works like output to stderr, character
buffered. I would think a change to anything this fundimental would be a
Linus decision, but I think it's correct as is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

