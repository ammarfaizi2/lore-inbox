Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSJPUCQ>; Wed, 16 Oct 2002 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJPUCQ>; Wed, 16 Oct 2002 16:02:16 -0400
Received: from adedition.com ([216.209.85.42]:14604 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261278AbSJPUCP>;
	Wed, 16 Oct 2002 16:02:15 -0400
Date: Wed, 16 Oct 2002 16:06:20 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021016200620.GA9067@mark.mielke.cc>
References: <Pine.LNX.4.44.0210160717190.1548-100000@blue1.dev.mcafeelabs.com> <3DADACD6.4000200@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DADACD6.4000200@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:15:50AM -0700, John Gardiner Myers wrote:
> Davide Libenzi wrote:
> >This because you have to consume the I/O space to push the level to 0 so
> >that a transaction 0->1 can happen and you can happily receive your
> >events.
> This is done with something like:
> for (;;) {
>     fd = event_wait(...);
>     while (do_io(fd) != EAGAIN);
> }
> Trying to do at once as much work as one can on a given fd helps keep 
> that fd's context information in cache.  If one needs to have the fd 
> yield the CPU in order to reduce system latency, one generates a 
> user-mode event.

Not to enter into any of the other discussions on this issue, I wouldn't
usually do what you suggest above. Sure, for operations like accept() that
are inherently inefficient, I would loop until EAGAIN, but if I did I
a recv() or read() of 2K, and I only received 1K, there is no reason why
another system call should be invoked on the resource that likely will not
have any data ready.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

