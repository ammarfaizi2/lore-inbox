Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTBLUHW>; Wed, 12 Feb 2003 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTBLUHW>; Wed, 12 Feb 2003 15:07:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28897 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267612AbTBLUHV>; Wed, 12 Feb 2003 15:07:21 -0500
Date: Wed, 12 Feb 2003 15:17:04 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302122017.h1CKH4b13492@devserv.devel.redhat.com>
To: Shawn Starr <spstarr@sh0n.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for   i8042?
In-Reply-To: <mailman.1045078501.23836.linux-kernel2news@redhat.com>
References: <mailman.1045078501.23836.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Wed, Feb 12, 2003 at 11:14:40AM -0500, Shawn Starr wrote:
>> >
>> > Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
>> > not in 2.5 *with* PS/2 mouse enabled?!
>>
>> Because this interrupt is only requested when /dev/psaux is opened in 2.4.
> 
> I see, wasn't this better behaviour though?

Not for all hardware. As SMM emulated "software i8042" continue
to spread, the bugs continue to spread as well. Some systems,
notably Dell i5000 simply do not work at all if the IRQ12 is
not serviced (it's actually a little more complicated, but anyway...).

I saw that the counter was at zero for your soundblaster, but
I strongly suspect it had little to do with the PS/2 mouse.
I am surprised it even compiles. I think it was one of the
last drivers converted to proper DMA API, perhaps it just
wasn't done right. I know SB won't interrupt if DMA does not
complete. Why don't you verify that the sound subsystem is
sane in your case? You might be using ALSA and not knowing it.

-- Pete
