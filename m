Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945927AbWANEOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbWANEOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 23:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWANEOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 23:14:23 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:52919 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1945927AbWANEOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 23:14:22 -0500
Message-ID: <43C88833.9050107@karett.se>
Date: Sat, 14 Jan 2006 06:12:19 +0100
From: Mikael Andersson <mikael@karett.se>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Clark Williams <williams@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt4 failure with LATENCY_TRACE on x86_64
References: <1137103652.11354.40.camel@localhost.localdomain>  <1137122280.7338.6.camel@localhost.localdomain>  <1137164761.3332.2.camel@localhost.localdomain>  <1137167679.7241.25.camel@localhost.localdomain> <1137193088.3170.34.camel@localhost.localdomain> <Pine.LNX.4.58.0601131807350.10046@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0601131807350.10046@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 13 Jan 2006, Clark Williams wrote:
>>Have you tried booting your system with a up kernel?
>>
> Not a x86_64 up.  But serveral up i386 boxes.
> 

I had a very similar problem on a x86_64 up. I got a segfault in init 
with LATENCY_TRACE enabled on 2.6.15-rt2.
I get it at ffffffff8010fe30, which should be mcount according to my 
System.map [1]. It seems a bit weird because i have tried to alter 
mcount somewhat. Initially by removing the initial comparison, but later
i tried a few other things also. Nothing had any effect at all.

AFAIK glibc also has a mcount symbol, and it's almost as if ld.so would 
have linked the glibc mcount symbol to the kernel symbol mcount. That
would naturally lead to a pagefault :)
  And it would be consistent with the fact that statically linked shells
works.

It's probably something completely different, bevause that would be 
really weird. OTOH, it was really weird that i could change the asm for 
mcount in entry.S without any effect whatsoever.

I'll verify that it hasn't gone away in lates 2.6.15-rt tomorrow.

[1]
ffffffff8010fd68 T machine_check
ffffffff8010fdf0 T call_debug
ffffffff8010fe00 T call_softirq
ffffffff8010fe30 T mcount
ffffffff8010fe65 t skiptrace
ffffffff8010fe7c t out

/Mikael
