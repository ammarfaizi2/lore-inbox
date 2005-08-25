Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVHYJOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVHYJOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVHYJOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:14:19 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:58965 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964892AbVHYJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:14:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=S+U62NOvd01mL4tlMACf4KhYROuVJvffZvXmdRgMg6nZLUrO7KmYH3NWVgkx1JixZPk1tVRQ7UdFddpUg8VcmKa++ytzgnfi27fldmNbbMxdx0qY5VkJbT6CUbIxTJ1IdWIrzvtHEYL0E78G9hJvrt+FVCwNVymtEp5WFgwqsxM=  ;
Message-ID: <20050825091403.6380.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 25 Aug 2005 11:14:03 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: question on memory barrier
To: Andy Isaacson <adi@hexapodia.org>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20050824194836.GA26526@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andy Isaacson <adi@hexapodia.org> a écrit :

> 
> The first register write will be completed before the second register
> write because you use writel, which is defined to have the semantics you
> want.  (It uses a platform-specific method to guarantee this, possibly
> "volatile" or "asm("eieio")" or whatever method your platform requires.)

I'm compiling Linux kernel for a MIPS32 cpu. On my platform, writel seems
expand to:

    static inline writel(u32 val, volatile void __iomem *mem)
    {
            volatile u32 *__mem;
            u32 __val;

            __mem = (void *)((unsigned long)(mem));
            __val = val;

            *__mem = __val;
    }

I don't see the magic in it since "volatile" keyword do not handle memory
ordering constraints...Linus wrote on volatile keyword, see
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1387.html

> 
> The sequence points, by themselves, do not make any requirements on the
> externally visible behavior of the program.  Nor does the fact that
> there's an inline function involved.  It's just the writel() that
> contains the magic to force in-order execution.
> 
> You might benefit by running your source code through gcc -E and seeing
> what the writel() expands to.  (I do something like "rm drivers/mydev.o;
> make V=1" and then copy-n-paste the gcc line, replacing the "-c -o mydev.o"
> options with -E.)

make drivers/mydev.i should do the job but preprocessor doesn't expand inline
functions. So I won't be able to see the expanded writel function.

> 
> The sequence point argument is obviously wrong, BTW - if it were the
> case that a mere sequence point required the compiler to have completed
> all externally-visible side effects, then almost every optimization that
> gcc does with -O2 would be impossible.  CSE, loop splitting, etc.
> 
> -andy
> 



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
