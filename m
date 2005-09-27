Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVI0Ao3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVI0Ao3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 20:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVI0Ao3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 20:44:29 -0400
Received: from smtpout.mac.com ([17.250.248.70]:21974 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932152AbVI0Ao3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 20:44:29 -0400
In-Reply-To: <1127780648.10315.12.camel@localhost>
References: <4338537E.8070603@austin.ibm.com> <43385412.5080506@austin.ibm.com> <21024267-29C3-4657-9C45-17D186EAD808@mac.com> <1127780648.10315.12.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9B96DA28-8900-4683-A64C-4C42F04F09E4@mac.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/9] add defrag flags
Date: Mon, 26 Sep 2005 20:43:57 -0400
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2005, at 20:24:08, Dave Hansen wrote:
> On Mon, 2005-09-26 at 20:16 -0400, Kyle Moffett wrote:
>> Uhh, call me crazy, but don't those flags look a little backwards  
>> to you?  Maybe it's just me, but wouldn't it make sense to expect  
>> __GFP_USER to be a userspace allocation and __GFP_KERNRCLM to be  
>> an easily reclaimable kernel page?
>
> I think Joel simply made an error in his description.
>
> __GFP_KERNRCLM corresponds to pages which are kernel-allocated, but  
> have some chance of being reclaimed at some point.  Basically,  
> they're things that will get freed back under memory pressure.   
> This can be direct, as with the dcache and its slab shrinker, or  
> more indirect as for control structures like buffer_heads that get  
> reclaimed after _other_ things are freed.

Ok, well he should fix both that description and the comment in his  
patches, and make sure that the code actually matches what it says:

> +#define __GFP_USER    0x40000u /* Kernel page that is easily  
> reclaimable */
> +#define __GFP_KERNRCLM    0x80000u /* User is a userspace user */

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


