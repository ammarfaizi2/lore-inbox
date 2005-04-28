Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVD1CPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVD1CPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVD1CPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:15:21 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:22951 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261638AbVD1CPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:15:13 -0400
Message-ID: <4270472E.9050708@yahoo.com.au>
Date: Thu, 28 Apr 2005 12:15:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: update to use the new 4L headers
References: <1114652039.7112.213.camel@gaston> <42704130.9050005@yahoo.com.au> <427044AA.5030402@nortel.com>
In-Reply-To: <427044AA.5030402@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Nick Piggin wrote:
> 
>> Just a bit off-topic: I wonder how many more of these open
>> coded pt walks exist in arch code (yes I see you've cleaned
>> yours up - good).
> 
> 
> I know there's open coded walks outside the tree (I maintain one) due to 
> there being no suitable function available from with in it...
> 

Oh - I meant hand calculating the addresses rather than using
the pmd_addr_end and friends... but:

> I needed something like:
> 
> pte_t *va_to_ptep_map(struct mm_struct *mm, unsigned int addr)
> 
> There was code in follow_page() that did basically what I needed, but it 
> was all contained within that function so I had to re-implement it.
> 

If you can break out exactly what you need, and make that inline
or otherwise available via the correct header, I'm sure it would
have a good chance of being merged.

Keep in mind that you shouldn't introduce an inefficiency to
follow_page, however if that is not possible you could simply
duplicate what you need in a seperate function in mm/memory.c and
use that - better to do it once there than a lot of times in
random places.

-- 
SUSE Labs, Novell Inc.

