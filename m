Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWFIRsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWFIRsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWFIRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:48:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48530 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030225AbWFIRsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:48:10 -0400
Message-ID: <4489B452.4050100@garzik.org>
Date: Fri, 09 Jun 2006 13:48:02 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<20060609091327.GA3679@infradead.org>	<20060609030759.48cd17a0.akpm@osdl.org>	<44899653.1020007@garzik.org>	<20060609095620.22326f9d.akpm@osdl.org>	<4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org>
In-Reply-To: <20060609103543.52c00c62.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 09 Jun 2006 13:07:37 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> I would propose the obvious...  'cp -a ext3 ext4', apply the extent and 
>> 48bit patches, and then do the obvious search-n-replace.
> 
> Most of ext3 is JBD.  At least, in terms of complexity.  And I don't think
> there's anything in this proposal which affects JBD, apart from changing
> the blocksize.
> 
> Cloning JBD for this exercise would, I suspect, be the wrong thing to do -
> the two clones would be pretty much identical, apart from some scalar
> types.
> 
> I did suggest a couple of years ago that we should clone the ext3 part and
> have both ext3 and ext4 use the same JBD layer - I don't know what happened
> to that idea.

The JBD API is reasonably distinct, so IMO this would be a logical next 
step.  I would hope they could use the same JBD, so, I strongly agree...


> There has been steady, cautious but significant improvement happening in
> ext3 over the past few years.  I'd expect that to continue, although
> perhaps at a lower rate.  Having to apply the same changes to two
> filesystems would be an obvious loss.

I disagree completely...  it would be an obvious win:  people who want 
stability get that, people who want new features get that too.


> It comes down to looking at the patches, and I haven't done that in quite
> some time.  Ideally the new functionality would all be under CONFIG_foo,
> but I do not know if that is being proposed here?
> 
>> We need to draw a line in the sand.  If we don't, no one ever will.
> 
> You speak as if this is something which has happened before, or that it will
> happen again.
> 
> All that being said, Linux's filesystems are looking increasingly crufty
> and we are getting to the time where we would benefit from a greenfield
> start-a-new-one.  That new one might even be based on reiser4 - has anyone
> looked?  It's been sitting around for a couple of years.

reiser4 actually has this same problem, but worse.  It has pluggable 
metadata even to the point of supporting plugin-style metadata development.

If we can successfully devolve a filesystem to metadata and algorithm 
plugins, that should be done at the VFS level, and not called "reiser4".

But in the absence of a different VFS API, I think it is the most 
practical of all the options to open the floodgates to ext4 rather than 
ext3.

	Jeff


