Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWHAN4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWHAN4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWHAN4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:56:06 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17602 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751308AbWHAN4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:56:04 -0400
Date: Tue, 1 Aug 2006 17:55:38 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: James Morris <jmorris@namei.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take2 1/4] kevent: core files.
Message-ID: <20060801135538.GA356@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru> <Pine.LNX.4.64.0608010945090.10827@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608010945090.10827@d.namei>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 01 Aug 2006 17:55:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:46:58AM -0400, James Morris (jmorris@namei.org) wrote:
> On Tue, 1 Aug 2006, Evgeniy Polyakov wrote:
> 
> > +	u->ready_num = 0;
> > +#ifdef CONFIG_KEVENT_USER_STAT
> > +	u->wait_num = u->im_num = u->total = 0;
> > +#endif
> 
> Generally, #ifdefs in the body of the kernel code are discouraged.  Can 
> you abstract these out as static inlines?

Yes, it is possible.
I would ask is it needed at all? It contains number of immediately fired
events (i.e. those which were ready when event was added and thus
syscall returned immediately showing that it is ready), total number of
events, which were inserted in the given queue and number of events
which were marked as ready after they were inserted.
Currently it is compilation option which ends up in printk with above
info when kevent queue is removed.
 
> - James
> -- 
> James Morris
> <jmorris@namei.org>

-- 
	Evgeniy Polyakov
