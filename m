Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVCASvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVCASvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 13:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCASvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 13:51:17 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:56467 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261585AbVCASvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 13:51:09 -0500
Message-Id: <200502282007.j1SK7L505841@www.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: "'Andrew Walrond'" <andrew@walrond.org>, <linux-kernel@vger.kernel.org>
Cc: "'Mike Hardy'" <mhardy@h3c.com>, "'Jesper Juhl'" <juhl-lkml@dif.dk>,
       <linux-raid@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>
Subject: RE: No swap can be dangerous (was Re: swap on RAID (was Re: swp - Re: ext3 journal on software raid))
Date: Mon, 28 Feb 2005 15:07:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <200501070928.13307.andrew@walrond.org>
Thread-Index: AcUdxC5ytE0t1RVCQl6KhT3yELAwcAACS4/g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just kidding about the RAM disk!

I think swapping to a RAM disk can't work.
Let's assume a page is swapped out.  Now the first page of swap space is
used, and memory is now allocated for it.  Now assume the process frees the
memory, the page in swap can now be freed, but the RAM disk still has the
memory allocated, just not used.  Now if the Kernel were to swap the first
page of that RAM disk, it may be swapped to the first page of swap, which
would change the data in the RAM disk which is being swapped out.  So, I
guess it can't be swapped, or must be re-swapped, or new memory is
allocated.  In any event, that 1 block will never be un-swapped, since it
will never be needed.  Each time the Kernel attempts to swap some of the RAM
disk the RAM disk's memory usage will increase.  This will continue until
all of the RAM disk is used and there is no available swap space left.  Swap
will be full of swap.  :)

I hope that is clear!  It makes my head hurt!

I don't know about lomem or DMAable memory.  But if special memory does
exists....
It seems like if the Kernel can move memory to disk, it would be easier to
move memory to memory.  So, if special memory is needed, the Kernel should
be able to relocate as needed.  Maybe no code exists to do that, but I think
it would be easier to do than to swap to disk (assuming you have enough free
memory).

Guy

-----Original Message-----
From: Andrew Walrond [mailto:andrew@walrond.org] 
Sent: Friday, January 07, 2005 4:28 AM
To: linux-kernel@vger.kernel.org
Cc: Guy; 'Mike Hardy'; 'Jesper Juhl'; linux-raid@vger.kernel.org;
alan@lxorguk.ukuu.org.uk
Subject: Re: No swap can be dangerous (was Re: swap on RAID (was Re: swp -
Re: ext3 journal on software raid))

On Thursday 06 January 2005 23:15, Guy wrote:
> If I MUST/SHOULD have swap space....
> Maybe I will create a RAM disk and use it for swap!  :)  :)  :)

Well, indeed, I had the same thought. As long as you could guarantee that
the 
ram was of the highmem/non-dmaable type...

But we're getting ahead of ourselves. I think we need an authoritive answer
to 
the original premise. Perhaps Alan (cc-ed) might spare us a moment?

Did I dream this up, or is it correct?

"I think the gist was this: the kernel can sometimes needs to move bits of 
memory in order to free up dma-able ram, or lowmem. If I recall correctly, 
the kernel can only do this move via swap, even if there is stacks of free 
(non-dmaable or highmem) memory."

Andrew

