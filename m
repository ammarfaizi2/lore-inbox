Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282959AbRLQW0Q>; Mon, 17 Dec 2001 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLQW0H>; Mon, 17 Dec 2001 17:26:07 -0500
Received: from urtica.linuxnews.pl ([217.67.192.54]:521 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S282959AbRLQWZ5>; Mon, 17 Dec 2001 17:25:57 -0500
Date: Mon, 17 Dec 2001 23:20:35 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Martin Diehl <lists@mdiehl.de>
cc: Dag Brattli <dagb@cs.uit.no>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG()] IrDA in 2.4.16 + preempt
In-Reply-To: <Pine.LNX.4.21.0112161338110.444-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.33.0112172315340.662-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Martin Diehl wrote:

> On Fri, 14 Dec 2001, Pawel Kot wrote:
>
> > I found an annoying problem with irda on 2.4.16.
> > When I remove irlan module I get sementation fault:
> > root@blurp:~# rmmod irlan
> > Dec 14 02:27:35 blurp kernel: kernel BUG at slab.c:1200!
> > Dec 14 02:27:35 blurp kernel: invalid operand: 0000
> > Dec 14 02:27:35 blurp kernel: CPU:    0
> > Dec 14 02:27:35 blurp kernel: EIP:    0010:[kmem_extra_free_checks+81/140] Not tainted
> [...]
> > Dec 14 02:27:35 blurp kernel: Process rmmod (pid: 110, stackpage=cc045000)
> [..]
> > Dec 14 02:27:35 blurp kernel: Call Trace:
>  [kfree+450/576]
>  [netdev_finish_unregister+145/152]
>  [unregister_netdevice+451/632]
>  [unregister_netdev+16/40]
>
> Seems some inconsistency in the way how the irlan netdev is handled:
> having NETIF_F_DYNALLOC set for a netdev which is not allocated as an
> independent object doesn't seem to be a good idea to me ;-)
>
> The patch below simply removes NETIF_F_DYNALLOC just before calling
> unregister_netdev() und should fix the issue. It's untested however,
> since I'm unable to reproduce the Oops on UP without preempt (but it
> should be there as well, due to ipfrag_time for example). At least it
> compiles and doesn't do any harm to me.

It didn't help. Still the same BUGs(). Moreover: it seems that every
network connected process goes into D state. It happens with ifconfig and
ppd for sure.

> Btw., I'm not sure about the status of irlan - I'm only using ppp over
> ircomm or irnet.

In fact I discovered it accidently. I have loaded irlan instead of ircomm
when trying to firnd the reason why connect() on /dev/ircomm0 gives my "No
route to host" every time (with no success) although discivery succeeds.

I'll give it a try without the preempt patch.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku
http://tfuj.pl/cv.html :: http://tfuj.pl/pgp.asc

