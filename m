Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJVTvj>; Tue, 22 Oct 2002 15:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSJVTvj>; Tue, 22 Oct 2002 15:51:39 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:64155 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262139AbSJVTvh>; Tue, 22 Oct 2002 15:51:37 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 22 Oct 2002 13:06:36 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DB5A86F.3000802@netscape.com>
Message-ID: <Pine.LNX.4.44.0210221258070.1563-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, John Gardiner Myers wrote:

>
>
> Dan Kegel wrote:
>
> > The choice I see is between:
> > 1. re-arming the one-shot notification when the user gets EAGAIN
> > 2. re-arming the one-shot notification when the user reads all the data
> >    that was waiting (such that the very next read would return EGAIN).
> >
> > #1 is what Davide wants; I think John and Mark are arguing for #2.
>
> No, this is not what I'm arguing.  Once an event arrives for a fd, my
> proposed semantics are no different than Mr. Libenzi's.  The only
> difference is what happens upon registration of interest for a fd.  With
> my semantics, the kernel guarantees that if the fd is ready then at
> least one event has been generated.  With Mr Libenzi's semantics, there
> is no such guarantee and the application is required to behave as if an
> event had been generated upon registration.

sed s/Mr. Libenzi/Davide/g ... I'm not that old :)
There're a couple of reason's why the drop of the initial event is a waste
of time :

1) The I/O write space is completely available at fd creation
2) For sockets it's very likely that the first packet brought something
	more than the SYN == The I/O read space might have something for you

I strongly believe that the concept "use the fd until EAGAIN" should be
applied even at creation time, w/out making exceptions to what is the
API's rule to follow.



- Davide


