Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVEPB41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEPB41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 21:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVEPB41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 21:56:27 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:16287 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261229AbVEPB4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 21:56:21 -0400
Date: Sun, 15 May 2005 21:56:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-reply-to: <20050515152956.GA25143@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Message-id: <200505152156.18194.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1115963481.1723.3.camel@alderaan.trey.hu>
 <200505151121.36243.gene.heskett@verizon.net>
 <20050515152956.GA25143@havoc.gtf.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 May 2005 11:29, Jeff Garzik wrote:
>On Sun, May 15, 2005 at 11:21:36AM -0400, Gene Heskett wrote:
>> On Sunday 15 May 2005 11:00, Mikulas Patocka wrote:
>> >On Sun, 15 May 2005, Tomasz Torcz wrote:
>> >> On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
>> >> > > > > However they've patched the FreeBSD kernel to
>> >> > > > > "workaround?" it:
>> >> > > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09
>> >> > > > >/ht t5.patch
>> >> > > >
>> >> > > > That's a similar stupid idea as they did with the disk
>> >> > > > write cache (lowering the MTBFs of their disks by
>> >> > > > considerable factors, which is much worse than the power
>> >> > > > off data loss problem) Let's not go down this path
>> >> > > > please.
>> >> > >
>> >> > > What wrong did they do with disk write cache?
>> >> >
>> >> > They turned it off by default, which according to disk
>> >> > vendors lowers the MTBF of your disk to a fraction of the
>> >> > original value.
>> >> >
>> >> > I bet the total amount of valuable data lost for FreeBSD
>> >> > users because of broken disks is much much bigger than what
>> >> > they gained from not losing in the rather hard to hit power
>> >> > off cases.
>> >>
>> >>  Aren't I/O barriers a way to safely use write cache?
>> >
>> >FreeBSD used these barriers (FLUSH CACHE command) long time ago.
>> >
>> >There are rumors that some disks ignore FLUSH CACHE command just
>> > to get higher benchmarks in Windows. But I haven't heart of any
>> > proof. Does anybody know, what companies fake this command?
>> >
>> >From a story I read elsewhere just a few days ago, this problem
>> > is
>>
>> virtually universal even in the umpty-bucks 15,000 rpm scsi server
>> drives.  It appears that this is just another way to crank up the
>> numbers and make each drive seem faster than its competition.
>>
>> My gut feeling is that if this gets enough ink to get under the
>> drive makers skins, we will see the issuance of a utility from the
>> makers that will re-program the drives therefore enabling the
>> proper handling of the FLUSH CACHE command.  This would be an
>> excellent chance IMO, to make a bit of noise if the utility comes
>> out, but only runs on windows.  In that event, we hold their feet
>> to the fire (the prefereable method), or a wrapper is written that
>> allows it to run on any os with a bash-like shell manager.
>
>There is a large amount of yammering and speculation in this thread.

I agree, and frankly I'm just another  of the yammerers as I don't 
have the clout to be otherwise.

>Most disks do seem to obey SYNC CACHE / FLUSH CACHE.
>
> Jeff

I don't think I have any drives here that do obey that, Jeff.  I got 
curious about this, oh, maybe a year back when this discussion first 
took place on another list, and wrote a test gizmo that copied a 
large file, then slept for 1 second and issued a sync command.  No 
drive led activity until the usual 5 second delay of the filesystem 
had expired.  To me, that indicated that the sync command was being 
returned as completed without error and I had my shell prompt back 
long before the drives leds came on.  Admittedly that may not be a 
100% valid test, but I really did expect to see the leds come on as 
the sync command was executed.

I also have some setup stuff for heyu that runs at various times of 
the day, reconfigureing how heyu and xtend run 3 times a day here, 
which depends on a valid disk file, and I've had to use sleeps for 
guaranteeing the proper sequencing, where if the sync command 
actually worked, I could get the job done quite a bit faster.

Again, probably not a valid test of the sync command, but thats the 
evidence I have.  I do not believe it works here, with any of the 5 
drives currently spinning in these two boxes.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
