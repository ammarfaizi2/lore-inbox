Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbSJQTG3>; Thu, 17 Oct 2002 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJQTG2>; Thu, 17 Oct 2002 15:06:28 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60046 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261818AbSJQTG1>; Thu, 17 Oct 2002 15:06:27 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Oct 2002 12:20:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Charles 'Buck' Krasic" <krasic@acm.org>
cc: John Gardiner Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <xu4fzv4ucll.fsf@brittany.cse.ogi.edu>
Message-ID: <Pine.LNX.4.44.0210171213440.1631-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Oct 2002, Charles 'Buck' Krasic wrote:

>
> Hi Davide,
>
> On thinking about this a bit, I wonder if the evtmask isn't superflous
> in sys_epoll_addf? (And in the existing epoll interface where the
> application writes to /dev/epoll).
>
> As you say, the normal usage will be to register for all events
> anyway.  My wrapper library does exactly that.  As you say, not having
> to continously switch the mask is the simpler way to go.  If
> registering for all events is the only sensible approach, the argument
> isn't needed at all.
>
> What do you think?  It's a minor detail, I know.

Even if it is the fastest way to use the API, iI would still prefer such
behaviour to be encoded in wrapper libraries instead of inside the API
itself. Having a choice is usually better that not having it, if the cost
for having a choice is not too much ( and in this particular case is not ).


> Taking the idea further, I would prefer that ALL non-blocking sockets
> are automatically added to the epoll interest set if the application
> has already called epoll_create().  Maybe that behaviour could be an
> option to epoll_create().

Same thing, I would leave this task to your my_socket() and my_accept().
I think what is really missing about /dev/epoll is an easy-to-use
interface library to avoid users confused by the presence of "poll" inside
its name, to use it like select()/poll().


> BTW, I'm not clear on another aspect of the API below, is there still
> an mmap() for the pollfd buffers?

Yes, it creates a mapping shared between the kernel and the user space.



- Davide


