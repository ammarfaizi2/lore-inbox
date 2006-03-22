Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWCVOdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWCVOdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWCVOdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:33:09 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:15744 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751156AbWCVOdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:33:08 -0500
In-Reply-To: <44213333.6030404@yahoo.com.au>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org> <44213333.6030404@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
Date: Wed, 22 Mar 2006 14:33:25 +0000
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 11:21, Nick Piggin wrote:

> Couple of issues with the current code though:
>
> firstly, the name.

Okay, can you suggest a better one? That's the best I could come up 
with that wasn't long winded. :-)

> secondly, I think you confuse our (confusing) terminology: the page
> that holds pte_ts is not the pte_page, the pte_page is the page that
> a pte points to

What should we call it? Essentially we want to be able to get the 
physical address of a PTE in some cases, and passing struct page 
pointer seemed the best way to be able to derive that. I can rename it 
to something else vaguely plausible if the only problem is the semantic 
clash with Linux's idiomatic use of pte_page.

> lastly, you don't allow any control over the type of pages that are
> walked: this could well be unusably slow for some cases. At least
> you should proably design the interface so we can iterate over
> present, not present, all, etc so it becomes widely usable. Normally
> I'd say to wait until users come up but in this case the function
> isn't a speed demon anyway, and you also don't want to give people
> any excuses not to use it.

You mean iterate only over PTEs that are already present, or only those 
that were *not* previously present, or all (present and non-present)? 
Is that really useful? If so then yes, it's not hard to add.

  Thanks,
  Keir

