Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSHGOQ7>; Wed, 7 Aug 2002 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHGOQ7>; Wed, 7 Aug 2002 10:16:59 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:61196 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S317427AbSHGOQ6>; Wed, 7 Aug 2002 10:16:58 -0400
Date: Wed, 7 Aug 2002 16:20:37 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Anything special with 64 Bit Operations in Kernel?
Message-ID: <20020807162037.F2949@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry if this is off-topic because "a bit" x86-centric, but i have some
problems since using 64-bit operations in kernel-space (especially: in
interrupt context), and am wondering if there might be any special issues.

What i do quite often is a 64-bit/32-bit division, and also some other
calculations, and now i found out that my code hangs the machine because
of a "divide error" (that's what the oops prints to the console prior
to the halt, sysrq keeps working). All "division by zero" errors are from
my knowledge avoided correctly.

It *seems* that more/other problems happen when the code is running on
an athlon, but unfortunately there are also different distribution
releases (and thus gcc versions) involved, so i am still unsure there.
(And don't have all machines under my control to make it uniform)

I did not find any references on problems specific to 64-bit operations,
so in case anyone also experienced strange behaviour - be it processor,
compiler or kernel - or knows a place where i could look, please let
me know!
My main problem is that these events occur only occasionally, so it is
a bit difficult to give an accurate example.

Thanks,
Wolfgang

P.S.:
Another point: we had to change
static s64 st_pll_mult(s32 var1, s32 var2, s8 frac1, s8 frac2, s8 frac_res)
to
static void st_pll_mult(s64 * retval, s32 var1, s32 var2, s8 frac1, s8 frac2, s8 frac_res)
because else the resulting s64 is sometimes overwritten by something else,
depending on the code around the function call.
(don't know all compiler versions, but i was using gcc-2.95.3 from SuSE 7.3
and can reproduce this)
Should i release the kernel from the suspicion and try another compiler? :)

