Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUHGTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUHGTBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUHGTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:01:35 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:42480 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S264246AbUHGTB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:01:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sat, 7 Aug 2004 15:01:26 -0400
User-Agent: KMail/1.6.82
Cc: Chris Shoemaker <c.shoemaker@cox.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org> <20040807134414.GA16953@cox.net>
In-Reply-To: <20040807134414.GA16953@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408071501.27081.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.8.157] at Sat, 7 Aug 2004 14:01:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 09:44, Chris Shoemaker wrote:
>On Fri, Aug 06, 2004 at 11:20:28PM -0700, Linus Torvalds wrote:
>> On Fri, 6 Aug 2004, Chris Shoemaker wrote:
>> > I _was_ able to find the attached oops, but I don't think I have
>> > the corresponding object files, so I hope the decoding it
>> > contains is good enough.
>>
>> It's fine.
>
>Well then, maybe you'd like more?  I attached two more from the same
>period.  Please remember that these are 5 months old, and could
>represent bugs already fixed.  I think this was stock 2.6.4.
>
>> It oopses on
>>
>> 	inode->i_sb->s_op
>>
>> where "i_sb" is bad and contains the pointer "0x0b7eebf8" which is
>> definitely not a valid kernel pointer.
>>
>> There's a few other strange details in your oops report too. One
>> being that the inode pointer (in %ebx, apparently) doesn't show on
>> the stack where I'd expect it to show. Hmm. That might be just a
>> different compiler issue, though.
>
>Perhaps due to CONFIG_REGPARM?  I haven't used it for quite a while,
> but back in March I was a bit bolder about config options marked
> experimental.  Gene, are you using REGPARM?
>
>-chris

No Chris.  I think I may have had it on for maybe 10 minutes, in 
2.6.7-mmsomething maybe.  But it died without a trace, (on the old 
motherboard with an Athlon 1600XP on it) as I was starting X, so on 
the next reboot to 2.6.7, I turned it back off and haven't turned it 
back on since.

IIRC that was before the video card took ill, so at that point I was 
blaming my problems, which were generally only post problems then, as 
symptoms of heat.  TBE it had to warm up before it would post!  By 
the time the video card wouldn't post, memtest86 was also finding bad 
memory (with a new card plugged in), hence the whole mobo got 
retired.

>> Anyway, this does look somewhat like the ones Gene is seeing. If I
>> had to guess, I'd guess that either the inode pointer is bad, or
>> it's just stale from an inode that has already been free'd. Most
>> likely because of prune_dcache() having had a corrupt LRU list
>> with a stale/corrupt entry.
>>
>> That would blow the prefetch theory out of the water.
>>
>> 		Linus

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
