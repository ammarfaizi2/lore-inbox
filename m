Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273818AbRI0SyA>; Thu, 27 Sep 2001 14:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273820AbRI0Sxu>; Thu, 27 Sep 2001 14:53:50 -0400
Received: from modi.cse.nd.edu ([129.74.32.139]:58538 "EHLO rigel.hagale.net")
	by vger.kernel.org with ESMTP id <S273818AbRI0Sxp>;
	Thu, 27 Sep 2001 14:53:45 -0400
Date: Thu, 27 Sep 2001 13:43:53 -0500 (CDT)
From: Tony Hagale <tony@hagale.net>
To: Bulent Abali <abali@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium SSE prefetcht0 instruction... How do you make it work
In-Reply-To: <OF3A810D97.1605796C-ON85256AD4.0065EDD2@pok.ibm.com>
Message-ID: <Pine.LNX.4.21.0109271335550.4511-100000@hagale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Bulent Abali wrote:

> I have a system with a large external L3 cache.   Uses Pentium III
> Coppermine (stepping 3) processor.   L3 block size is relatively long.  I
> am trying to increase the L3 performance by prefetching L3 lines.  I
> thought prefetcht0, t1, t2, nta instructions may help.  These instructions
> prefetch L1/L2 lines in to the processor therefore they should prefetch L3
> as well.   However I see no benefit.  It is as if prefetch never make it to
> the front side bus.  I took the example of arch/i386/lib/mmx.c to implement
> the asm level routines.    Perhaps I am overlooking something.  I'd
> appreciate any suggestions.   /Bulent
> 

Intel's p3/4 prefetch instructions are hints only. They are only executed
asynchronously, and depend heavily on the other load on the processor at
the time. They are not required to prefetch, *and* they are not required
to be executed when you think they should in the flow of the program. You
can serialize them by using an MFENCE instruction, but they still aren't
guaranteed to run.

Check the p4 manuals. In fact, I'm not sure prefetch was implemented in
p3. I could be wrong, check the manual.

--Tony


-- 

Tony Hagale -- tony@hagale.net -- http://tony.hagale.net
"Quis custodiet ipsos custodiens?"

