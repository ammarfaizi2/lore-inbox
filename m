Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbSITDx7>; Thu, 19 Sep 2002 23:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbSITDx7>; Thu, 19 Sep 2002 23:53:59 -0400
Received: from holomorphy.com ([66.224.33.161]:51845 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S274746AbSITDx6>;
	Thu, 19 Sep 2002 23:53:58 -0400
Date: Thu, 19 Sep 2002 20:52:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <20020920035258.GR28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20020920001001.GQ28202@holomorphy.com> <463074285.1032466006@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <463074285.1032466006@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 08:07:06PM -0700, Martin J. Bligh wrote:
> Does this help (on top of John's TSC patch in rollup 0)?

Nope. But I believe I found the root cause: it apparently takes
long enough to kick all the cpus the NMI oopser goes off during
one of the many long ints-off sections in the bootstrap phase. My
burning question now is why this only showed up in 2.5.36. Somehow
I mistook a rather blatant (c.f. SIGEMT) NMI oops for TSD %cr4 #GP.

I'm going to guess the NMI oopser was not eager enough to trip
beforehand and recent changes repaired that. Is this close?

If so, it's probably not worth mucking around with the bootstrap
sequence to deal with something this minor. It's not like it can
be mistaken for having hung, as console output is very consistent.
Maybe we should give NUMA-Q a couple of minutes instead of 5s?


Thanks,
Bill
