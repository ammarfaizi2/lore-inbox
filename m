Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUG2WXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUG2WXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUG2WXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:23:47 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:12679 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S267486AbUG2WWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:22:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Thu, 29 Jul 2004 18:22:47 -0400
User-Agent: KMail/1.6.82
References: <200407242156.40726.gene.heskett@verizon.net> <200407250012.52743.gene.heskett@verizon.net> <200407250909.00227.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407250909.00227.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407291822.47209.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.90.166] at Thu, 29 Jul 2004 17:22:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 02:09, Denis Vlasenko wrote:
>On Sunday 25 July 2004 07:12, Gene Heskett wrote:
>> >Not much... at least you can look up that EIP in System.map.
>> >Also, do you really need all that sound stuff?
>>
>> It seems to all come in with the main driver for the ALC650.  And
>> it works pretty good once i got it figured out.  Everything but
>> the bt878 audio, which is so far down the s/s+n isn't more than 30
>> db.
>
>I meant "do not use it and see whether that helps".
>
>> c0164376 isn't a label, but its in between these two in the
>> System.map c0164340 t prune_dcache
>> c0164500 T shrink_dcache_sb
>>
>> But thats all I can deduce from here.
>
>Of course, it points _inside_ prune_dcache(), not at the very
>first instruction of it.
>
>Do:
>
>objdump -d <file containing prune_dcache>.o >file.objdump

This worked rather nicely and I have a rather large dcacheDOTo.txt 
file now.

>and
>make path/to/<file containing prune_dcache>.s

But this ones still being difficult.  Make does want to generate it.  
At best it claims that dcache.o is uptodate. I don't figure one file 
is worth much without the other, so whats wrong with my syntax?
[root@coyote fs]# make dcache.c>.s
[root@coyote fs]# less .s
Which contains "make: Nothing to be done for `dcache.c'."

The vanishing post contained my .config for a 2.6.7 kernel, which had 
a log snip of a very similar Oops but without the total crash.  That 
at least is a quite measureable improvement.

So obviously I'm not understanding your use of the <> arrows yet.

Now, since my last post, which so far in about 8 hours, has not come 
back from the list, I've run memtest86-3.1a for 12 full passes thru 
this gigabyte of ram with no errors reported.  I've also gone thru 
the init.d directory shutting off things that it doesn't appear are 
of any use to me.

And, I've got a tail running on the log in another window.

>and using resulting .objdump and .s files, find exact
>instruction and C code line where it died.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
