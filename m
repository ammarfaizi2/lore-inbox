Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSJPCkS>; Tue, 15 Oct 2002 22:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJPCkS>; Tue, 15 Oct 2002 22:40:18 -0400
Received: from cse.ogi.edu ([129.95.20.2]:60323 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S264806AbSJPCkR>;
	Tue, 15 Oct 2002 22:40:17 -0400
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
References: <Pine.LNX.4.44.0210151601560.1554-100000@blue1.dev.mcafeelabs.com>
	<3DACA5E4.7090509@netscape.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 15 Oct 2002 19:45:27 -0700
In-Reply-To: <3DACA5E4.7090509@netscape.com>
Message-ID: <xu4lm4zf6ew.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Gardiner Myers <jgmyers@netscape.com> writes:

> The epoll API is deficient--it is subtly error prone and it forces
> work on user space that is better done in the kernel.  That the API
> is specified in a deficient way does not make it any less deficient.

You can argue that any API is subtly error prone.  The whole sockets
API is that way.  That's why the W. Richard Stevens network
programming books are such gems.  That's why having access to kernel
source is invaluable.  You have to pay attention to details to avoid
errors.

With /dev/epoll, it is perfectly feasible to write user level
wrapper libraries that help avoid the potential pitfalls.

I think it was Dan Kegel who has already mentioned one. 

I've written one myself, and I'm very confident in it.  I've written a
traffic generator application on top of my library that stresses the
Linux kernel protocol stack to the extreme.  It generates the
proverbial 10k cps, saturates gigabit networks, etc.

It has no problem running over /dev/epoll.  

IMHO, the code inside my wrapper library for the epoll case is
significantly easier to understand than the code for the case that
uses the legacy poll() interface.

If /dev/epoll were so error prone as you say it is, I think I would
have noticed it.  

-- Buck

ps If anybody cares. I can give them a pointer to my code.

> Again, there is no rational justification for the kernel to not test
> the condition upon registration.  There is ample justification for
> it to do so.


