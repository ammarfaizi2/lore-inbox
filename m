Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264861AbSJVVtk>; Tue, 22 Oct 2002 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbSJVVtk>; Tue, 22 Oct 2002 17:49:40 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:54918 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264861AbSJVVtj>; Tue, 22 Oct 2002 17:49:39 -0400
From: Erich Nahum <nahum@watson.ibm.com>
Message-Id: <200210222154.RAA29096@orinoco.watson.ibm.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <Pine.LNX.4.44.0210221258070.1563-100000@blue1.dev.mcafeelabs.com>
 from Davide Libenzi at "Oct 22, 2002 01:06:36 pm"
To: Davide Libenzi <davidel@xmailserver.org>
Date: Tue, 22 Oct 2002 17:54:00 -0400 (EDT)
CC: John Gardiner Myers <jgmyers@netscape.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Reply-to: nahum@watson.ibm.com (Erich M. Nahum)
X-Url: http://www.research.ibm.com/people/n/nahum/
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi writes:
> On Tue, 22 Oct 2002, John Gardiner Myers wrote:
> 
> > > 1. re-arming the one-shot notification when the user gets EAGAIN
> > > 2. re-arming the one-shot notification when the user reads all the data
> > >    that was waiting (such that the very next read would return EGAIN).
> > >
> > > #1 is what Davide wants; I think John and Mark are arguing for #2.
> >
> > No, this is not what I'm arguing.  Once an event arrives for a fd, my
> > proposed semantics are no different than Mr. Libenzi's.  The only
> > difference is what happens upon registration of interest for a fd.  With
> > my semantics, the kernel guarantees that if the fd is ready then at
> > least one event has been generated.  With Mr Libenzi's semantics, there
> > is no such guarantee and the application is required to behave as if an
> > event had been generated upon registration.
> 
> There're a couple of reason's why the drop of the initial event is a waste
> of time :
> 
> 1) The I/O write space is completely available at fd creation
> 2) For sockets it's very likely that the first packet brought something
> 	more than the SYN == The I/O read space might have something for you
> 
> I strongly believe that the concept "use the fd until EAGAIN" should be
> applied even at creation time, w/out making exceptions to what is the
> API's rule to follow.

There is a third way, described in the original Banga/Mogul/Druschel
paper, available via Dan Kegel's web site: extend the accept() call to 
return whether an event has already happened on that FD.  That way you 
can service a ready FD without reading /dev/epoll or calling
sigtimedwait, and you don't have to waste a read() call on the socket
only to find out you got EAGAIN.

Of course, this changes the accept API, which is another matter.  But
if we're talking a new API then there's no problem.

-Erich

