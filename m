Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbWHKH20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWHKH20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWHKH20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:28:26 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50894 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1161190AbWHKH2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:28:25 -0400
Date: Fri, 11 Aug 2006 11:27:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060811072748.GA14398@2ka.mipt.ru>
References: <20060810061433.GA4689@2ka.mipt.ru> <20060810001844.ff5e7429.akpm@osdl.org> <20060810075047.GB24370@2ka.mipt.ru> <20060810010254.3b52682f.akpm@osdl.org> <20060810082235.GA21025@2ka.mipt.ru> <20060810175639.b64faaa9.akpm@osdl.org> <20060811061535.GA11230@2ka.mipt.ru> <20060810232340.ab326d3f.akpm@osdl.org> <20060811063018.GB11230@2ka.mipt.ru> <20060811000454.d0345288.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060811000454.d0345288.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 11 Aug 2006 11:27:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 12:04:54AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > This area can be decreased down to 70mb by reducing amount of
> > information placed into the buffer (only user's data and flags) without
> > additional hints.
> > 
> 
> 70MB is still very bad, naturally.

Actually I do not think that 4k events is a good choice - I expect people
will scale it to tens of thousands at least, so we definitely want not to
allow user to create way too many kevent fds.

> There are other ways in which users can do this sort of thing - passing
> fd's across sockets, allocating zillions of pagetables come to mind.  But
> we don't want to add more.
> 
> Possible options:
> 
> - Add a new rlimit for the number of kevent fd's
> 
> - Add a new rlimit for the amount of kevent memory
> 
> - Add a new rlimit for the total amount of pinned kernel memory.  First
>   user is kevent.

I think this rlimit and first one are the best choises.

> - Account a kevent fd as being worth 100 regular fds, so the naughty user
>   hits EMFILE early (ug).
> 
> A new rlimit is attractive, and they're easy to add.  Problem is, userspace
> support is hard (I think).  afaik a standard Linux system doesn't have
> global and per-user rlimit config files which are parsed and acted upon at
> login.  That would make rlimits more useful.

As for now it is possible to use stack size rlimit for example.

-- 
	Evgeniy Polyakov
