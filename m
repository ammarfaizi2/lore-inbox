Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSJPTHE>; Wed, 16 Oct 2002 15:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSJPTHD>; Wed, 16 Oct 2002 15:07:03 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:2701 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261335AbSJPTGa>; Wed, 16 Oct 2002 15:06:30 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 16 Oct 2002 12:20:03 -0700 (PDT)
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
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DADACD6.4000200@netscape.com>
Message-ID: <Pine.LNX.4.44.0210161213520.1548-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >I knew you were going there, aka you do not understand how edge triggered
> >API have to be used.
> >
> Nonsense.
>
> >Even if the API will drop an event at registration
> >time you still cannot use this code scheme :
> >
> >int my_io(...) {
> >
> >	if (event_wait(...))
> >		do_io(...);
> >
> >}
> >
> >You CAN NOT. And look, it is not an API problem, it's your problem that
> >you want to use the API like a poll()-like API.
> >
> You have insufficient basis upon which to claim I would write code as
> broken as above.

Yes I have, look down 15 lines ...


> >This because you have to consume the I/O space to push the level to 0 so
> >that a transaction 0->1 can happen and you can happily receive your
> >events.
> >
> >
> Of course you have to consume the I/O space to push the level to 0.
>  What do you think I am, stupid?
>
> This is done with something like:
>
> for (;;) {
>      fd = event_wait(...);
>      while (do_io(fd) != EAGAIN);
> }

I told you did not understand the API, this code won't work for edge
triggered APIs. Please consider investigating a little bit more before
shooting to perfectly working APIs.




- Davide


