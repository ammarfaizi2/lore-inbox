Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWEYJ6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWEYJ6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 05:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWEYJ6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 05:58:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58014 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965074AbWEYJ6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 05:58:53 -0400
Message-ID: <44757FD3.3070805@garzik.org>
Date: Thu, 25 May 2006 05:58:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Jon Mason <jdmason@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction
 into the callers
References: <20060525033550.GD7720@us.ibm.com> <447533FB.1080400@garzik.org> <20060525094236.GB22495@granada.merseine.nu>
In-Reply-To: <20060525094236.GB22495@granada.merseine.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Thu, May 25, 2006 at 12:35:07AM -0400, Jeff Garzik wrote:
>> Jon Mason wrote:
>>> >From Andi Kleen's comments on the original Calgary patch, move
>>> valid_dma_direction into the calling functions.
>>>
>>> Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
>>> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
>> Even though BUG_ON() includes unlikely(), this introduces additional 
>> tests in very hot paths.
> 
> Are they really very hot? I mean if you're calling the DMA API, you're
> about to frob the hardware or have already frobbed it - does this
> check really matter?

When you are adding a check that will _never_ be hit in production, to 
the _hottest_ paths in the kernel, you can be assured it matters...


>> _Why_ do we need this at all?
> 
> It was helpful for us during the dma-ops work and Calgary bringup and
> Andi requested that we move it from Calgary to common code. I think
> we're fine with dropping it if that's the consensus, but it did catch
> a few bugs early on and the cost is tiny.

Key phrase:  "early on"

These checks will only be useful during _early_ development of a new DMA 
platform.  For _100%_ of the real world users, these checks are useless. 
  Not 99%, 100%.

	Jeff



