Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSGOSlL>; Mon, 15 Jul 2002 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSGOSlK>; Mon, 15 Jul 2002 14:41:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:57613 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317593AbSGOSkR>;
	Mon, 15 Jul 2002 14:40:17 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207151843.g6FIh0r217981@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 15 Jul 2002 14:43:00 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020715180646.B15136@flint.arm.linux.org.uk> from "Russell King" at Jul 15, 2002 06:06:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> On Mon, Jul 15, 2002 at 12:07:18PM -0400, Albert D. Cahalan wrote:

>> You have 64, 128, and 1000. See for yourself.
>>
>> arch-cl7500/param.h     #define HZ 100
>> arch-epxa10db/param.h   #define HZ 100
>> arch-integrator/param.h #define HZ 100
>> arch-l7200/param.h      #define HZ 128
>> arch-shark/param.h      #define HZ 64
>> arch-tbox/param.h       #define HZ 1000
>>
>> I need to support all of that with one binary.
>> So I'm stuck with:
>
> Lets look more closely:
>
> #ifndef HZ
> #define HZ 100
> #endif
> #if defined(__KERNEL__) && (HZ == 100)
> #define hz_to_std(a) (a)
> #endif
>
> And:
>
> $ grep hz_to_std arch-*/param.h
> arch-l7200/param.h:#define hz_to_std(a) ((a * HZ)/100)
> arch-shark/param.h:#define hz_to_std(a) ((a * HZ)/100)

Won't that overflow in 3 or 4 days?

> As I said, tbox is broken, so ignore that.

OK.

> And hz_to_std gets used (fs/proc/array.c):
>
>                 hz_to_std(task->times.tms_utime),
>                 hz_to_std(task->times.tms_stime),
>                 hz_to_std(task->times.tms_cutime),
>                 hz_to_std(task->times.tms_cstime),

Now look in the 2.4.xx kernel source.

> So merely grepping for HZ doesn't actually tell you anything.
> 
> All /proc values are in 100Hz units on ARM.

Since kernel 2.5.25 it looks like. I must support
the 2.4.xx kernels at least, and 2.2.xx is still
pretty popular.


