Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSH0VOS>; Tue, 27 Aug 2002 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSH0VOS>; Tue, 27 Aug 2002 17:14:18 -0400
Received: from quark.didntduck.org ([216.43.55.190]:45073 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S317112AbSH0VOR>; Tue, 27 Aug 2002 17:14:17 -0400
Message-ID: <3D6BEC8A.5030905@didntduck.org>
Date: Tue, 27 Aug 2002 17:18:02 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
References: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 27 Aug 2002, Hugh Dickins wrote:
> 
>>I just sent the 2.4.20-pre4 asm-i386/pgtable.h patch to Marcelo:
>>here's patch against 2.5.31 or current BK: please apply.
> 
> 
> This test is senseless, in my opinion:
> 
> 
>>+		if (cpu_has_pge)					\
>>+			__flush_tlb_single(addr);			\
> 
> 
> The test _should_ be for something like
> 
> 	if (cpu_has_invlpg)
> 		__flush_tlb_single(addr);
> 
> since we want to use the invlpg instruction regardless of any PGE issues 
> if it is available.
> 
> There's another issue, which is the fact that I do not believe that invlpg 
> is even guaranteed to invalidate a G page at all - although obviously all 
> current CPU's seem to work that way. However, I don't see that documented 
> anywhere. 

P4 System Programming Guide, Section 10.9:
The INVLPG instruction invalidates the TLB for a specific page. This 
instruction is the most efficient in cases where software only needs to 
invalidate a specific page, because it improves performance over 
invalidating the whole TLB. This instruction is not affected by the 
state of the G flag in a page-directory or page-table entry.

