Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTDVLGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDVLGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:06:34 -0400
Received: from zero.aec.at ([193.170.194.10]:34057 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263076AbTDVLGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:06:33 -0400
Date: Tue, 22 Apr 2003 13:18:32 +0200
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030422111832.GC2170@averell>
References: <200304220111.h3M1BEp5004047@hera.kernel.org> <1051001038.1419.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051001038.1419.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Apr 22, 2003 at 10:43:58AM +0200, Arjan van de Ven wrote:
> On Tue, 2003-04-22 at 01:23, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1169, 2003/04/21 16:23:20-07:00, ak@muc.de
> > 
> > 	[PATCH] Runtime memory barrier patching
> > 	
> > 	This implements automatic code patching of memory barriers based
> > 	on the CPU capabilities. Normally lock ; addl $0,(%esp) barriers
> > 	are used, but these are a bit slow on the Pentium 4.
> > 	
> 
> very nice. Question: would it be doable use this for prefetch() as well?
> Eg default to a non-prefetch kernel and patch in the proper prefetch
> instruction for the current cpu ? (eg AMD prefetch vs Intel one etc etc)

Yes, I already implemented it, but have yet to boot it.

You only need Intel and AMD prefetch. For all Athlons the SSE prefetches
work (because we force the SSE MSR bit to on). prefetchw is 3dnow.
3dnow non 'w' prefetches would only make sense on the K6, but they're
not really worth it there because it doesn't have enough oustanding loads
in the memory unit and worse prefetch is microcoded there.

-Andi

