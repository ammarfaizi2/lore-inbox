Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUHJEsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUHJEsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUHJEsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:48:09 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:32131 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267422AbUHJEsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:48:03 -0400
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org> <1092099669.5759.283.camel@cube>
Message-ID: <cone.1092113232.42936.29067.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 14:47:12 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan writes:

> On Mon, 2004-08-09 at 18:59, Con Kolivas wrote:
>> Albert Cahalan writes:
>> 
>> 
>> > Joerg:
>> >    "WARNING: Cannot do mlockall(2).\n"
>> >    "WARNING: This causes a high risk for buffer underruns.\n"
>> > Fixed:
>> >    "Warning: You don't have permission to lock memory.\n"
>> >    "         If the computer is not idle, the CD may be ruined.\n"
>> > 
>> > Joerg:
>> >    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>> >    "WARNING: This causes a high risk for buffer underruns.\n"
>> > Fixed:
>> >    "Warning: You don't have permission to hog the CPU.\n"
>> >    "         If the computer is not idle, the CD may be ruined.\n"
>> 
>> Huh? That can't be right. Every cd burner this side of the 21st century has 
>> buffer underrun protection.
> 
> I'm pretty sure my FireWire CD-RW/CD-R is from
> another century. Not that it's unusual in 2004.
> 
>> I've burnt cds _while_ capturing and encoding 
>> video using truckloads of cpu and I/O without superuser privileges, had all 
>> the cdrecord warnings and didn't have a buffer underrun.
> 
> That's cool. My hardware won't come close to that.
> Burning a coaster costs money.
> 
> Let me put it this way: $$ $ $$$ $$ $ $$$ $$ $
> 
> The warning, if re-worded, will save people from
> frustration and wasted money.

Sounds good; how about something less terrifying? That warning sounds like a 
ruined cd is likely.

>> Last time I gave 
>> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
>> rt_task safe.
> 
> So, you've been working on the scheduler anyway...
> An option to reserve some portion of CPU time for
> emergency use (say, 5% after 1 second has passed)
> would let somebody get out of this situation.

This breaks the real time policy entirely. That's why I run it SCHED_ISO ... 
but of course this isn't available in mainline linux.

> Reporting and/or fixing the cdrecord bug is nice too.

It was a hard lockup and randomly happened during a cd write, creating my 
first coaster in a long time... in rt mode ironically which is how it is 
recommended to be run. So I removed the foolish superuser bit and have had 
no problem since. Yes it was unaltered cdrecord source and it was the 
so-called alpha branch and... Not much else I can say about it really?

Cheers,
Con

