Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUIPWwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUIPWwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUIPWwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:52:04 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:57097 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268306AbUIPWvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:51:08 -0400
Date: Thu, 16 Sep 2004 15:51:02 -0700
To: "David S. Miller" <davem@davemloft.net>
Cc: Bill Huey <bhuey@lnxw.com>, davidsen@tmr.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040916225102.GA4386@nietzsche.lynx.com>
References: <m3vfefa61l.fsf@averell.firstfloor.org> <cic7f9$i4m$1@gatekeeper.tmr.com> <20040916222903.GA4089@nietzsche.lynx.com> <20040916154011.3f0dbd54.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916154011.3f0dbd54.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 03:40:11PM -0700, David S. Miller wrote:
> On Thu, 16 Sep 2004 15:29:03 -0700
> Bill Huey (hui) <bhuey@lnxw.com> wrote:
> 
> > FreeBSD-current uses adaptive mutexes. However they spin on that mutex
> > only if the thread owning it is running across another CPU at that time,
> > otherwise it sleeps, maybe priority inherited depending on the
> > circumstance.
> 
> This is how Solaris MUTEX objects work too.

Yeah, I know from Solaris Internals and FreeBSD can be considered a
Solaris style kernel. In contract, I think the Linux community has a
few things up on FreeBSD/Solaris style SMP. Specifically, the FreeBSD
community has ignored a lot of the really hard work of pushing down
locks in favor of "getting fancier locks", which only abuses thread
priorities and the scheduler. A large part of it is because they have
really create a very complicated SMP infrastructure that less than a
handful of their kernel engineers really know how to use, 2-3, it
seems.

Judging from how the Linux code is done and the numbers I get from
Bill Irwin in casual conversation, the Linux SMP approach is clearly
the right track at this time with it's hand honed per-CPU awareness of
things. The only serious problem that spinlocks have as they aren't
preemptable, which is what Ingo is trying to fix.

bill

