Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279812AbRKFRGL>; Tue, 6 Nov 2001 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279844AbRKFRGB>; Tue, 6 Nov 2001 12:06:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12297 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279846AbRKFRFz>; Tue, 6 Nov 2001 12:05:55 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Using %cr2 to reference "current"
Date: Tue, 6 Nov 2001 17:02:32 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9s9538$23s$1@penguin.transmeta.com>
In-Reply-To: <9s82rl$k51$1@cesium.transmeta.com>
X-Trace: palladium.transmeta.com 1005066332 31910 127.0.0.1 (6 Nov 2001 17:05:32 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Nov 2001 17:05:32 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9s82rl$k51$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>
>Is using %cr2 really faster than the old implementation, or is there
>another reason?  It seems that the alignment constraints on the stack
>still remains, since the %esp solution still remains in places...

I think the _real_ issue with that patch is that %cr2 is by no means
architecturally even guaranteed to work the way the patches want it to
work. 

It's simply not a general-purpose register, and I don't see why it is
assumed to be (a) fast (b) stable and (c) writable.

I could well imagine a x86-compatible chip where %cr2 isn't even
writable.  In fact, reading the intel documentation, I see _nowhere_ a
mention of %cr2 being writable at all - it all just says "contains the
fault address". 

Similarly, there is _nothing_ that guarantees that the low bits of %cr2
are meaningful, writable, or even implemented.

Which means that the whole approach is just depending on undocumented
implementation behaviour. That's asking for trouble.

			Linus
