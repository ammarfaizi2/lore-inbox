Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWHAO1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWHAO1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWHAO1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:27:41 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:45952 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751627AbWHAO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:27:40 -0400
Date: Tue, 1 Aug 2006 10:27:36 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take2 1/4] kevent: core files.
In-Reply-To: <20060801135538.GA356@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0608011024380.11168@d.namei>
References: <11544248451203@2ka.mipt.ru> <Pine.LNX.4.64.0608010945090.10827@d.namei>
 <20060801135538.GA356@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Evgeniy Polyakov wrote:

> On Tue, Aug 01, 2006 at 09:46:58AM -0400, James Morris (jmorris@namei.org) wrote:
> > On Tue, 1 Aug 2006, Evgeniy Polyakov wrote:
> > 
> > > +	u->ready_num = 0;
> > > +#ifdef CONFIG_KEVENT_USER_STAT
> > > +	u->wait_num = u->im_num = u->total = 0;
> > > +#endif
> > 
> > Generally, #ifdefs in the body of the kernel code are discouraged.  Can 
> > you abstract these out as static inlines?
> 
> Yes, it is possible.
> I would ask is it needed at all?

Yes, please, it is standard kernel development practice.

Otherwise, the kernel will turn into an unmaintainable #ifdef jungle.

> It contains number of immediately fired
> events (i.e. those which were ready when event was added and thus
> syscall returned immediately showing that it is ready), total number of
> events, which were inserted in the given queue and number of events
> which were marked as ready after they were inserted.
> Currently it is compilation option which ends up in printk with above
> info when kevent queue is removed.

Fine, make 

static inline void kevent_user_stat_reset(u);

etc.

which compile to nothing when it's not confifgured.


-- 
James Morris
<jmorris@namei.org>
