Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDOSpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUDOSmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:42:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2723 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263134AbUDOSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:40:03 -0400
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
References: <1KifY-uA-7@gated-at.bofh.it>
	<m3n05gu4o2.fsf@averell.firstfloor.org>
	<m1fzb56fu2.fsf@ebiederm.dsl.xmission.com>
	<20040415163818.GA54491@colin2.muc.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Apr 2004 12:39:00 -0600
In-Reply-To: <20040415163818.GA54491@colin2.muc.de>
Message-ID: <m1ad1d5bnf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> > This would also be extremely useful on machines with large amounts
> > of memory, for write-back mappings.  With large amounts but odd sized
> > entries it becomes extremely tricky to map all of the memory using
> > mtrrs.
> 
> Yes agreed. I already had vendors complaining about this.
> But for this it will need some more work - the MTRRs need to be fully
> converted to PAT and then disabled (because MTRRs have 
> higher priority than PAT). Doing so is a lot more risky than 
> what Terrence's patch does currently though.  But longer term
> we will need it.

Ugh.  You are right.  The processors look at the two types and pick
the one that caches the least.  So PAT can't enable caching :(

> Also it will still need to handle overlapping ranges. I suppose
> it will need some simple rules like: converting from UC to WC is 
> always ok.

Right.

That plus it should have some additional rules like the
e820 map trumps the mtrrs in specifying what is memory so
should be cacheable.

Eric


