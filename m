Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWHPM4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWHPM4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWHPM4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:56:09 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:50777 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751163AbWHPM4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:56:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=1C9qbH3xInQucbYUE6ei6WFBoPsfh4/eFULY5qlA0q5+8jM0QCos5ttO1+uLDz7VkNLnDo9Cx3GCedWYz1qK5wSa4LHcewy6iZdw/NTx5qvmtyWm4icyX/PrQxnXwZE9ovQaDZgwvjKaRp/qd033KLNewufQ0i3FymkfzEJP5BE=  ;
Message-ID: <20060816125606.28947.qmail@web25806.mail.ukl.yahoo.com>
Date: Wed, 16 Aug 2006 12:56:06 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <44DC7D99.4040109@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> moreau francis wrote:
>>
>> It's indeed an issue. Could we instead use a combination of flags
>> that can't happen together. For example PG_Free|PG_Reserved ?
>>
> 
> You'd need to audit all other users of the bits you wanted to borrow to
> check they would understand.  Like if you used PG_buddy (which I assume
> is what you are referring to above) then you'd get non-real memory
> getting merged into your buddies.  Badness.
> 

It would be great if we could define:

#define page_is_real(p) (p->_count > 0 || p->flags != 0)

Hence mem_map[] would be automatically initialized as full of page without
any real memory instead of initializing it with a magic value.
>>
>> or maybe _because_ we don't have a consistent interface for finding
>> whether a page is real or not, we end up with a strange thing called
>> page_is_ram() which could be the same for all arch and be implemented
>> very simply.
>>
>> BTW, can you try in a linux tree:
>>
>> $ grep -r page_is_ram arch/
>>
>> and see how it's implemented...
> 
> Well it depends how you look at it.  You are going to need to know which
> pages are ram in each architecture to set the bits in the page*'s to

I don't see the problem there. You can init mem_map[] each time it is
allocated with the magic value (if the above definition can't be used).
Then, as usual, archs free all zone area by initializing all mem_map
entries with something different from the magic value. After that all
entries of mem_map[] with the magic value can be fastly discarded
because they don't have real memory.

Francis


