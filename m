Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbSJQSly>; Thu, 17 Oct 2002 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbSJQSly>; Thu, 17 Oct 2002 14:41:54 -0400
Received: from cse.ogi.edu ([129.95.20.2]:31723 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S261811AbSJQSlx>;
	Thu, 17 Oct 2002 14:41:53 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210160618190.1548-100000@blue1.dev.mcafeelabs.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 17 Oct 2002 11:47:18 -0700
In-Reply-To: <Pine.LNX.4.44.0210160618190.1548-100000@blue1.dev.mcafeelabs.com>
Message-ID: <xu4fzv4ucll.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Davide,

On thinking about this a bit, I wonder if the evtmask isn't superflous
in sys_epoll_addf? (And in the existing epoll interface where the
application writes to /dev/epoll).

As you say, the normal usage will be to register for all events
anyway.  My wrapper library does exactly that.  As you say, not having
to continously switch the mask is the simpler way to go.  If
registering for all events is the only sensible approach, the argument
isn't needed at all.

What do you think?  It's a minor detail, I know.

Taking the idea further, I would prefer that ALL non-blocking sockets
are automatically added to the epoll interest set if the application
has already called epoll_create().  Maybe that behaviour could be an
option to epoll_create().   

BTW, I'm not clear on another aspect of the API below, is there still
an mmap() for the pollfd buffers?   

-- Buck

Davide Libenzi <davidel@xmailserver.org> writes:

> The /dev/epoll usage is IMHO very simple. Once the I/O fd is created you
> register it with POLLIN|POLLOUT and you leave it inside the monitor set
> until it is needed ( mainly until you close() it ). It is not necessary to
> continuosly switch the event mask from POLLIN and POLLOUT. An hypothetical
> syscall API should look like :

> int sys_epoll_create(int maxfds);
> void sys_epoll_close(int epd);
> int sys_epoll_addfd(int epd, int fd, int evtmask);
> int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);

> with the option ( if benchmarks will give positive results ) like Ben
> suggested, of using the AIO event collector instead of sys_epoll_wait().

> - Davide
