Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267369AbSLRTEZ>; Wed, 18 Dec 2002 14:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbSLRTEZ>; Wed, 18 Dec 2002 14:04:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:38074 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267369AbSLRTEX>;
	Wed, 18 Dec 2002 14:04:23 -0500
Message-ID: <3E00C891.D9316FE8@digeo.com>
Date: Wed, 18 Dec 2002 11:12:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com> <20021218154023.29726d09.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 19:12:17.0076 (UTC) FILETIME=[614B5740:01C2A6C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi Linus, Andrew,
> 
> On Tue, 17 Dec 2002 20:07:53 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
> >
> > Btw, on another tangent - Andrew Morton reports that APM is unhappy about
> > the fact that the fast system call stuff required us to move the segments
> > around a bit. That's probably because the APM code has the old APM segment
> > numbers hardcoded somewhere, but I don't see where (I certainly knew about
> > the segment number issue, and tried to update the cases I saw).
> 
> I looked at this yesterday and decided that it was OK as well.
> 
> > Debugging help would be appreciated, especially from somebody who knows
> > the APM code.
> 
> It would help to know what "unhappy" means :-)
> 
> Does the following fix it for you? Untested, assumes cache lines are 32
> bytes.

It does fix the apmd oops, and APM works fine.

Here's the patch again.  (But what happens if cachelines are not 32 bytes?)


--- 25/include/asm-i386/segment.h~sfr	Wed Dec 18 10:54:07 2002
+++ 25-akpm/include/asm-i386/segment.h	Wed Dec 18 10:54:07 2002
@@ -65,9 +65,9 @@
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
 /*
- * The GDT has 23 entries but we pad it to cacheline boundary:
+ * The GDT has 25 entries but we pad it to cacheline boundary:
  */
-#define GDT_ENTRIES 24
+#define GDT_ENTRIES 28
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 

_
