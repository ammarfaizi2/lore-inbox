Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSDOIAY>; Mon, 15 Apr 2002 04:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDOIAX>; Mon, 15 Apr 2002 04:00:23 -0400
Received: from [61.149.35.255] ([61.149.35.255]:41476 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S313054AbSDOIAW>;
	Mon, 15 Apr 2002 04:00:22 -0400
Date: Mon, 15 Apr 2002 16:00:18 +0800
From: hugang <gang_hu@soul.com.cn>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kmem_cache_grow.
Message-Id: <20020415160018.012f01dd.gang_hu@soul.com.cn>
In-Reply-To: <3CBA835D.484DB0B1@zip.com.au>
Organization: soul
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank your. Your are right, I use devfs. 
When I disable the devfs, I insert and eject pcmcia card , The linux is fine .

On Mon, 15 Apr 2002 00:38:05 -0700
Andrew Morton <akpm@zip.com.au> wrote:

> hugang wrote:
> > 
> > Hell all:
> > 
> > Problem: first run "find /" , eject and insert pcmcia network's card, the kernel will crash.
> > 
> > Kernel oops: at
> > linux/mm/slab.c->kmem_cache_grow.
> >         if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
> >                 BUG();          <-- here.
> 
> Known problem, I'm afraid.  The PCMCIA Card Services layer
> in a number of places is doing stuff from inside a timer
> handler which it should not be.
> 
> > Can I remove this check ?
> 
> It's best not to, really.  It'll probably appear to have
> worked but your kernel could still fail in mysterious ways,
> much later, very occasionally.
> 
> If you're using devfs, you could try disabling that.  Not
> that this is a devfs bug, but disabling devfs reduces 
> the number of functions which the buggy drivers call at
> timer-interrupt time.
> 
> The bottom line is that we have a pcmcia_cs staffing shortage.
> Somebody needs to go in, pull out the timers, use schedule_task().
> 
> -
> 


-- 
thanks with regards!
hugang.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************
