Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWEFKaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEFKaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 06:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWEFKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 06:30:05 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:47038 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750712AbWEFKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 06:30:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=V5XLac13etLonXhcgEO52Sr0/0chSufjfg09Ox+V3y0JGPqPV9B2e7IdXRZO4bharMw817FJqp9UDChv1afu92f8VIve3EkABGCsw5XUPQYXfCAcdoUiTGFbcwWIw+CGLiwjx9MZP9pXMFms+CiYKeP0CUNGjlG9UTTZPyCR3jY=  ;
Message-ID: <445C747A.7080205@yahoo.com.au>
Date: Sat, 06 May 2006 20:03:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 11/14] remap_file_pages protection support: pte_present
 should not trigger on PTE_FILE PROTNONE ptes
References: <20060430172953.409399000@zion.home.lan> <20060430173025.752423000@zion.home.lan> <4456D7B8.2000004@yahoo.com.au> <200605030329.51034.blaisorblade@yahoo.it>
In-Reply-To: <200605030329.51034.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Tuesday 02 May 2006 05:53, Nick Piggin wrote:
> 
>>blaisorblade@yahoo.it wrote:
>>
>>>From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>>>
>>>pte_present(pte) implies that pte_pfn(pte) is valid. Normally even with a
>>>_PAGE_PROTNONE pte this holds, but not when such a PTE is installed by
>>>the new install_file_pte; previously it didn't store protections, only
>>>file offsets, with the patches it also stores protections, and can set
>>>_PAGE_PROTNONE|_PAGE_FILE.
> 
> 
> What could be done is to set a PTE with "no protection", use another bit 
> rather than _PAGE_PROTNONE. This wastes one more bit but doable.

I see.

> 
> 
>>Why is this combination useful? Can't you just drop the _PAGE_FILE from
>>_PAGE_PROTNONE ptes?
> 
> 
> I must think on this, but the semantics are not entirely the same between the 
> two cases.

And yes, this won't work. I was misunderstanding what was happening.

I guess your problem is that you're overloading the pte protection bits
for present ptes as protection bits for not present (file) ptes. I'd rather
you just used a different encoding for file pte protections then.

"Wasting" a bit seems much more preferable for this very uncommon case (for
most people) rather than bloating pte_present check, which is called in
practically every performance critical inner loop).

That said, if the patch is i386/uml specific then I don't have much say in
it. If Ingo/Linus and Jeff/Yourself, respectively, accept the patch, then
fine.

But I think you should drop the comment from the core code. It seems wrong.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
