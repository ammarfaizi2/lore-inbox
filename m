Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319049AbSHMSBe>; Tue, 13 Aug 2002 14:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319050AbSHMSBd>; Tue, 13 Aug 2002 14:01:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46220 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319049AbSHMSBB>; Tue, 13 Aug 2002 14:01:01 -0400
Date: Tue, 13 Aug 2002 11:02:48 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <2000630000.1029261767@flay>
In-Reply-To: <Pine.LNX.4.44.0208131023360.7411-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208131023360.7411-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Was there some reason you really need this on P4s? I seem to recall something
>> to do with timer interrupts, but don't remember exactly.
> 
> Without the explicit balancing, _every_single_ external interrupt comes in 
> on CPU0 on a P4.
> 
> The P4 local APIC doesn't do irq scheduling in hardware (never mind that
> Intel documented it as architecture behaviour in earlier local APICs)

I know, but you pays your money, you choose your breakage ;-)
I can't help feeling that the real solution is to program the TPR like Intel intended,
instead of frigging with the IO-APIC, especially when the the code that does the
frigging is written with incorrect assumuptions. 

Forcing it on for every machine just because P4s are borked sounds wrong.
The current code has several issues (including, I believe, being frequency
dependent on jiffies ... bad with 1000 HZ), so we really do need to disable
it for many machines. Getting rid of the negative config option is easy though.

M.

