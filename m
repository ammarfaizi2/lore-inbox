Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWFIRHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWFIRHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWFIRHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:07:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19345 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750740AbWFIRHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:07:43 -0400
Message-ID: <4489AAD9.80806@garzik.org>
Date: Fri, 09 Jun 2006 13:07:37 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org>	<20060609030759.48cd17a0.akpm@osdl.org>	<44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org>
In-Reply-To: <20060609095620.22326f9d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 09 Jun 2006 11:40:03 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Users are now forced to remember that, if they write to their filesystem 
>> after using either $mmver or $korgver kernels, they are locked out of 
>> using older kernels.
> 
> The same happens if we create ext4 - earlier kernels don't support that,
> either.
> 
> I suppose we could call it ext4, although that wouldn't make much
> difference operationally.  The developers would probably choose to generate
> ext4 from the same codebase as ext3 for maintainability reasons, rather
> than choosing to copy-n-modify.  We'd need to see the patches to be able to
> finally make that judgement.

I would propose the obvious...  'cp -a ext3 ext4', apply the extent and 
48bit patches, and then do the obvious search-n-replace.

I guarantee that developer momentum would take over from there.  Rather 
than fundamentally change ext3, let's let it stabilize.


>> And as features continue to be added in this manner, this problem gets 
>> _exponentially_ worse.
> 
> "continue to be added"?  afaik this is the first time this has happened,
> and there's no plan to do it again.

ext3 developers are _fundamentally changing_ the block allocation 
structure [in a good way].  If they can get away with it once, they will 
continue to modify ext3, adding btrees and other new gadgets.  That's 
just human nature.  For example, htree was a minor disaster, 
deployment-wise, on the distro vendor side.

I think extents and 48bit are so fundamental that it's silly to attempt 
to minimize the impact from the user's perspective, and moreover, I 
think Linux benefits more if ext3 is _not_ kept on life support this way.

We need to draw a line in the sand.  If we don't, no one ever will.

	Jeff



