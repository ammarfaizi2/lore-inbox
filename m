Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWHWKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWHWKxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWHWKxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:53:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:28846 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964849AbWHWKwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:52:34 -0400
Date: Wed, 23 Aug 2006 14:51:04 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jari Sundell <sundell.software@gmail.com>
Cc: David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823105104.GA11305@2ka.mipt.ru>
References: <20060822231129.GA18296@ms2.inr.ac.ru> <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com> <20060822.173200.126578369.davem@davemloft.net> <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com> <20060823065659.GC24787@2ka.mipt.ru> <b3f268590608230122k60e3c7c7y939d5559d97107f@mail.gmail.com> <20060823083859.GA8936@2ka.mipt.ru> <b3f268590608230249q653e1dfh1d77c07f6f4e82ce@mail.gmail.com> <20060823102037.GA23664@2ka.mipt.ru> <b3f268590608230334y6814b886tb79da2f59138acd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b3f268590608230334y6814b886tb79da2f59138acd8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 14:51:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 12:34:25PM +0200, Jari Sundell (sundell.software@gmail.com) wrote:
> On 8/23/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> >No, it will change sizes of the structure in kernelspace and userspace,
> >so they just can not communicate.
> 
> struct kevent {
>  uintptr_t ident;        /* identifier for this event */
>  short     filter;       /* filter for event */
>  u_short   flags;        /* action flags for kqueue */
>  u_int     fflags;       /* filter flag value */
> 
>  union {
>    u32       _data_padding[2];
>    intptr_t  data;         /* filter data value */
>  };

As Eric pointed it must be aligned.

>  union {
>    u32       _udata_padding[2];
>    void      *udata;       /* opaque user data identifier */
>  };
> };
> 
> I'm not missing anything obvious here, I hope.

We still do not know what uintptr_t is, and it looks like it is a pointer, 
which is forbidden. Those numbers are not enough to make network AIO.
And actually is not compatible with kqueue already, so you will need to
write your own parser to convert your parameters into above structure.

> Rakshasa
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
