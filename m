Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUKVT5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUKVT5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbUKVT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:56:18 -0500
Received: from mail.suse.de ([195.135.220.2]:2691 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262564AbUKVTxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:53:52 -0500
Date: Mon, 22 Nov 2004 20:53:49 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] Re: scalability of signal delivery for Posix Threads
Message-ID: <20041122195348.GB11097@wotan.suse.de>
References: <41A20AF3.9030408@sgi.com> <20041122160705.GG25636@parcelfarce.linux.theplanet.co.uk> <41A242C1.10600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A242C1.10600@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, the sighand->siglock is taken so many places in the kernel (>200 
> times)
> that RCUing its usage looks like a daunting change to make.

Agreed.  And having to wait for all CPUs in sigaction would also not
be nice.

> 
> In principle, I guess a seqlock could be made to work.  The idea would be 

seqlocks are reader only, but for signal delivery you need a writer to 
update state like the thread load balancing. We got all that gunk
from POSIX, before NPTL it would have been probably possible ;-)

-Andi
