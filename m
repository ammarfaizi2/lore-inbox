Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRCWKVk>; Fri, 23 Mar 2001 05:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCWKVa>; Fri, 23 Mar 2001 05:21:30 -0500
Received: from [166.70.28.69] ([166.70.28.69]:42808 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S129112AbRCWKVR>;
	Fri, 23 Mar 2001 05:21:17 -0500
To: Kurt Garloff <garloff@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP on assym. x86
In-Reply-To: <Pine.LNX.4.10.10103211122500.10337-100000@coffee.psychology.mcmaster.ca> <E14fsET-0001Mg-00@the-village.bc.nu> <20010322130029.A4212@garloff.casa-etp.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2001 03:19:28 -0700
In-Reply-To: Kurt Garloff's message of "Thu, 22 Mar 2001 13:00:29 +0100"
Message-ID: <m1snk423f3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> writes:

> On Wed, Mar 21, 2001 at 11:41:33PM +0000, Alan Cox wrote:
> > > > handle the situation with 2 different CPUs (AMP = Assymmetric
> > > > multiprocessing ;-) correctly.
> > > 
> > > "correctly".  Intel doesn't support this (mis)configuration:
> > > especially with different steppings, not to mention models.
> 
> I wouldn't call it misconfiguration, just because it's a bit more difficult
> to handle.
> On the iontel side: You should watch out for matching APICs, voltages and
> cache coherency (MESI) protocol. Actually, Deschutes and Coppermine just
> work fine in spite of slightly different voltage.

The spooky thing is if there is that it may work just fine most of the
time but the differences between the CPU's might cause very strange
behavior every once in a great while.  Which is a hardware argument, for
why you shouldn't trust such a configuration.

However it is still worth some thought.  The hardware argument gets much
weaker when you have something like dual AMD's.  The reason is that
with a point to point bus you may actually be able to sanely support
multiple cpu revs and speeds without even any theoretical hardware consequences.

And NUMA machines make this argument even stronger.

However I would suggest that we build some good kernel->kernel apis
for dealing with kernels with a wicked fast interconnect.  And then
for NUMA and for the other cases where it really matters we can run multiple
kernels, and the mismatch problems just drop away.


Eric
