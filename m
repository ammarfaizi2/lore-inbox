Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263747AbRFHOUh>; Fri, 8 Jun 2001 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263789AbRFHOU1>; Fri, 8 Jun 2001 10:20:27 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:31497 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S263747AbRFHOUZ>;
	Fri, 8 Jun 2001 10:20:25 -0400
Date: Fri, 8 Jun 2001 16:19:17 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106081440300.389-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0106081532140.2013-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Mike Galbraith wrote:
> I gave this a shot at my favorite vm beater test (make -j30 bzImage)
> while testing some other stuff today.

Could you please explain what is good about this test?  I understand that
it will stress the VM, but will it do so in a realistic and relevant way?

Isn't the interesting case when you have a number of processes using lots
of memory, but only a part of all that memory is beeing actively used, and
that memory fits in RAM.  In that case, the VM should make sure that the
not used memory is swapped out.  In RAM you should have the used memory,
but also disk cache if there is any RAM left.  Does the current VM handle
this case fine yet?  IMHO, this is the case most people care about.  It is
definately the case I care about, at least. :-)

I'm not saying that it's a completely uninteresting case when your active
memory is bigger than you RAM of course, but perhaps there should be other
algorithms handling that case, such as putting some of the swapping
processes to sleep for some time, especially if you have lots of processes
competing for the memory. I may be wrong, but it seems to me that your
testcase falls into this second category (also known as thrashing).

An at last, a humble request:  Every problem I've had with the VM has been
that it either swapped out too many processes and used too much cache, or
the other way around.  I'd really enjoy a way to tune this behaviour, if
possible.

/Tobias

