Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUJTRdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUJTRdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268779AbUJTRdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:33:50 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22208 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268836AbUJTRdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:33:39 -0400
Date: Wed, 20 Oct 2004 19:34:27 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20041020173427.GC24619@dualathlon.random>
References: <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <41768858.8070709@techsource.com> <20041020153521.GB21556@devserv.devel.redhat.com> <1098290345.1429.65.camel@krustophenia.net> <20041020165050.GA24619@dualathlon.random> <1098291315.1429.79.camel@krustophenia.net> <20041020170802.GB24619@dualathlon.random> <1098292516.1429.116.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098292516.1429.116.camel@krustophenia.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 01:15:16PM -0400, Lee Revell wrote:
> I was thinking of X, not audio.  This might be a problem for AV

sure I got it, maybe I wasn't clear but I wasn't in disagrement with
you, I've never said IDE is right taking 3msec, I just taken the example
you made, to add some more comment from a different point of view. Right
now IDE takes 3 msec, we can turn it down to 1msec (or better move it to
bh handler) but still nesting can be beneficial. It's up to the lowlevel
driver to re-enable irqs if it's doing something that takes a long time.
If we want to do something global that would be a nesting-max-limit
(which is a sort of requirement with 4k stack IMHO), not a no-nesting,
since no-nesting can be already enforced by every single irq handler,
and clearly many are re-enabling irqs like IDE since they take a long
time. Every time an irq handlers re-enable irqs means it's _asking_ for
nesting to happen.
