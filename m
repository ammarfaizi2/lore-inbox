Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTIZSFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTIZSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:05:47 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:29446 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S261542AbTIZSFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:05:44 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Michael Frank <mhf@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] SIS IDE DMA errors
References: <yw1x7k3vlokf.fsf@users.sourceforge.net>
	<200309262208.30582.mhf@linuxmail.org>
	<yw1x3cejlk34.fsf@users.sourceforge.net>
	<200309262332.30091.mhf@linuxmail.org> <20030926165957.GA11150@ucw.cz>
	<yw1x7k3vjw8o.fsf@users.sourceforge.net>
	<20030926175358.GA12072@ucw.cz>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 26 Sep 2003 19:46:03 +0200
In-Reply-To: <20030926175358.GA12072@ucw.cz> (Vojtech Pavlik's message of
 "Fri, 26 Sep 2003 19:53:58 +0200")
Message-ID: <yw1x3cejjvdw.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

>> > Actually, it's me who wrote the 961 and 963 support. It works fine for
>> > most people. Did you check you cabling?
>> 
>> I'm dealing with a laptop, but I suppose I could wiggle the cables a
>> bit.  I still doubt it's a cable problem, since reading works
>> flawlessly.
>
> Hmm, that's indeed interesting and it'd point to a driver problem -

See, I told you :)

> when reading, the drive is dictating the timing, but when writing, it's
> the controllers turn.
>
> So if the controller timing is not correctly programmed, reads function,
> but writes don't.

Furthermore, short writes work just fine.  The errors usually start
happening after about 100 MB at full speed.  When copying from NFS
over a 100 MB/s network it usually goes a little longer, sometimes
even up to 500 MB.  All this could indicate that there is some error
in the timing, and that it takes some time for it build up enough to
trigger the bad things.  Or am I wrong?

Why can't the drive give notice when it's ready to accept more data?
That would seem like the simple solution, instead of trying to
synchronize the timers.

> Can you send me the output of 'lspci -vvxxx' of the IDE device?
> I'll take a look to see if it looks correct.

Here you go:

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 1688
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at b800 [size=16]
00: 39 10 13 55 07 00 00 00 d0 80 01 01 00 80 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 88 16
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 31 81 00 00 31 85 00 00 08 01 e6 51 00 02 00 02
50: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


>> It appears to me that during heavy IO load, some DMA interrupts get
>> lost, for some reason.
>
> Well, I've got this feeling that not just IDE interrupts get lost under
> heavy IO load with recent kernels ...

Like mouse and keyboard...

-- 
Måns Rullgård
mru@users.sf.net
