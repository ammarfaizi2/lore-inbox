Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWBXAiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWBXAiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBXAiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:38:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39297 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751238AbWBXAiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:38:14 -0500
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
From: Badari Pulavarty <pbadari@us.ibm.com>
To: suparna@in.ibm.com
Cc: akpm@osdl.org, sct@redhat.com, mason@suse.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
       kenneth.w.chen@intel.com, lkml <linux-kernel@vger.kernel.org>,
       sonny@burdell.org
In-Reply-To: <20060223072955.GA14244@in.ibm.com>
References: <20060223072955.GA14244@in.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 16:39:26 -0800
Message-Id: <1140741566.22756.170.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 12:59 +0530, Suparna Bhattacharya wrote:
> DIO code complexity and stability concerns were discussed way back during
> OLS and Kernel summit last year. Still, the lack of a solid alternative and
> motivation to subject oneself to the test of courage and delicate balance
> that fiddling with this code entails, has meant that gingerly applying fixes
> and bandaids as and when bugs are found, and moving on thereafter,
> continues to be the most palatable option.
> 
> A recent AIO-DIO bug reported by Kenneth Chen, came very close
> to being the proverbial last straw for me. Hence, here is a rough attempt to
> put together a (currently WIP) draft towards DIO code simplication, based
> on suggestions that some of you have brought up at various times. Several
> details, e.g. range locking implementation still need to be fleshed out
> completely, ideas/comments/suggestions would be welcome.
> 
> http://www.kernel.org/pub/linux/kernel/people/suparna/DIO-simplify.txt
> (also inlined below)
> 
> It would be quite pointless (and painful!), if the rewrite ends up becoming
> just as tricky and error prone as before. Such a patch will need a very
> close critical review by many sharp eyes, to avoid disrupting the current
> state of stability. So before going any further with this, I'm looking
> for feedback along the lines of:
> 
> - Is this a worthwhile thing to attempt ? Or is status quo good enough ?
> - Does the approach make sense ? Is there a simpler way ?
> - Is there any hidden complexity or performance overhead that you forsee ?
> - Adding an extra tag to the radix-tree for locking a range of pages would
>   impact the size of the radix tree; would that be a concern ?

I am still trying to understand the whole proposal to give you better
feedback. But, my gut feeling is - its not going to be any more simpler
than what we have today :(

Andrew did an excellent job when he started (with the set of
requirements we had at that time). Then we started adding more
and more features/corner-case fixes/functionality/locking fixes/error
handling cases etc - which added all the complexity. 

I think it deserves a cleanup, but afraid to touch it - since its
going to take few months to stabilize it and get it right. We need
to collect all the test cases before undertaking this.

Thanks,
Badari

