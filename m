Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbUDFHDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUDFHDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:03:19 -0400
Received: from linuxhacker.ru ([217.76.32.60]:38546 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263643AbUDFHDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:03:10 -0400
Date: Tue, 6 Apr 2004 10:02:45 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.4] NMI WD detected lockup during page alloc
Message-ID: <20040406070245.GB1819@linuxhacker.ru>
References: <20040404121756.GA8854@linuxhacker.ru> <20040405204317.GA13528@logos.cnet> <20040405212734.GA1819@linuxhacker.ru> <20040405221255.GM2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405221255.GM2234@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Apr 06, 2004 at 12:12:55AM +0200, Andrea Arcangeli wrote:
> > In addition to what I have compiled in:
> > # lsmod
> > Module                  Size  Used by    Not tainted
> > ppp_deflate             4568   1  (autoclean)
> you may want to disable compression, this sounds like mm corruption and
> compression isn't trivial to handle in kernel skbs (though I doubt this
> is the problem but it's easy to disable).

Ok.

> > ipt_state               1016   4  (autoclean)
> the hang while unloading this module may also be a sign of a bug in the
> module so it would be nice if you could reproduce also w/o the above
> ips_state.

Unfortunatelly this is not as easy to do, though I believe there is just some
sort or race on unload that is not being hit until module is unloaded and
therefore it is completely not related.

> If this still doesn't help then you can try to go UP again, SMP is
> harder at stressing the memory bus and see if it stabilizes. Other thing
> you can do is to remove half of the ram and see if it stabilizes to try
> to identify buggy ram slots.

There I have ECC RAM, passed 14 days of memtest (yes, I know memtest uses
only 1 CPU), so I do not think I have memory problems, though this is not
absolute guarantee against that of course.
Also running in UP mode for weeks is not all that funny and still proves nothing
as I do not have clear way to reproduce it in certain time.

> Overall it's unlikely the oops is useful unfortunately since that piece
> of the kernel is the most stressed ever, and it just signals random mm
> corruption. I assume this is the first time you've got the nmi watchdog
> oops, if you could get it again it would be more interesting, I'd expect
> next time you would get it in another place.

Well, I had a hang before this oops and that was main reason I enabled NMI
watchdog. At that first hang nothing get to serial console so I guessed
it was similar spinlock deadlock.
We'll see what I get when another NMI watchdog thing occurs. I run
with spinlock debug this time, so hopefully if spinlock is really just
corrupted, its magic would be corrupted as well and I get clear warning about
that.

Thank you.

Bye,
    Oleg
