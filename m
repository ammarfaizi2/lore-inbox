Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJJAdt>; Wed, 9 Oct 2002 20:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJJAdt>; Wed, 9 Oct 2002 20:33:49 -0400
Received: from relay1.pair.com ([209.68.1.20]:13329 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263208AbSJJAds>;
	Wed, 9 Oct 2002 20:33:48 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DA4CED6.1BD30A2F@kegel.com>
Date: Wed, 09 Oct 2002 17:50:30 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> Linus Torvalds wrote:
> > I really don't get the notion of partial ticks, and quite frankly, this
> > isn't going into my tree until some major distribution kicks me in the
> > head and explains to me why the hell we have partial ticks instead of just
> > making the ticks shorter.
> ...
> 
> Making ticks shorter causes extra overhead ALL the time,
> even when it is not needed.  Higher resolution is not free
> in any case, but it is much closer to free with this patch
> than by increasing HZ (which, of course, can still be
> done).  Overhead wise and resolution wise, for timers, we
> would be better off with a 1/HZ tick and the "on demand"
> high-res interrupts this patch introduces.

Seems reasonable to me.  Increasing HZ adds overhead -
it makes sense to incur the interrupt overhead only when it's
needed.  In my case, we want to provide fairly precise
network delays (we're doing a WAN simulator), and still hit
line rate.   Now, I'm way far from the code, but I suspect that
the interrupt overhead needed to get the precision the customer
is calling for would be totally prohibitive.  I dunno if we'll
get the precision the customer wants with George's approach,
but we'll get a lot closer than we would setting HZ to 10000
on our wimpy little embedded platform.

George's approach would work a lot better when doing lots of UML VM's
on a single box, too, wouldn't it?
- Dan
