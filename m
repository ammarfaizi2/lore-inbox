Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSJYIJj>; Fri, 25 Oct 2002 04:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJYIJj>; Fri, 25 Oct 2002 04:09:39 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:46767 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261302AbSJYIJi> convert rfc822-to-8bit; Fri, 25 Oct 2002 04:09:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, landley@trommello.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Date: Fri, 25 Oct 2002 10:15:46 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200210242351.56719.efocht@ess.nec.de> <2862423467.1035473915@[10.10.2.3]>
In-Reply-To: <2862423467.1035473915@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210251015.46388.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 October 2002 00:38, Martin J. Bligh wrote:
> > The situation is really funny: Everybody seems to agree that the design
> > ideas in my NUMA aproach are sane and exactly what we want to have on
> > a NUMA platform in the end. But instead of concentrating on tuning the
> > parameters for the many different NUMA platforms and reshaping this
> > aproach to make it acceptable, IBM concentrates on a very much stripped
> > down aproach.
>
> From my point of view, the reason for focussing on this was that
> your scheduler degraded the performance on my machine, rather than
> boosting it. Half of that was the more complex stuff you added on
> top ... it's a lot easier to start with something simple that works
> and build on it, than fix something that's complex and doesn't work
> well.

You're talking about one of the first 2.5 versions of the patch. It
changed a lot since then, thanks to your feedback, too.

> I still haven't been able to get your scheduler to boot for about
> the last month without crashing the system. Andrew says he has it
> booting somehow on 2.5.44-mm4, so I'll steal his kernel tommorow and
> see how it looks. If the numbers look good for doing boring things
> like kernel compile, SDET, etc, I'm happy.

I thought this problem is well understood! For some reasons independent of
my patch you have to boot your machines with the "notsc" option. This
leaves the cache_decay_ticks variable initialized to zero which my patch
doesn't like. I'm trying to deal with this inside the patch but there is
still a small window when the variable is zero. In my opinion this needs
to be fixed somewhere in arch/i386/kernel/smpboot.c. Booting a machine
with cache_decay_ticks=0 is pure nonsense, as it switches off cache
affinity which you absolutely need! So even if "notsc" is a legal option,
it should be fixed such that it doesn't leave your machine without cache
affinity. That would anyway give you a falsified behavior of the O(1)
scheduler.

Erich


