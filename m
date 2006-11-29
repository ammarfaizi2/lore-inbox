Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934488AbWK2GV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbWK2GV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934495AbWK2GV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:21:59 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:18351 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S934488AbWK2GV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:21:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=S1VNDUgG95216IJxDZU7qyCnrblfLIDgegJPABssEXf+Eq9U+IE0Slcoabc4LczJM0pNS1cQVzubd9sVtIZT8Vdh7NctrkGWZELeiC/QfkjLWmdH36zlx/PJGPJv7ngpKSoq9hPtOpWAW4fOEz2gxMlMRbzX83AzJsb6lP9pXS0=  ;
X-YMail-OSG: MdCaznIVM1lPmHkCfJMOW9q7nrRmIoVoMvfaOB8I6dp1MRbaSW.WrLOGMLs.r9LRPhkxyckPh2Ot8ANJVvkUqVD70ud0gfvxyS1QqWwXGXcr0rqoGKKYrC8KlGCkrVVXup6fOgJZg7NQSdE-
Message-ID: <456D26D2.7000806@yahoo.com.au>
Date: Wed, 29 Nov 2006 17:21:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slab: Remove kmem_cache_t
References: <Pine.LNX.4.64.0611281847030.12440@schroedinger.engr.sgi.com> <456D0757.6050903@yahoo.com.au> <Pine.LNX.4.64.0611281923460.12646@schroedinger.engr.sgi.com> <456D0FC4.4050704@yahoo.com.au> <20061128200619.67080e11.akpm@osdl.org> <Pine.LNX.4.64.0611282027431.3395@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611282027431.3395@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> So typedefs are good for
> 
>  - "u8"/"u16"/"u32"/"u64" kind of things, where the underlying types 
>    really are potentially different on different architectures.
> 
>  - "sector_t"-like things which may be 32-bit or 64-bit depending on some 
>    CONFIG_LBD option or other.
> 
>  - as a special case, "sparse" actually makes bitwise typedefs have real 
>    meaning as types, so if you are using sparse to distinguish between a 
>    little-endian 16-bit entity or a big-endian 16-bit entity, the typedef 
>    there is actually important and has real meaning to sparse (without the 
>    typedef, each bitwise type declaration would be strictly a _different_ 
>    type from another bitwise type declaration that otherwise looks the 
>    same).
> 
> But typedefs are NOT good for:
> 
>  - trying to avoid typing a few characters:
> 
> 	"kmem_cache_t" is strictly _worse_ than "struct kmem_cache", not 
> 	just because it causes declaration issues. It also hides the fact 
> 	that the thing really is a structure (and hiding the fact that 
> 	it's a pointer is a shooting offense: things like "voidptr_t" 
> 	should not be allowed at all)
> 
>  - incorrect "portability". 
> 
> 	the POSIX "socklen_t" was not only a really bad way to write
> 	"int", it actually caused a lot of NON-portability, and made some 
> 	people think it should be "size_t" or something equally broken.
> 
> The one excuse for typedefs in the "typing" sense can be complicated 
> function pointer types. Some function pointers are just too easy to screw 
> up, and using a
> 
> 	typedef (*myfn_t)(int, ...);
> 
> can be preferable over forcing people to write that really complex kind of 
> type out every time. But that shouldn't be overused either (but we use it 
> for things like "readdir_t", for example, for exactly this reason).


You are saying that they should only be used to create new "primitive"
types (ie. that you can use in arithmetic / logical ops) that can
change depending on the config.

That's fair enough. I'm sure you've also said in the past that they can
be used (IIRC you even encouraged it) when the type is opaque in the
context it is being used. I won't bother trying to dig out the post,
because I could be wrong and you are entitled to change your mind. I
just want to get this straight.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
