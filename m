Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130785AbQKNIdV>; Tue, 14 Nov 2000 03:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQKNIdK>; Tue, 14 Nov 2000 03:33:10 -0500
Received: from smtp01.oce.nl ([134.188.1.25]:11460 "EHLO smtp01.oce.nl")
	by vger.kernel.org with ESMTP id <S130785AbQKNIct>;
	Tue, 14 Nov 2000 03:32:49 -0500
>Received: from pc1-adve.oce.nl (pc1-adve.oce.nl [134.188.176.32])
	by smtp02.oce.nl (8.9.3/8.9.3) with ESMTP id IAA07526;
	Tue, 14 Nov 2000 08:57:29 +0100 (MET)
Date: Tue, 14 Nov 2000 08:57:29 +0100
From: Arjan van de Ven <adve@oce.nl>
To: dirson@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inconsistencies in 3dNOW handling
Message-ID: <20001114085729.A28456@pc1-adve.oce.nl>
In-Reply-To: <m13vZhZ-000OYhC@amadeus.home.nl>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m13vZhZ-000OYhC@amadeus.home.nl>; from root@fenrus.demon.nl on Tue, Nov 14, 2000 at 07:36:17AM +0100
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> - CONFIG_MK6 is described as "K6/K6-II/K6-III", and CONFIG_MK7 as
> "Athlon/K7".  Of these two, only the latter defines
> CONFIG_X86_USE_3DNOW, although K6-II and K6-III do provide 3DNOW
> instructions.  

The Athlon has an extended version of 3DNOW, which the kernel uses as of
test11-pre2. The entire 3DNOW option has nothing to do with userspace;
unlike the Screaming Sindy Extensions, 3DNOW requires no (extra) kernel 
support.

The 3DNOW option is about the kernel using extended instructions for
internal functions such as zero_page() and copy_page().
This is no advantage on K6 processors, but on Athlon processors (well, most
of them anyway) it is a gain of more than a factor 2 for these functions.
The test11pre2 code will also not run on a K6-II/III, but this valid due to the 
fact that this new code is > 2x faster than the old code, and the old code
was no win on the K6-II/III anyway.


>  *	On older X86 processors its not a win to use MMX here it seems.
>  *	Maybe the K6-III ?
> 
> Gasp.  Would it or not in the end be useful to add a CONFIG_MK6II
> option that would enable 3DNOW ?

Won't work. (see previous comment).

 
 
> - In all places where 3DNOW is tested (strings-486.h, page.h), only
> MMX-specific funcs are used (_mmx_memcpy mostly, mmx_{clear,copy}_page)
> page.h says:

> So do they use MMX or 3Dnow after all ?  They are distinct processor
> features, aren't they ?

Some of the "MMX" instructions are part of "3Dnow" according  to AMD
publications. This is especially true for the "prefetch" instructions which
have a different memnonic/opcode on Intel CPU's.


> - BTW, what does this 512 stand for ?  Especially as it's used in
> several places, a #define would seem nice at first glance.

The 512 is a rough estimate of the minimum size of the copy that makes it
worth saving and restoring the extra processor-state for using mmx.


> - drivers/md/xor.c says:
> 
> 	certain CPU features like MMX can only be detected runtime
> 
> I'm not sure how much this relates to the above, but I'd say a MMX
> config option could be used for this ?  Or a common detection routine
> that other drivers could use ?

The way it is done now, even a generic i386 compiled kernel (think
distributions) will use the fast MMX raid code. For the copy_page and
friends this extra test is probably too much overhead. (the < 512 test is
inlined and often constant...)

Greetings,
   Arjan van de Ven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
