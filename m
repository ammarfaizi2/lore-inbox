Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753132AbWKFNym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbWKFNym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbWKFNym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:54:42 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51671 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1753132AbWKFNyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:54:41 -0500
Date: Mon, 6 Nov 2006 16:54:35 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061106135435.GA10010@2ka.mipt.ru>
References: <20061103163012.GA84707@cave.trolltruffles.com> <20061105204741.GA1847@elf.ucw.cz> <20061106101329.GA16817@2ka.mipt.ru> <20061106101633.GE2978@elf.ucw.cz> <20061106103724.GA4535@2ka.mipt.ru> <20061106125818.GA20351@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061106125818.GA20351@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 06 Nov 2006 16:54:36 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 01:58:18PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> Hi!
> 
> > > Can you explain why kevent is better than kqueue?
> > 
> > According to my tests kevent is noticebly faster.
> > It is already too big flag that old system should not be used.
> > And half of my previous mail to you shows why kevent is better/different
> > from kqueue.
> 
> You shown why it is _different_. How much faster is "noticebly
> faster"?

It is different on purpose, don't you think?
If I will put all benchmark results in all mails, no one will read even
half of it.

Here is conlusion section on kevent homepage where FreeBSD kqueue is
compared with kevent (different NIC than recent Linux kevent tests, 
but there are links to old kevent benchamrks there):

"After various sysctls have been changed (sysctl -a output is available
here) things become slightly better (btw, default FreeBSD installation
does not allow such tests at all due to default network parameters), but
number of "connection reset" errors is still very high.
FreeBSD drops too many connections due to either misconfiguration or
lack of resources.

According to FreeBSD and Linux comparison, in Linux number of connection
errors is much smaller than in FreeBSD with comparable or bigger
requests rate."

Briefly saying, FreeBSD kqueue behaves like Linux epoll, sometimes
better (with small request rate), sometimes worse (with 3k simultaneous
connections rate), and the latter was shown to behave worse than kevent.


Actually, Pavel, I do not understand your point. Why do you want to use
*BSD subsystem even if it is impossible to have the same API? You want
me to rewrite kevent so it would look like kqueue, but you did not know
how it looks like, likely you did not know it's API (it uses switches of
commands which are too much frowned upon in Linux kernel), you did not
know what features kevent provides and what is present and what does not
exist in kqueue.
So please point me to the magic Bodhi way which can enlighten me to think 
that completely different system, which works with completely different
OS with completely different API, ABI and kernel internals, should be 
ported to Linux instead of creation new and superior system?
When I become as luminous as you I will go and create new sendfile()
system call which will have the same parameters as BSD. Or not, I will ask
you to do it (actually not, why should we create something new, when
there is BSD system which already has everything we want?).

> 								Pavel

-- 
	Evgeniy Polyakov
