Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbSJRRjn>; Fri, 18 Oct 2002 13:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265284AbSJRR1Q>; Fri, 18 Oct 2002 13:27:16 -0400
Received: from netrealtor.ca ([216.209.85.42]:28936 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265282AbSJRQzP>;
	Fri, 18 Oct 2002 12:55:15 -0400
Date: Fri, 18 Oct 2002 13:00:24 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: John Myers <jgmyers@netscape.com>
Cc: Dan Kegel <dank@kegel.com>, Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
Message-ID: <20021018170024.GA13087@mark.mielke.cc>
References: <Pine.LNX.4.44.0210151403370.1554-100000@blue1.dev.mcafeelabs.com> <3DAC9035.2010208@netscape.com> <3DADC5F8.60708@kegel.com> <3DAEF6DC.9000708@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAEF6DC.9000708@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>    while (read() == EAGAIN)
> >>>        wait(POLLIN);

I find myself still not understanding this thread. Lots of examples of
code that should or should not be used, but I would always choose:

   ... ensure file descriptor is blocking ...
   for (;;) {
       int nread = read(...);
       ...
   }

Over the above, or any derivative of the above.

What would be the point of using an event notification mechanism for
synchronous reads with no other multiplexed options?

A 'proper' event loop is significantly more complicated. Since everybody
here knows this... I'm still confused...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

