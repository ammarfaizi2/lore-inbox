Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135985AbREGDnU>; Sun, 6 May 2001 23:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135981AbREGDnA>; Sun, 6 May 2001 23:43:00 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:11198 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135980AbREGDmx>; Sun, 6 May 2001 23:42:53 -0400
Message-ID: <3AF61C68.3FC7F66B@didntduck.org>
Date: Sun, 06 May 2001 23:54:16 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <Pine.LNX.4.21.0105061750010.11175-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 5 May 2001, Brian Gerst wrote:
> >
> > Currently the page fault handler on the x86 can get a clobbered value
> > for %cr2 if an interrupt occurs and causes another page fault (interrupt
> > handler touches a vmalloced area for example) before %cr2 is read.
> 
> That should be ok.
> 
> Yes, we'll get a clobbered value, but we'll get a _valid_ clobbered value,
> and we'll just end up doing the fixups twice (and returning to the user
> process that didn't get the page it wanted, which will end up re-doing the
> page fault).
> 
> [ Looks closer.. ]
> 
> Actually, the second time we'd do the fixup we'd be unhappy, because it
> has already been done. That test should probably be removed. Hmm.
> 
> Hmm.. The threading people wanted this same thing. Maybe we should just
> make it so.
> 
>                 Linus

I think it's better to be on the side of correctness.  I designed the
patch to have interrupts disabled for the minimum time possible, so
there should be nearly no impact.

--
					Brian Gerst
