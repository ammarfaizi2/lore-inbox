Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWH0QCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWH0QCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWH0QCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:02:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:33222 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932155AbWH0QCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:02:06 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Date: Sun, 27 Aug 2006 18:01:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org>
In-Reply-To: <20060827084417.918992193@goop.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608271801.44774.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Very cool.

> - Make it work.  It works UP on a test QEMU machine, but it doesn't
>   yet work on real hardware, or SMP (though not working SMP on QEMU is
>   more likely to be a QEMU problem).  Not sure what the problem is yet;
>   I'm hoping review will reveal something.

I bet qemu doesn't have a real descriptor cache unlike real CPUs.
So likely it is some disconnect between changing the backing GDT
and referencing the register. Reload %gs more aggressively?

Comparing with SimNow! (which should behave more like a real CPU)
might be also interesting.

> - Measure performance impact.  The patch adds a segment register
>   save/restore on entry/exit to the kernel.  This expense should be
>   offset by savings in using the PDA while in the kernel, but I haven't
>   measured this yet.  Space savings are already appealing though.
> - Modify more things to use the PDA.  The more that uses it, the more
>   the cost of the %gs save/restore is amortized.  smp_processor_id and
>   current are the obvious first choices, which are implemented in this
>   series.

per cpu data would be the prime candidate. It is pretty simple.

> - Make it a config option?  UP systems don't need to do any of this,
>   other than having a single pre-allocated PDA.  Unfortunately, it gets
>   a bit messy to do this given the changes needed in handling %gs.

Please don't.

(weak point:)

- The stack protector code might work one day on i386 too.

-Andi
