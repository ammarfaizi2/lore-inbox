Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129927AbQKVXri>; Wed, 22 Nov 2000 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130671AbQKVXr2>; Wed, 22 Nov 2000 18:47:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16138 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129927AbQKVXrW>;
        Wed, 22 Nov 2000 18:47:22 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011222316.XAA02538@raistlin.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: Andries.Brouwer@cwi.nl
Date: Wed, 22 Nov 2000 23:16:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200011221900.UAA141657.aeb@aak.cwi.nl> from "Andries.Brouwer@cwi.nl" at Nov 22, 2000 08:00:49 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:
>     From rmk@flint.arm.linux.org.uk Wed Nov 22 19:20:52 2000
>     They provide no information to the human reader, but they tell klogd
>     (and other tools) that the enclosed value is a kernel address that
>     should be looked up in the System.map file and decoded into name +
>     offset.
> 
> Of course. But since there is no information in [< >]
> (their presence is syntactically determined, not semantically)
> the tools you mention can be trivially patched to work without
> this [< >] kludge. On the other hand, when the system panics
> often klogd and similar nice programs do not run at all, and
> hence are unable to do any good. All information available
> is the information on the screen, and it is really a pity
> to lose EIP and get a few parentheses instead.

Well, in my experience, values of PC (or EIP is x86 speak) rarely
appear over column 50 on the screen.  Therefore, removing them is
only going to save width, not height.

Also, have you considered that not every oops is formatted exactly
the same way on every architecture?  In fact, an oops on ARM looks
like:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1e90000
*pgd = 01e94001, *pmd = 01e94001, *pte = 0000308b, *ppte = 0000300a
Internal error: Oops: 0
CPU: 0
pc : [<c280007c>]    lr : [<c00251f8>]
sp : c1e97f08  ip : c1e97ec0  fp : c1e97f14
r10: c1e96000  r9 : 00000004  r8 : ffffffea
r7 : 02029220  r6 : c1e37000  r5 : c2800000  r4 : 00000000
r3 : ef9f0000  r2 : 00000000  r1 : 00000000  r0 : 000001db
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 1E9117D  Table: 01E9117D  DAC: 00000015
Process insmod (pid: 9, stackpage=c1e97000)
Stack:
c1e97ee0:                                                        c00251f8 c280007c
c1e97f00: 60000013 ffffffff c1e97fac c1e97f18  c0026194 c280006c c1e37000 c1e38000
c1e97f20: c01f3680 00000060 c011d48c c2800060  00005e00 00000000 00000000 00000000
c1e97f40: 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00000000
c1e97f60: 00000000 00000000 00000000 00000000  00000000 00000000 00000000 00000000
c1e97f80: 00000000 bfffec64 02021928 60000010  c2800000 c00169e4 00000080 0201bbe8
c1e97fa0: 00000000 c1e97fb0 c0016860 c0025acc  bfffec64 c001bb54 0201bbe8 02029220
c1e97fc0: 00000000 00000038 bfffec64 02021928  02019f10 c2800000 00005e00 0201bbe8
c1e97fe0: 0201bbe8 bffffe60 400e4c90 bfffec28  020031e8 400e4c9c 60000010 0201bbe8
Backtrace:
Function entered at [<c2800060>] from [<c0026194>]
Function entered at [<c0025ac0>] from [<c0016860>]
Code: e51f2024 e5923000 (e5813000) e3a00000 e51f3030

where each number in [< >] should be looked up in System.map.  Do you
propose to teach klogd and ksymoops every single oops format style?

If no, then don't make this change to the kernel.  If yes, then you've
got a big job on your hands.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
