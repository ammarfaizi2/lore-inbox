Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSDKXGg>; Thu, 11 Apr 2002 19:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312854AbSDKXGf>; Thu, 11 Apr 2002 19:06:35 -0400
Received: from inje.iskon.hr ([213.191.128.16]:7126 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S293135AbSDKXGe>;
	Thu, 11 Apr 2002 19:06:34 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr>
	<20020411150219.A10486@infradead.org> <878z7u6tjd.fsf@atlas.iskon.hr>
	<20020411210916.GO23513@matchmail.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Fri, 12 Apr 2002 01:06:10 +0200
Message-ID: <dnwuvd6djx.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Thu, Apr 11, 2002 at 07:20:54PM +0200, Zlatko Calusic wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>> > I'm unable to reproduce it here - I only have idle partition though..
>> 
>> Here is how it looks here (SMP machine, it could matter):
>> 
>> 
>> major minor #blocks name rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
>> 
>> 34 0 40011552 hdg 23 62 189 70 4 3 32 0 -1 946410 -946410
>> 33 0 60051600 hde 8349 18725 214666 108230 3781 15234 152176 91700 -1 927060 -746550
>>  3 0 19938240 hda 848 1023 14565 5470 1303 1542 22768 300 -1 942120 -940710
>> 
>> 
>> Notice negative numbers for running, aveq. Kernel is 2.4.19-pre5-ac3.
>
> major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
>
>    3     0   10037774 ide/host0/bus0/target0/lun0/disc 2381496 3602026 12295120 24796300 2167401 11887863 28592436 168474630 -1 849341880 -666064880
>    3     1     488344 ide/host0/bus0/target0/lun0/part1 53667 86 430048 544050 18970 47327 535456 2558790 0 499660 3105630
>    3     2    9549288 ide/host0/bus0/target0/lun0/part2 2327827 3601934 11865056 24252240 2148431 11840536 28056980 165915840 0 16504720 190278950
>
> 2.4.19-pre4-ac3
>
> Did I misunderstand when you reported that statistics were not reported for
> partitions in a previous message?  Also -1 only shows up for the drive and
> not the partitions.
>

I was wrong, per-partition information IS correctly reported for
2.4.x. Only in 2.5.x I had to workaround to get per-partition data.

Also, it _seems_ that only on whole devices ios_in_flight variable
(column "running" in /proc/partitions) drops to -1. Your (and mine)
output shows it clearly, yes. This needs further investigation, I have
been unable to find the problem so far.

And, as aveq value is calculated directly from the ios_in_flight
value, the average queue value is wrong too (it never goes negative,
if everything is all right).
-- 
Zlatko
