Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274777AbRIUSl6>; Fri, 21 Sep 2001 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274778AbRIUSlt>; Fri, 21 Sep 2001 14:41:49 -0400
Received: from [208.129.208.52] ([208.129.208.52]:50189 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274777AbRIUSlp>;
	Fri, 21 Sep 2001 14:41:45 -0400
Message-ID: <XFMail.20010921114539.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BAADC9A.EE129CF7@kegel.com>
Date: Fri, 21 Sep 2001 11:45:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Sep-2001 Dan Kegel wrote:
> Davide wrote:
>> If you need to request the current status of 
>> a socket you've to f_ops->poll the fd.
>> The cost of the extra read, done only for fds that are not "ready", is nothing
>> compared to the cost of a linear scan with HUGE numbers of fds.
> 
> Hey, wait a sec, Davide... the whole point of the Solaris /dev/poll
> is that you *don't* need to f_ops->poll the fd, I think.
> And in fact, Solaris /dev/poll is insanely fast, way faster than O(N).

If the fd support hints, yes.


> Consider this: what if we added to your patch logic to clear
> the current read readiness bit for a fd whenever a read() on
> that fd returned EWOULDBLOCK?  Then we're real close to having
> the current readiness state for each fd, as the /dev/poll afficianados 
> want.  Now, there's a lot more work that'd be needed, but maybe you
> get the idea of where some of us are coming from.

Then you'll fall down to /dev/poll and /dev/epoll designed for "state change"
driven servers ( like rtsigs ).
Instead of requesting /dev/epoll changes to make it something that is not born for,
i think that the /dev/poll patch can be improved in a significant way.
The numbers i've got from my test left me quite a bit deluded.




- Davide

