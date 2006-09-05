Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWIEXkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWIEXkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIEXkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:40:20 -0400
Received: from mail.tmr.com ([64.65.253.246]:451 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932224AbWIEXkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:40:19 -0400
Message-ID: <44FE0BDE.40309@tmr.com>
Date: Tue, 05 Sep 2006 19:44:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru>
In-Reply-To: <44FBD08A.1080600@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Marc Perkel wrote:
>> If I have two drives and I want swap to be fast if I allocate swap spam
>> on both drives does it break up the load between them? Or would it run
>> faster if I did a Raid 0 swap?
> 
> Don't do that - swap on raid0.  Don't do that.  Unless you don't care
> about your data, ofcourse.  Seriously.

Please don't spread FUD. Particularly when there are valid technical 
arguments to be made. RAID0 does increase the chance of any error, but 
it is still a very small chance. With drive failures measured in years, 
it's misleading to make it sound as if going RAID0 will result in a 
rapid failure.
> 
> If something with swap space goes wrong, God only knows what will break.

The same thing that will go wrong if your one and only swap drive goes 
bad. You get a disk error, the kernel copes with it well or badly, the 
system grinds to a halt or crashes. Flames do not come out and your cat 
will NOT get pregnant (at least from swap failure).

> It is trivial to break userspace data this way, when an app is swapped
> out and there's an error reading it from swap, its data file very likely
> to be corrupt, especially when it is interrupted during file update.
> It is probably possible to corrupt the whole filesystem this way too,
> when some kernel memory has been swapped out and is needed to write some
> parts of filesystem, but it can't be read back.

More FUD.
> 
> Ie, your swap space must be reliable.  At least not worse than your memory.
> And with striping, you've much more chances of disk failure...

You roughly double your chance, which still leaves the chances of a 
failure in one every few years. But wait, there more! Unless you use the 
drive just for swapping, the chances are that an error will happen 
somewhere else on the disk.
> 
> Yes it sounds very promising at first, to let kernel stripe swap space,
> for faster operations.  But hell, first, try to avoid swappnig in the
> first place, by installing appropriate amount memory which is cheap
> nowadays, so there will be just no need for swapping.  And when it's
> done, it's not relevant anymore whenever your swap space is fast or
> not.  But make it *reliable*.

The truth is that striping may not make swap faster, because (a) the 
transfer rate may or may not be faster, but (b) the seek time will be 
the slowest seek on any drive used. There's a good technical reason, 
RAID0 may not help.

However, RAID1 will help, again not because it's more reliable, but 
because when you do a swap in (that's where you really feel swap delay), 
you increase the chance that there will be a copy of your data on a 
drive which isn't busy.

So the correct answer is not related to reliability problems, which are 
rare, but performance problems, which is why you did the RAID in the 
first place.

Final note: if you are building a really reliable system, PAID6 on all 
data, redundant power supplies (the highest point of total failure), 
then you should go to RAID0 for swap, on multiple controllers, 
preferably one drives in different enclosures. RAID6 for swap sucks 
rocks off the bottom of the ocean, three way RAID1 performs well even 
after a one drive failure.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
