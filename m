Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbSJPXhc>; Wed, 16 Oct 2002 19:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJPXhc>; Wed, 16 Oct 2002 19:37:32 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:52110 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261537AbSJPXhb>; Wed, 16 Oct 2002 19:37:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Oct 2002 16:51:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DADF6C6.8020404@netscape.com>
Message-ID: <Pine.LNX.4.44.0210161644240.1548-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >I told you did not understand the API, this code won't work for edge
> >triggered APIs.
> >
> Nonsense.  If you wish to make such a claim, you need to provide an
> example of a situation in which it won't work.

Your welcome. This is your code :

for (;;) {
     fd = event_wait(...);
     while (do_io(fd) != EAGAIN);
}

If the I/O space is not exhausted when you call event_wait(...); you'll
never receive the event because you'll be waiting a 0->1 transaction
without bringing the signal to 0 ( I/O space exhausted ). That one is a
typical use of poll() - select() - /dev/poll and you showed pretty clearly
that you do not seem to understand edge triggered event APIs. If you code
your I/O function like :

int my_io(...) {

	if (event_wait(...))
		do_io(...);

}

and you consume only part of the I/O space with the first call to my_io(),
the second call will block _infinitely_.



- Davide


