Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132306AbQKWAYl>; Wed, 22 Nov 2000 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132310AbQKWAYb>; Wed, 22 Nov 2000 19:24:31 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6410 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S132269AbQKWAYL>;
        Wed, 22 Nov 2000 19:24:11 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011222354.eAMNs1564115@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 22 Nov 2000 18:54:01 -0500 (EST)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011222316.XAA02538@raistlin.arm.linux.org.uk> from "Russell King" at Nov 22, 2000 11:16:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Andries.Brouwer@cwi.nl writes:

>> Of course. But since there is no information in [< >]
>> (their presence is syntactically determined, not semantically)
>> the tools you mention can be trivially patched to work without
>> this [< >] kludge. On the other hand, when the system panics
>> often klogd and similar nice programs do not run at all, and
>> hence are unable to do any good. All information available
>> is the information on the screen, and it is really a pity
>> to lose EIP and get a few parentheses instead.
>
> Well, in my experience, values of PC (or EIP is x86 speak) rarely
> appear over column 50 on the screen.  Therefore, removing them is
> only going to save width, not height.

Lots of useful data goes over column 80, causing even the innocent
little lines to scroll.

> Also, have you considered that not every oops is formatted exactly
> the same way on every architecture?  In fact, an oops on ARM looks
> like:

Hey, no problem.

> Unable to handle kernel NULL pointer dereference at virtual address 00000000

That 00000000 is an 8-digit hex number within 25 lines of things
that would suggest a problem, so it gets looked up. The text itself
counts as a hint too. ("kernel NULL pointer")

> pgd = c1e90000

Same thing. The "pgd" counts as a hint.

> *pgd = 01e94001, *pmd = 01e94001, *pte = 0000308b, *ppte = 0000300a

All 4 get looked up. Sure, they might not be symbols, but it is
better to err on the side of looking up extra junk.

> Internal error: Oops: 0

The "0" is only 1 digit, so don't look it up. The "Oops" is an
obvious hint to the userspace tool.

> CPU: 0
> pc : [<c280007c>]    lr : [<c00251f8>]
> sp : c1e97f08  ip : c1e97ec0  fp : c1e97f14
> r10: c1e96000  r9 : 00000004  r8 : ffffffea
> r7 : 02029220  r6 : c1e37000  r5 : c2800000  r4 : 00000000
> r3 : ef9f0000  r2 : 00000000  r1 : 00000000  r0 : 000001db

Gee, obvious register names and plenty of 8-digit hex numbers.

> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: 1E9117D  Table: 01E9117D  DAC: 00000015
> Process insmod (pid: 9, stackpage=c1e97000)

When you see "stackpage", you have a hint.

> Stack:

Oh look, another hint.

> c1e97ee0:                                                        c00251f8 c280007c
> c1e97f00: 60000013 ffffffff c1e97fac c1e97f18  c0026194 c280006c c1e37000 c1e38000

[ --- CHOP --- ]

All these numbers get looked up.

> Backtrace:

That is another hint.

> Function entered at [<c2800060>] from [<c0026194>]
> Function entered at [<c0025ac0>] from [<c0016860>]
> Code: e51f2024 e5923000 (e5813000) e3a00000 e51f3030

All those numbers get looked up. Keep going for another 25 lines too.

> where each number in [< >] should be looked up in System.map.  Do you
> propose to teach klogd and ksymoops every single oops format style?

That isn't needed. When in doubt, look up a hex address.
Of course any decent tool will retain the unmolested oops
and just add a list of symbol names afterward.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
