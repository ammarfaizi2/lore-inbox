Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277644AbRJIADX>; Mon, 8 Oct 2001 20:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277650AbRJIADG>; Mon, 8 Oct 2001 20:03:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42758 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277644AbRJIACq>; Mon, 8 Oct 2001 20:02:46 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: linux-2.4.10-acX
Date: Tue, 9 Oct 2001 00:01:58 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9ptepm$134$1@penguin.transmeta.com>
In-Reply-To: <1002576203.8568.192.camel@phantasy> <E15qi0H-0001xD-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1002585762 10412 127.0.0.1 (9 Oct 2001 00:02:42 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 9 Oct 2001 00:02:42 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15qi0H-0001xD-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> > getting very hard to merge a lot of the fixes like the truncate standards
>> > compliance stuff so they may not make Linus tree until 2.5
>> 
>> What are Linus's complaints about the faster syscall path improvement?
>
>He insisted it wouldnt make it any faster. Of course rdtsc and profiling
>counters of locked cycles show otherwise..

No, I insist that it doesn't make things _noticeably_ faster (a segment
load is something like 12 cycles on a PII), and doing it complicates the
return path unnecessarily for the default case.

I seriously doubt you've (or anybody else) measured it with rdtsc or
profiling: what you call the "fast path" is never taken on regular
system calls, only on nested calls where we return to the kernel.  How
many of those have you ever seen?

In short, has _anybody_ EVER seen any actual improvement from this ugly
"optimization"? 

		Linus
