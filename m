Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbQKQLkS>; Fri, 17 Nov 2000 06:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132060AbQKQLkI>; Fri, 17 Nov 2000 06:40:08 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:40163 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129624AbQKQLjw> convert rfc822-to-8bit; Fri, 17 Nov 2000 06:39:52 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, mingo@chiara.elte.hu,
        linux-kernel@vger.kernel.org
Message-ID: <C125699A.003D4D6A.00@d12mta07.de.ibm.com>
Date: Fri, 17 Nov 2000 11:41:58 +0100
Subject: Re: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>
>> If they absolutely needs 4 pages for pmd pagetables due hardware
constraints
>> I'd recommend to use _four_ hardware pages for each softpage, not two.
>
>Yes.
>
>However, it definitely is an issue of making trade-offs. Most 64-bit MMU
>models tend to have some flexibility in how you set up the page tables,
>and it may be possible to just move bits around too (ie making both the
>pmd and the pgd twice as large, and getting the expansion of 4 by doing
>two expand-by-two's, for example, if the hardware has support for doing
>things like that).

Unluckly we don't have any flexibility. The segment index (pmd) has 11
bits,
pointers are 8 byte. That makes 16K segment table. I have understood that
this is a problem if the system is really low on memory. But low on memory
does mean low on real memory + swap space, doesn't it ? The system has
enough swap space but it isn't using any of it when the BUG hits. I think
the "if (!order)" statements before the "goto try_again" in __alloc_pages
have something to do with it. To test this assumption I removed the ifs and

I didn't see any "__alloc_pages: %lu-order allocation failed." message
before I hit yet another BUG in swap_state.c:60.
Whats the reasoning behind these ifs ?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
