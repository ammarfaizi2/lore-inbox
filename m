Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUG2Rcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUG2Rcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267534AbUG2RaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:30:16 -0400
Received: from users.linvision.com ([62.58.92.114]:27053 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264833AbUG2R3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:29:18 -0400
Date: Thu, 29 Jul 2004 19:29:12 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Bart Alewijnse <scarfboy@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gigabit trouble
Message-ID: <20040729172912.GL1395@harddisk-recovery.com>
References: <b71082d8040729094537e59a11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71082d8040729094537e59a11@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 06:45:35PM +0200, Bart Alewijnse wrote:
> I just bought two rtl8169 cards, and am having a little trouble.

(Side note: don't know what an rtl8169 costs today, but I'd rather buy
an Intel gigE desktop adapter. Card/driver combination just works
great, no hassle at all.)

> Setup: 
> --
> Old computer: Celeron 400, 8139 nic, 8169 nic
> New computer: XP 1700, 8139 nic, 8169 nic

[...]

> There's a speed increase, from ~4mb in samba and ~6mb in nfs on my
> 100mbit cards to a more hard drive flutter limited ~8 to 10.5MB/s on
> both.

Not spectecular. Even with that kind of hardware you should be able to
do around 20MB/s for NFS (depending on hard drive, of course).

> First problem - that sounds suspiciously like it's hanging around the
> 100mbit limit. I've squeezed a cable the way
> http://www.sql-server-performance.com/jc_gigabit.asp
> suggests, and when I run my new computer under winXP, it reports the
> link speed as 1gbit; also, it's using the gbit cards for transfer,
> I've yanked cables to test.

Gig-ethernet can be a bit picky about cable quality. If the quality is
too low, it will go back too fast ethernet pergormance. Get a straight
Cat 5E cable (i.e.: no cross cable) from your local computershop, that
should just do. Cat 5 usually also works, but is not certified for
gig-ethernet speeds (usually works, if not, use Cat 5E).

> So, question one - how do I see the link speed under linux, and how,
> if at all, do I control it?

Mii-tool or eth-tool.

> Second problem - when doing speed tests (dd if=mounted_remote_nfs file
> of=local_dev_null bs=10M or the like) my new computer makes funny
> noises when doing a 10MB/s transfer. The sound seems to come from the
> power supply, of all things. It's a 450watt, which is 100W more than
> was previously enough; and I'm temporarily using an ancient TNT for a
> vid card. It's not power amount, though possibly power purity and
> distribution; it was a relatively cheap power supply. (But then again
> - that shouldn't have -this- effect, should it?)

I think you're hearing interrupts. Especially with the normal 1500
bytes ethernet MTU and no NAPI, gig-ethernet can send quite some
packets which on their turn will generate quite some interrupts, which
will cause the CPU to do something, which on its turn will cause the
PSU have to put out more power, which you will be able to hear.

> Disturbingly, in such a linux-to-linux speed test, my new computer
> froze.As in, in text mode, have the screen freeze and apparently be
> half written full of nonsense.

What you describe as "nonsense" is most probably a kernel Oops.
Developers are interested in such Oopses, so please mail them to this
mailing list.

> Whereas my old computer, which was doing the exact same thing except
> it was sending (and remember, this computer is about a third the cpu
> speed) said 10MB/s, lived happily.

Different CPU, different compiler flags, different timings, different
things to do. Might be sheer coincidence.

> What's even stranger is that I don't have this problem - noise or
> freezing - when I run my new computer in winXP, where I get
> approximately the same speed.
> 
> It can't be the power supply as winxp works on the same system and setup;
> it can't be a simple case of driver trouble, as the old computer works
> with the same driver and card.

It's not the first time Linux triggers hardware bugs where Windows
doesn't.

> The only thing I can think of is my motherboard - it's given me pci
> transfer troubles before; I have to hit an exact permutation of
> inserted cards to have, say, my sound, network and tv card work
> simultaneously in winxp -or- linux. But even that's not the exact
> problem right now, as it's the same hardware setup that froze linux
> but not xp.

Narrow down the problem. Get out all cards you don't need to reproduce
the problem and try to break the system again.

> So, question two - what possibly happened there?  Is this a
> driver/motherboard coincidence and therefore quite doomed?

No idea, not enough information to tell. See the file REPORTING-BUGS in
your kernel tree and provide more information.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
