Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUJTQvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUJTQvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJTQv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:51:28 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:42889 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268686AbUJTQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:50:12 -0400
Date: Wed, 20 Oct 2004 18:50:50 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20041020165050.GA24619@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <41768858.8070709@techsource.com> <20041020153521.GB21556@devserv.devel.redhat.com> <1098290345.1429.65.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098290345.1429.65.camel@krustophenia.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 12:39:06PM -0400, Lee Revell wrote:
> The IDE I/O completion in hardirq context means that one can run for
> almost 3ms.  Apparently at OLS it was decided that the target for
> desktop responsiveness was 1ms.  So this is a real problem.

comparing netsted irqs to a context switch is a red herring.

nested irqs statistically do good, with long irq handlers vs short irq
handlers. The irq handlers that really know to be extremely quick aren't
forced to re-enable irqs, so they can enforce no-nesting by themself.
Enforcing it globally sounds bad to me.
