Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUIJPRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUIJPRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUIJPRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:17:24 -0400
Received: from jade.spiritone.com ([216.99.193.136]:65408 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267460AbUIJPRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:17:07 -0400
Date: Fri, 10 Sep 2004 08:16:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       arjanv@redhat.com, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <596720000.1094829398@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Hugh Dickins <hugh@veritas.com> wrote (on Friday, September 10, 2004 16:07:21 +0100):

> On Fri, 10 Sep 2004, Martin J. Bligh wrote:
>> 
>> I agree about killing anything but 4K stacks though - having the single
>> page is very compelling - not only can we allocate it easier, but we can
>> also use cache-hot pages from the hot list.
> 
> I think we all agree that's a promising future, and a good discipline.
> But I'm not the only one to doubt we're there yet.
> 
> Chris's patch seems eminently sensible to me.  Why should having separate
> interrupt stack depend on whether you're configured for 4K or 8K stacks?
> 
> Wasn't Andrea worried, a couple of months back, about nested interrupts
> overflowing the 4K interrupt stack?  He was trying to work out how to
> have an 8K interrupt stack even with the 4K task stack, proposed thread
> info at both top and bottom of stack; but his "current" still looked to
> me like it'd be significantly more costly than the present one.
> 
> I'm all for Chris's patch.

I have no problem with 8K interrupt stacks - they're static, and per CPU,
so I doubt anyone cares ... 

But 8K task stacks + interrupt stacks seems to just encourage bloat to me.
And if you agree that we're going to 4K, I don't really see the point - 
if people are really hitting problems (I don't recall any actual reports)
then I'd prefer to see them fixed properly by poking the fat bloater with
a big pin.

M.


