Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSJVV4z>; Tue, 22 Oct 2002 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSJVV4z>; Tue, 22 Oct 2002 17:56:55 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:17099 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264908AbSJVV4y>; Tue, 22 Oct 2002 17:56:54 -0400
Message-ID: <3DB5CE75.6010400@kegel.com>
Date: Tue, 22 Oct 2002 15:17:25 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Erich M. Nahum" <nahum@watson.ibm.com>
CC: Davide Libenzi <davidel@xmailserver.org>,
       John Gardiner Myers <jgmyers@netscape.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <200210222154.RAA29096@orinoco.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Nahum wrote:
>>There're a couple of reason's why the drop of the initial event is a waste
>>of time :
>>
>>1) The I/O write space is completely available at fd creation
>>2) For sockets it's very likely that the first packet brought something
>>	more than the SYN == The I/O read space might have something for you
>>
>>I strongly believe that the concept "use the fd until EAGAIN" should be
>>applied even at creation time, w/out making exceptions to what is the
>>API's rule to follow.
> 
> 
> There is a third way, described in the original Banga/Mogul/Druschel
> paper, available via Dan Kegel's web site: extend the accept() call to 
> return whether an event has already happened on that FD.  That way you 
> can service a ready FD without reading /dev/epoll or calling
> sigtimedwait, and you don't have to waste a read() call on the socket
> only to find out you got EAGAIN.
> 
> Of course, this changes the accept API, which is another matter.  But
> if we're talking a new API then there's no problem.

That would be the fastest way of finding out, maybe.
But I'd rather use a uniform way of notifying about readiness events.
Rather than using a new API (acceptEx :-) or a rule ("always ready initially"),
when not just deliver the initial readiness event via the usual channel?
And for ease of coding for the moment, David can just deliver
a 'ready for everything' event initially unconditionally.

No API changes, just a simple, uniform way of tickling the user's
"I gotta do I/O" code.
- Dan


