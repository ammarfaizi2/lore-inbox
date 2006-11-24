Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757593AbWKXLAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbWKXLAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757589AbWKXLAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:00:46 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:11190 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757505AbWKXLAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:00:45 -0500
Date: Fri, 24 Nov 2006 13:58:56 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061124105856.GE13600@2ka.mipt.ru>
References: <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122120933.GA32681@2ka.mipt.ru> <20061122121516.GA7229@2ka.mipt.ru> <4564CE00.9030904@redhat.com> <20061123122225.GD20294@2ka.mipt.ru> <456605EA.5060601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456605EA.5060601@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 13:58:57 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:34:50PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >>>Btw, what about putting aditional multiplexer into add/remove/modify
> >>>switch? There will be logical 'ready' addon?
> >>Is it needed?  Usually this is done with a *_wait call with a timeout of 
> >>zero.  That code path might have to be optimized but it should already 
> >>be there.
> >
> >It does not allow to mark events as ready.
> >And current interfaces wake up when either timeout is zero (in this case
> >thread itself does not sleep and can process events), or when there is
> >_new_ work - since there is no _new_ work, when thread awakened to
> >process it was killed, kernel does not think that something is wrong.
> 
> Rather than mark an existing entry as ready, how about a call to inject 
> a new ready event?
> 
> This would be useful to implement functionality at userlevel and still 
> use an event queue to announce the availability.  Without this type of 
> functionality we'd need to use indirect notification via signal or pipe 
> or something like that.

With provided patch it is possible to wakeup 'for-free' - just call
kevent_ctl(ready) with zero number of ready events, so thread will be
awakened if it was in poll(kevent_fd), kevent_wait() or
kevent_get_events().

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
