Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274221AbRISV5T>; Wed, 19 Sep 2001 17:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274222AbRISV5L>; Wed, 19 Sep 2001 17:57:11 -0400
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:6547 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274221AbRISV4z>;
	Wed, 19 Sep 2001 17:56:55 -0400
X-Sent: 19 Sep 2001 21:57:12 GMT
Message-ID: <3BA912EA.F29B5AD9@distributopia.com>
Date: Wed, 19 Sep 2001 16:49:30 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919123029.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> >     - check new_socket_fd for readable, writable, and
> >       error. if any true, then add new event to
> >       event queue, as if the state had changed.
> 
> No it does't check. It's not needed for how it works.
> 

 Yes, I see that it currently works that way. I'm
suggesting that it's a needlessly awkward way to work.
It also results in thousands of spurious syscalls a
second as servers are forced to double check there
isn't i/o to be done.

 This is frustrating, as the application must ask for
information that the kernel could have easily provided
in the first place.

 Providing an initial set of events makes application
programming easier, doesn't appear to add significant
complexity to the driver (maybe), greatly reduces the
number of required system calls, and still fits neatly
into the conceptual api model. It seems like a clear
win.


> I intentionally changed the name to epoll because it
> works in a different way.
>

 Am I missing something? I don't think you'd need a
linear scan of anything, and there wouldn't be any
changes to the api. Existing code would work exactly
the same. Etc.

 It's Davide's patch, and if he doesn't like my
suggestion, I certainly don't expect him to change his
code. If there's any consensus that the "initial event
set" behavior is a good thing, I'd be willing to whip
up a patch to Davide's patch. OTOH, if there's a good
reason the changes are a bad thing, I don't want to
confuse the issue with yet-another /dev/poll variant.

 Does anybody else have an opinion?


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
