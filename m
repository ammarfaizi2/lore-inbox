Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUH2Nsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUH2Nsx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUH2Nsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:48:53 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:5115 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S267831AbUH2Nst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:48:49 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 29 Aug 2004 09:48:47 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040825014937.GC15901@zero> <200408250913.23840.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408250913.23840.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408290948.47890.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.62.54] at Sun, 29 Aug 2004 08:48:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 August 2004 02:13, Denis Vlasenko wrote:
>On Wednesday 25 August 2004 04:49, Tom Vier wrote:
>> On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
>> > >are you translating virt->phys?
>> >
>> > No, this is straight out of the memburn output (after I'd fixed
>> > the
>>
>> that's weird that you're finding that pattern in virtual
>> addresses. i wouldn't expect that. even if you're booting to
>> single user, certain variables might change during boot and cause
>> different physical pages to be mapped. maybe single user is more
>> deterministic than i think, though.
>
>On x86, pages are aligned at 4k. Lower 12 bits of virtual address
>match lower 12 bits of corresponding real address.
>
>So, yes, if you hit bad RAM cell, you see random virtual address,
> but three last digits of it (in hex) must be the same.

I think, based on the last 25 hours of running both memburn and 
setiathome at a -nice 19, and there have been no errors, that I might 
have stumbled onto a fix.

It seems the dram is marked DDR400, so I was trying to run it that 
way.  Unforch, on checking the invoice for the umpteenth time, it 
finally dawned on me that this particular AMD 2800XP is supposedly a 
333mhz FSB chip, and not rated for use with DDR400 memory.  Switching 
the bios setting for the memory to 'auto' from 'spd' seems to effect 
this particular item, and the memory now signs in as DDR333 Dual 
Channel.

And after 25 hours, no errors, nothing unusual in the logs.

I guess I should go paint my face with egg or something...  My 
apologies to those who spent a considerable amount of time and brain 
power auditing code because of my stupidity.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
