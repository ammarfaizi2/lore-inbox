Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUHTPIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUHTPIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUHTPHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:07:14 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:20700 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S268155AbUHTPGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:06:17 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 11:06:15 -0400
User-Agent: KMail/1.6.82
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, mingo@elte.hu,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408192238.19567.gene.heskett@verizon.net> <20040820073334.GB8205@logos.cnet>
In-Reply-To: <20040820073334.GB8205@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201106.15117.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.62.54] at Fri, 20 Aug 2004 10:06:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 03:33, Marcelo Tosatti wrote:
[...]
>> >I can't see how that could be caused by flaky hardware.
>>
>> There is still that possibility Marcelo.  Someone recommended I
>> get cpuburn and memburn, and before fixing the scanf statement (it
>> was broken) in memburn, I had compiled it for a 512 meg test the
>> first time, and a 768 meg test the next couple of runs.
>>
>> All exited with errors like this:
>> Passed round 133, elapsed 4827.19.
>> FAILED at round 134/14208927: got ff00, expected 0!!!
>>
>> REREAD: ff00, ff00, ff00!!!
>>
>> [root@coyote memburn]# vim memburn.c
>> [root@coyote memburn]# gcc -o memburn memburn.c
>> [root@coyote memburn]# ./memburn
>> Starting test with size 768 megs..
>>
>> Passed round 0, elapsed 44.36.
>> Passed round 1, elapsed 74.13.
>> Passed round 2, elapsed 105.12.
>> FAILED at round 3/25777183: got 2b00, expected 0!!!
>>
>> REREAD: 2b00, 2b00, 2b00!!!

The latest output of memburn after a bit of format hacking:

FAILED at round 78/165714207: got 0000ff00, expected 00000000!!!
REREAD: 0000ff00, 0000ff00, 0000ff00!!!

and

FAILED at round 160/200780831: got 02025302, expected 02020202!!!
REREAD: 02025302, 02025302, 02025302!!!

So it appears that its the third byte of 4 each time thats fubar'd.  
I'l run it a few more times to confirm.  Is memory byte wide per chip 
on these things today?

>> I've now rebuilt it with a better printf format string, and its
>> running over 768 megs again.  But this time the round counter is
>> up to 90 and still going...
>>
>> Interesting too is that memburn has now allocated a 768 meg wide
>> block 5 times, and still no Oops.  Over a hundred megs in swap,
>> but its still running.
>>
>> I lost the BUG_ON patches in fs/buffer.c, this is now 2.6.8.1-mm2
>> (but I can go back if this fails of course)
>>
>> Or can I just copy that 2.6.8-rc4/fs/buffer.c file over this one?
>
>You can just copy it, _I think_. If you have problems just add the
> BUG_ON's by hand.

Looks like I'll have to, the newer one is about 600 bytes bigger 
already, so there are lots of changes.

OTOH, I'm now up 21 hours, and the memory management so far is 
surviving on 2.6.8.1-mm2.  memburn may be hitting the errors, keeping 
them from taking down the os maybe?  Sillier things have happened.

>Now Ingo also hit the same problem, Ingo can you reproduce that
>remove_inode_buffers()?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
