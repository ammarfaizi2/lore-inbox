Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273813AbRI0Skq>; Thu, 27 Sep 2001 14:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273814AbRI0Skg>; Thu, 27 Sep 2001 14:40:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:44679 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273813AbRI0Skb>;
	Thu, 27 Sep 2001 14:40:31 -0400
Importance: Normal
Subject: Pentium SSE prefetcht0 instruction... How do you make it work
To: linux-kernel@vger.kernel.org
Cc: abali@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF3A810D97.1605796C-ON85256AD4.0065EDD2@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Thu, 27 Sep 2001 14:40:55 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/27/2001 02:39:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with a large external L3 cache.   Uses Pentium III
Coppermine (stepping 3) processor.   L3 block size is relatively long.  I
am trying to increase the L3 performance by prefetching L3 lines.  I
thought prefetcht0, t1, t2, nta instructions may help.  These instructions
prefetch L1/L2 lines in to the processor therefore they should prefetch L3
as well.   However I see no benefit.  It is as if prefetch never make it to
the front side bus.  I took the example of arch/i386/lib/mmx.c to implement
the asm level routines.    Perhaps I am overlooking something.  I'd
appreciate any suggestions.   /Bulent

//This should prefetch an L2 line at addr (hence L3 line prefetch)
inline void L3_prefetch (char * addr)
{
     asm volatile("prefetcht1 %0" :: "m" (addr));
}


