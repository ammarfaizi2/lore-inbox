Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDCWf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUDCWf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:35:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:64662 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261993AbUDCWfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:35:54 -0500
Date: Sat, 3 Apr 2004 23:35:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll reporting events when it hasn't been asked to)
Message-ID: <20040403223541.GB6122@mail.shareable.org>
References: <20040402184035.GA653@mail.shareable.org> <Pine.LNX.4.44.0404031334440.2122-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404031334440.2122-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Looking at poll(2) though, it seems that it does the same thing if
> you set the event mask to 0. So epoll is coherent with poll(2) in this.

Yes.  SUSv3 says POLLHUP, POLLERR and POLLNVAL are always reported
even if not requested.

> I personally believe that an application should handle those
> exceptional events in any case, by simply removing the fd from the
> epoll set (and lazily freeing the associated userspace data structures).

Take a look at the new subject line :)

Linux select() treats it as an input-only condition, implying that
there might be useful things you can do with output to a file
descriptor that's reporting POLLHUP, including waiting for output.

However, SUSv3 says "This event [POLLHUP]and POLLOUT are mutually
exclusive; a stream can never be writable if a hangup has occurred",
implying that Linux select() is the oddity.

> So, if no big argouments will come against this, I'd rather prefer to keep 
> such behaviour. OTOH the patch would be trivial (one or two lines) , so 
> there will be no design problems in doing this.

I agree, in fact I'd argue specifically against changing it.

Programmers familiar with poll() know that you don't have to set
POLLHUP in the input mask -- because SUSv3 says so ("This flag
[POLLHUP] is only valid in the revents bitmask; it is ignored in the
events member").  They'd not be likely to notice a difference that
subtle for epoll, when they convert application code, so it's good
that there isn't a difference.

Btw, I notice epoll never reports POLLNVAL.  Is that correct?

-- Jamie
