Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935765AbWK1JRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935765AbWK1JRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 04:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935762AbWK1JRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 04:17:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:18145 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S935742AbWK1JRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 04:17:49 -0500
Date: Tue, 28 Nov 2006 12:16:02 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
Message-ID: <20061128091602.GC15083@2ka.mipt.ru>
References: <456B2C82.7040700@redhat.com> <20061127.102443.74556125.davem@davemloft.net> <456B3016.9020706@redhat.com> <20061127.104955.48519839.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061127.104955.48519839.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Nov 2006 12:16:06 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 10:49:55AM -0800, David Miller (davem@davemloft.net) wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Mon, 27 Nov 2006 10:36:06 -0800
> 
> > David Miller wrote:
> > > Now we'll have to have a compat layer for 32-bit/64-bit environments
> > > thanks to POSIX timers, which is rediculious.
> > 
> > We already have compat_sys_timer_create.  It should be sufficient just 
> > to add the conversion (if anything new is needed) there.  The pointer 
> > value can be passed to userland in one or two int fields, I don't really 
> > care.  When reporting the event to the user code we cannot just point 
> > into the ring buffer anyway.  So while copying the data we can rewrite 
> > it if necessary.  I see no need to complicate the code more than it 
> > already is.
> 
> Ok, as long as that thing doesn't end up in the ring buffer entry
> data structure, that's where the real troubles would be.

Although ukevent has pointer embedded, it is unioned with u64, so there
should be no problems until 128 bit arch appeared, which likely will not
happen soon. There is also unused in kevent posix timers patch
'u32 ret_val[2]' field, which can store segval's value too.

But the fact that ukevent does not and will not in any way have variable
size is absolutely.

-- 
	Evgeniy Polyakov
