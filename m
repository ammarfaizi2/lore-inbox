Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265294AbSJRRb7>; Fri, 18 Oct 2002 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265269AbSJRR1g>; Fri, 18 Oct 2002 13:27:36 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:58344 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265294AbSJRRKB>; Fri, 18 Oct 2002 13:10:01 -0400
Message-ID: <3DB044C6.1080908@kegel.com>
Date: Fri, 18 Oct 2002 10:28:38 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: John Myers <jgmyers@netscape.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9035.2010208@netscape.com> <3DADC5F8.60708@kegel.com> <3DAEF6DC.9000708@netscape.com> <20021018170024.GA13087@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
>>>>>   while (read() == EAGAIN)
>>>>>       wait(POLLIN);
> 
> I find myself still not understanding this thread. Lots of examples of
> code that should or should not be used, but I would always choose:
> 
>    ... ensure file descriptor is blocking ...
>    for (;;) {
>        int nread = read(...);
>        ...
>    }
> 
> Over the above, or any derivative of the above.
> 
> What would be the point of using an event notification mechanism for
> synchronous reads with no other multiplexed options?
> 
> A 'proper' event loop is significantly more complicated. Since everybody
> here knows this... I'm still confused...

I was afraid someone would be confused by the examples.  Davide loves
coroutines (check out http://www.xmailserver.org/linux-patches/nio-improve.html )
and I think his examples are written in that style.  He really means
what you think he should be meaning :-)
which is something like
     while (1) {
         grab next bunch of events from epoll
         for each event
             while (do_io(event->fd) != EAGAIN);
     }
I'm pretty sure.

- Dan


