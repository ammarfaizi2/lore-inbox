Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSBXRLv>; Sun, 24 Feb 2002 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290103AbSBXRLl>; Sun, 24 Feb 2002 12:11:41 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:55218 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S290125AbSBXRLV>; Sun, 24 Feb 2002 12:11:21 -0500
Date: Sun, 24 Feb 2002 08:42:52 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: adam@os.inf.tu-dresden.de, fernando@quatro.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <58726664.1014540170@[10.10.2.3]>
In-Reply-To: <20020223231850.4ea9d3ca.skraw@ithnet.com>
In-Reply-To: <20020223231850.4ea9d3ca.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > <4>CPU1<T0:1339376,T1:446448,D:8,S:446460,C:1339380>
>> > <4>checking TSC synchronization across CPUs: passed.
>> > <4>Waiting on wait_init_idle (map = 0x2)
>> > <4>All processors have done init_idle
>> >
>> > I would say this means the TSC skew fix is broken and shooting down
>> > your box. What do you think, Alan?
>>
>> Seems a reasonable guess. However that TSC skew itself may point to other
>> problems. It means one processor started running successfully a little
>> after the other. That might be normal behaviour for that board or might
>> point to  something else
>
> It seems no normal behaviour, I checked several other boards of this type
> and none had a TSC skew (and all work). Purely guessing I would suggest
> two try some other 2 processors to verify the behaviour is really
> processor-independent. Another guess would of course be the MB itself
> being broken to some extent.
>
> Has anybody ever seen a _working_ skew correction? Is this known-to-work
> code?

Yes. Works every time for me (on NUMA-Q), with huge corrections:

checking TSC synchronization across CPUs:
BIOS BUG: CPU#0 improperly initialized, has 6571 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 6571 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 6571 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 6571 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has 20664 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has 20664 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has 20665 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has 20664 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has -4424 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has -4424 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has -4424 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has -4424 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has -22812 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has -22812 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has -22812 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has -22811 usecs TSC skew! FIXED.

I did try disabling it once, which stopped the system booting.
I never looked at it any further.

If you are crashing near the wait_init_idle fix, you might
try Ingo's scheduler patch - it has a different way of
fixing this race condition.

M.
