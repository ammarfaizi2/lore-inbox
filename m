Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270329AbUJUMAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbUJUMAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbUJTRWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:22:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47767 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268719AbUJTRPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:15:21 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041020170802.GB24619@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <41768858.8070709@techsource.com>
	 <20041020153521.GB21556@devserv.devel.redhat.com>
	 <1098290345.1429.65.camel@krustophenia.net>
	 <20041020165050.GA24619@dualathlon.random>
	 <1098291315.1429.79.camel@krustophenia.net>
	 <20041020170802.GB24619@dualathlon.random>
Content-Type: text/plain
Message-Id: <1098292516.1429.116.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 13:15:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:08, Andrea Arcangeli wrote:
> On Wed, Oct 20, 2004 at 12:55:17PM -0400, Lee Revell wrote:
> > This was not my point, I agree that the two have nothing to do with each
> > other.  But if a hardirq handler runs for 3ms then no user code can run
> > for 3ms.  Therefore this is a problem if our goal for desktop response
> > is 1ms.
> 
> I sure agree it's a problem, but not always userspace code needs to run
> for the user not to notice. With ring buffers in the kernel for playback
> all you need is a nested irq for the user not to notice skips.
> 

I was thinking of X, not audio.  This might be a problem for AV
playback.  Maybe that would depend on if DRI was in use.  Anyway I use a
low latency kernel because i need sub-ms response, I was just pointing
out that the current behavior might not be compatible with the 1ms
target.

However with the patch in -mm that enables setting max_sectors_kb, the
1ms goal can be achived by lowering this to 256 or so.  If I were
shipping a desktop distro I would lower this by default.  My tests show
the slowdown is barely measurable if at all.

Lee

