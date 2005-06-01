Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFAMyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFAMyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFAMyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:54:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:55255 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261376AbVFAMyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:54:11 -0400
Date: Wed, 1 Jun 2005 18:20:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc: patch 0/6] scalable fd management
Message-ID: <20050601125056.GA4853@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050530105042.GA5534@in.ibm.com> <20050601112520.GD20782@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601112520.GD20782@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:25:20AM -0700, William Lee Irwin III wrote:
> On Mon, May 30, 2005 at 04:20:42PM +0530, Dipankar Sarma wrote:
> > I would appreciate if someone tests this on an arch without
> > cmpxchg (sparc32??). I intend to run some more tests
> > with preemption enabled and also on ppc64 myself.
> 
> sparc32 SMP is not going to be a good choice for this. By and large
> ll/sc -style architectures don't have explicit cmpxchg instructions so
> ppc64 at least nominally fits the bill. SMP Alpha testing may also be
> enlightening (as usual).

Actually, I was talking about cmpxchg() primitive in the kernel,
not necessarily the instruction. ppc64 has a cmpxchg() primitive
based on LL/SC. For the archs that do not have cmpxchg(),
rcuref_inc_lf() uses a hashed lock to serialize the reference
count updates. It would be nice to see that code get a spin
on real hardware. AFAICS, sparc32 fits the bill.

Thanks
Dipankar
