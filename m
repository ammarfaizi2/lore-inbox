Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbTAJXAJ>; Fri, 10 Jan 2003 18:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbTAJXAJ>; Fri, 10 Jan 2003 18:00:09 -0500
Received: from palrel11.hp.com ([156.153.255.246]:62884 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S266584AbTAJXAI>;
	Fri, 10 Jan 2003 18:00:08 -0500
Date: Fri, 10 Jan 2003 15:07:31 -0800
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110230731.GC23108@cup.hp.com>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com> <20030110010906.GC18141@cup.hp.com> <m1y95tzbdq.fsf@frodo.biederman.org> <20030110190030.GA23108@cup.hp.com> <20030111004239.A757@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111004239.A757@localhost.park.msu.ru>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 12:42:39AM +0300, Ivan Kokshaysky wrote:
> Eh? In general case, to make room for newly added device, you have
> to shutdown the whole PCI bus starting from level 0, reassign _all_
> BARs and bridge windows and then restart...

That might be true for x86. I'm pretty sure it's not true for the
parisc machines I'm familiar with. One "window" register is set to
a "default" at boot time by the firmware and behaves as you describe above.
But a *second* window register in the PCI controller was intended
for dynamic MMIO assignment in case the first one was too small.
The trick is to find MMIO space in the region already being routed
by the IOC (parent of the PCI controller). My point is a second
somewhat larger MMIO region can be routed to a few additional PCI
controllers given sufficient MMIO space.

Again, I believe HP's ia64 HW has leveraged this design but I haven't
checked specs. And methods to reprogram the window registers might
require firmware to do it instead of the OS.

> The "hotplug resource reservation" is the only viable approach, it has
> been discussed numerous times.

ok - I'll to look for those when the time comes.


> I believe 1GB is a theoretical maximum for a 32-bit BAR.

2GB. But my argument is enough "bigger" BARs may not work either.

grant
