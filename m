Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267907AbUHFCDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267907AbUHFCDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUHFCDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:03:48 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:51919 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S267907AbUHFCDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:03:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 22:03:18 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408052203.18662.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.63.211] at Thu, 5 Aug 2004 21:03:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 12:26, Linus Torvalds wrote:
>On Thu, 5 Aug 2004, Denis Vlasenko wrote:
>> It is not a BUG().
>
>Oh yes it is. The 2.6.8-rc2-mm2 report definitely was a BUG().
>
>Earlier ones may not have been, but on the other hand, earlier ones
> may not have had the BUG()-check for corrupted list_del() usage -
> it's not in the standard kernel, and I don't know when it was added
> to -mm. (We used to have it a _long_ time ago, but then we removed
> it because there were no reports of problems).
>
>> It's an oops (dereferencing a d_op pointer with value
>> 0x00000900+14 IIRC, Gene has complete disassembly with location of
>> that event).
>
>.. and that must be because of some kind of pointer corruption,
> where the dentry was either free'd twice or the dentry simply isn't
> a dentry at all, it just got to be used as such because of some
> bug.
>
>> It is not reproducible on request, but happens for him from time
>> to time in the same place with the same bogus value of d_op.
>
>I've followed the discussion. You may not have noticed that the last
> one was different. (And I _think_ it may hav ebeen the first time
> Gene did a -mm kernel, so I do believe that the list_del()
> debugging was the thing that caught it).
>
>Anyway, one other thing that makes me worry is the fact that Gene
>apparently has a K7. One of the things AMD has gotten wrong several
> times is prefetching, and it so happens that the dcache code is one
> of the users of the prefetch instruction. prude_dcache() in
> particular.
>
>So I'm also entertaining the notion that there's an actual prefetch
> data corruption, not just the known AMD bug with occasional
> spurious page faults. Who else has seen the problem? What CPU's are
> involved?
>
>		Linus

Two things that may be of interest: 1, I do run the -mm kernels too as 
I figure the more they get excersized, the quicker some fault will be 
found.  This included the whole chain of 2.6.7's & 2.6.8-rc1/2-mm1/2.  
In this case all hell broke loose here while everyone was at the 
conventions.  Not your fault, but I was "grabbing a life jacket" 
here.

2. with the patch Linus sent, top is now showing 383 megs of free ram.  
I suspect that without that patch, it might well be less than 15 megs 
after a many (10+) hour uptime.  So this patch is definitely more 
aggressive in its memory housekeeping than without it.

And everything is on except the acpi stuffs, which has ever interested 
me here.  I do use apm, but only for shutdowns & rtc in utc.
PREEMPT, 4k stacks, page tables in high mem, frame pointers etc, its 
all on right now. So far, I haven't even heard the first shoe 
drop. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
