Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUILTSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUILTSP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268812AbUILTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:18:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16868 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268803AbUILTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:18:01 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20040910153421.GD24434@devserv.devel.redhat.com>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1095016687.1306.667.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 15:18:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 11:34, Arjan van de Ven wrote:
> On Fri, Sep 10, 2004 at 05:28:52PM +0200, Andrea Arcangeli wrote:
> > On Fri, Sep 10, 2004 at 05:15:38PM +0200, Arjan van de Ven wrote: 
> > > What we should consider regardless is disable the nesting of irqs for
> > > performance reasons but that's an independent matter
> > 
> > disabling nesting completely sounds a bit too aggressive, but limiting
> > the nesting is probably a good idea.
> 
> disabling is actually not a bad idea; hard irq handlers run for a very short
> time

The glaring exception is the IDE io completion, which can run for 2000+
usec even with a modern chipset and drive.  Here's a 600 usec trace:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7#/var/www/2.6.8-rc4-bk3-O7/ide_irq_latency_trace.txt

The timer, RTC, and soundcard interrupts (among others) will not like
being delayed this long.  Ingo mentioned that this was not always done
in hardirq context; presumaby the I/O completion was done in a softirq
like SCSI.  What was the motivation for moving such a long code path
into the hard irq handler?

Lee

