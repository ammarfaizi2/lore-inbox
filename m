Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280820AbRKBUha>; Fri, 2 Nov 2001 15:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKBUhK>; Fri, 2 Nov 2001 15:37:10 -0500
Received: from otter.mbay.net ([206.40.79.2]:62729 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280823AbRKBUhA> convert rfc822-to-8bit;
	Fri, 2 Nov 2001 15:37:00 -0500
From: John Alvord <jalvo@mbay.net>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Zlatko's I/O slowdown status
Date: Fri, 02 Nov 2001 12:36:49 -0800
Message-ID: <ns06utok2aq9v93alto9kgq2200kd74b83@4ax.com>
In-Reply-To: <87g07xdj6x.fsf@atlas.iskon.hr> <Pine.LNX.4.33.0111021215260.15759-100000@windmill.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0111021215260.15759-100000@windmill.gghcwest.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001 12:16:40 -0800 (PST), "Jeffrey W. Baker"
<jwbaker@acm.org> wrote:

>
>
>On 2 Nov 2001, Zlatko Calusic wrote:
>
>> Andrea Arcangeli <andrea@suse.de> writes:
>>
>> > Hello Zlatko,
>> >
>> > I'm not sure how the email thread ended but I noticed different
>> > unplugging of the I/O queues in mainline (mainline was a little more
>> > overkill than -ac) and also wrong bdflush histeresis (pre-wakekup of
>> > bdflush to avoid blocking if the write flood could be sustained by the
>> > bandwith of the HD was missing for example).
>>
>> Thank God, today it is finally solved. Just two days ago, I was pretty
>> sure that disk had started dying on me, and i didn't know of any
>> solution for that. Today, while I was about to try your patch, I got
>> another idea and finally pinpointed the problem.
>>
>> It was write caching. Somehow disk was running with write cache turned
>> off and I was getting abysmal write performance. Then I found hdparm
>> -W0 /proc/ide/hd* in /etc/init.d/umountfs which is ran during shutdown
>> but I don't understand how it survived through reboots and restarts!
>> And why only two of four disks, which I'm dealing with, got confused
>> with the command. And finally I don't understand how I could still got
>> full speed occassionaly. Weird!
>>
>> I would advise users of Debian unstable to comment that part, I'm sure
>> it's useless on most if not all setups. You might be pleasantly
>> surprised with performance gains (write speed doubles).
>
>That's great if you don't mind losing all of your data in a power outage!
>What do you think happens if the software thinks data is committed to
>permanent storage when in fact it in only in DRAM on the drive?

Sounds like switching write-caching off at shutdown is a valid way to
get the data out of cache. But shouldn't it be switched back on again
later?

john
