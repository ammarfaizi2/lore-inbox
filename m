Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWGNAdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWGNAdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 20:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWGNAdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 20:33:17 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:65475
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751430AbWGNAdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 20:33:17 -0400
Date: Fri, 14 Jul 2006 02:34:29 +0200
From: andrea@cpushare.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060714003429.GA18774@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz> <20060713231118.GA1913@opteron.random> <20060713232026.GA6117@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713232026.GA6117@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 01:20:26AM +0200, Pavel Machek wrote:
> I do not want to enter seccomp flamewar, and that's why I did not
> answer to Ingo.

Ok ;), I didn't imagine this was the reason. So we agree that the risk
introduced by the availability of the TSC is orders of magnitude
higher than whatever network timing attack.

> Strictly speaking, this is wrong. This is like adding noise into the
> room. You have to pick up maximum delay (ammount of noise), and you
> clearly can't override signal that's longer than maximum delay. But
>
> you also can't override signal that's half the maximum delay, given
> that transmitter will retransmit it 4-or-so times. Just average 4
> samples, and your random delays will cancel out.
> 
> No, this probably does not apply to seccomp, because we are picking
> unintended noise from affected computer.

Well, perhaps I wasn't clear enough, but I am only talking about
seccomp not some other unrelated and hypothetical network system.

I know a few algorithms are potentially vulnerable to network timing
attacks, the tcp sequence number and urandom comes to mind. urandom is
perhaps the worst of all (which btw, it also gets data from the
tsc). Those issues have absolutely nothing to do with seccomp.

As far as seccomp is concerned the only worry is the demonstration of
the timing side channel that was getting openssl keys by controlling
the host and running openssl commands on the other cpu at his
will. And to do that you need the TSC. Even that is totally vapourware
because the attacked environment was strictly controlled by the
attacker, it's unclear what would happen shall the attacked
environment being mostly random like in real life. Disabling the TSC
has been generally agreed good enough to stop it.

The second one in the priority list are the readonly ptes mapping HPET
on some x86-64 config. The network timing attack to CPUShare is way
over what I could actually worry about.

> OTOH I'm pretty sure I could communicate from seccomp process by
> sending zeros alone, and I cound communicate from another process on
> box running seccomp through your randomizing packetizer to my machine.

You mean you could communicate using some sort of morse-code and you
would use the frequency of the zero to send the messages? That's
certainly possible today (without any randomizer), but the timing will
be measurable through the internet, so you're talking morse-code in
cleartext over the internet. The whole internet will sniff your
message. Furthermore I register all ip and ports for all transactions,
so it's really no different from direct a tcp connection even if you
talk encrypted-more-code over it, you're only wasting some resources.

Also note, there's absolutely no way for you to know for sure who you
are talking with.

So I don't see anything to worry about, feel free to communicate with
the other side through seccomp if you want, I'm certainly not adding a
randomizer to prevent that.

Thanks.
