Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTE0B5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTE0B5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:57:10 -0400
Received: from holomorphy.com ([66.224.33.161]:61895 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262439AbTE0B5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:57:08 -0400
Date: Mon, 26 May 2003 19:10:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, andrea@suse.de, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527021002.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, davem@redhat.com, andrea@suse.de,
	davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
	mbligh@aracnet.com, linux-kernel@vger.kernel.org
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com> <20030526185920.64e9751f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526185920.64e9751f.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> In
>>  the userspace implementation the reprogramming is done infrequently
>>  enough to make even significant cost negligible; in-kernel the cost
>>  is entirely uncontrolled and the rate of reprogramming unlimited.

On Mon, May 26, 2003 at 06:59:20PM -0700, Andrew Morton wrote:
> eh?
> #define MAX_BALANCED_IRQ_INTERVAL       (5*HZ)
> #define MIN_BALANCED_IRQ_INTERVAL       (HZ/2)

The number of interrupt sources on a system ends up scaling this up to
numerous IO-APIC RTE reprograms and ioapic_lock acquisitions per-second
(granted, with a 5s timeout between reprogramming storms) where it
competes against IO-APIC interrupt acknowledgements.

Making the lock per- IO-APIC would at least put a bound on the number
of competitors mutually interfering with each other, but a tighter
bound on the amount of work than NR_IRQS would be more useful than that.


-- wli
