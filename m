Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUKNIxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUKNIxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKNIxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:53:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:20454 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261262AbUKNIvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:51:52 -0500
Date: Sun, 14 Nov 2004 09:51:47 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] lockless MCE i386 port
Message-ID: <20041114085147.GD16795@wotan.suse.de>
References: <Pine.LNX.4.61.0411090126190.3047@musoma.fsmlabs.com> <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 11:36:42AM -0700, Zwane Mwaikambo wrote:
> On Fri, 12 Nov 2004, Zwane Mwaikambo wrote:
> 
> > Andi fixed the locking issues with respect to printk and MCEs on x86_64, 
> > this is a port of said code with a few small changes due to i386 currently 
> > supporting the extended MCE MSRs on intel processors (also present on 
> > intel x86_64). The addition of hooks allows for the Pentium and P4 MCE 
> > drivers to print additional/extended information. I've also converted the 
> > P4 thermal monitor driver to avoid printing from interrupt context.
> > 
> > Tested on P4 and K7
> > 
> > Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>
> > 
> >  arch/i386/kernel/cpu/mcheck/k7.c  |   68 ++++++++++-----
> >  arch/i386/kernel/cpu/mcheck/mce.c |  109 ++++++++++++++++++++++++-
> >  arch/i386/kernel/cpu/mcheck/mce.h |   53 ++++++++++++
> >  arch/i386/kernel/cpu/mcheck/p4.c  |  165 ++++++++++++++++++++++++++------------
> >  arch/i386/kernel/cpu/mcheck/p5.c  |   27 ++++--
> >  arch/i386/kernel/cpu/mcheck/p6.c  |   66 +++++++++------
> >  6 files changed, 382 insertions(+), 106 deletions(-)
> 
> I flipped the printk output for the m.addrl/m.addrh, here is the patch 
> rediffed.

Looks good from a first look.

One issue is that you will need people to run the mcelog cron job
and create /dev/mcelog, otherwise they won't see any non fatal
warnings anymore.

I'm actually considering to add a tasklet/bit on x86-64 to printk
a one line warning when any events are in the log. Perhaps that
would be a good idea here too to make the migration smoother.

-Andi
