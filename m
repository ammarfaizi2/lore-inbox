Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSIEFRK>; Thu, 5 Sep 2002 01:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSIEFRJ>; Thu, 5 Sep 2002 01:17:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:5872 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316886AbSIEFRJ>; Thu, 5 Sep 2002 01:17:09 -0400
Date: Thu, 5 Sep 2002 01:21:43 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020905012143.B7979@redhat.com>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <20020816100334.GP14394@dualathlon.random> <20020816165306.A2055@in.ibm.com> <20020902184043.GN1210@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902184043.GN1210@dualathlon.random>; from andrea@suse.de on Mon, Sep 02, 2002 at 08:40:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 08:40:43PM +0200, Andrea Arcangeli wrote:
> Could somebody explain the semantics of the io_queue_wait call in the
> libaio? If you pass nr == 0 to getevents, getevents will do nothing. I
> don't see the point of it so I'm unsure what's the right implementation.

It was supposed to wait for events to be ready.  In reality what ended up 
happening is that people don't actually like to use io_queue_run/wait and 
the function callbacks as Linus originally suggested in the event model, 
and instead they prefer to use io_getevents directly.  libaio just hasn't 
been updated to reflect that yet.

> then about the 2.5 API we have such min_nr that allows the "at least
> min_nr", instead of the previous default of "at least 1", so that it
> allows implementing the aio_nwait of aix.

It was also required to break source compilation for the timeout update.

> BTW, the libaio I'm adapting to test on my tree will not have the
> libredhat thing anymore, and it will use the mainline 2.5 API since the
> API is registered now and in the very worst case a non backwards
> compatible API change would happen in late 2.5, replacing libaio.so is
> not more complex than replacing libredhat.so anyways ;).

That was already the intent for libaio-0.4.0.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
