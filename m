Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUHVOrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUHVOrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUHVOrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:47:49 -0400
Received: from colin2.muc.de ([193.149.48.15]:50449 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267301AbUHVOre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:47:34 -0400
Date: 22 Aug 2004 16:47:31 +0200
Date: Sun, 22 Aug 2004 16:47:31 +0200
From: Andi Kleen <ak@muc.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "James M." <dart@windeath.2y.net>, linux-kernel@vger.kernel.org
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
Message-ID: <20040822144731.GA85541@muc.de>
References: <2vOfA-7Vg-7@gated-at.bofh.it> <m34qmwx8nv.fsf@averell.firstfloor.org> <200408221118.45146.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408221118.45146.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 11:18:45AM +0300, Denis Vlasenko wrote:
> On Sunday 22 August 2004 04:29, Andi Kleen wrote:
> > "James M." <dart@windeath.2y.net> writes:
> > > Title says it...my Athlon 64 definitely uses 3DNOW. Patch changes
> > > arch/i386/Kconfig and has a 3 line fudge factor(I created it a few
> > > kernels back). Might want to check other arches for the same bug.
> >
> > It it's not a bug, it is a feature. The K8 is better off not using
> > the 3dnow memcpy, which is the only feature this CONFIG controls.
> 
> However, 3dnow _copy_page_ is a huge win. I explained why in an emails

On K8? Significant resources were spent on tuning the x86-64
memcpy and memset, and since C stepping K8 rep ; movsl/q are fastest.
Before that an unrolled integer loop was best.

On 32bit the same applies.

Using SSE2 only helps for very large data sets that are
never used in the kernel (several MB). 3dnow wasn't tested, but it is 
unlikely to be any better than SSE2.

-Andi

