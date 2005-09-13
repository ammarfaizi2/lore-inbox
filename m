Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVIMUjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVIMUjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVIMUjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:39:01 -0400
Received: from spirit.analogic.com ([208.224.221.4]:36617 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932489AbVIMUjA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:39:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <02e201c5b89f$a3248e80$1925a8c0@Thing>
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com> <02e201c5b89f$a3248e80$1925a8c0@Thing>
X-OriginalArrivalTime: 13 Sep 2005 20:38:58.0628 (UTC) FILETIME=[2ABF3040:01C5B8A3]
Content-class: urn:content-classes:message
Subject: Re: HZ question
Date: Tue, 13 Sep 2005 16:38:58 -0400
Message-ID: <Pine.LNX.4.61.0509131615450.8516@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HZ question
Thread-Index: AcW4oyrIEeggBklFQoqURMFiNpxRfg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "jdow" <jdow@earthlink.net>
Cc: "Mark Hounschell" <markh@compro.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Sep 2005, jdow wrote:

> From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>>
>> On Tue, 13 Sep 2005, Mark Hounschell wrote:
>>
>>> I need to know the kernels value of HZ in a userland app.
>>>
>>> getconf CLK_TCK
>>>      and
>>> hz = sysconf (_SC_CLK_TCK)
>>>
>>> both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is
>>> defined as 100.
>>>
>>> include/asm/param.h:
>>>
>>> #ifdef __KERNEL__
>>> # define HZ       1000   /* Internal kernel timer frequency */
>>> # define USER_HZ  100    /* .. some user interfaces are in "ticks" */
>>> # define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
>>> #endif
>>>
>>> Thanks in advance for any help
>>> Mark
>>
>> You are not supposed to 'tear apart' user-mode headers. In particular
>> you are not supposed to use anything in /usr/include/bits,
>> /usr/include/asm,
>> or /usr/include/linux in user-mode programs. These are not POSIX headers.
>>
>> Therefore, HZ is not something that is defined for user-mode programs.
>> the ANSI spec requires that things like clock() return a value that
>> can be divided by CLOCKS_PER_SEC to get CPU time. Nothing in user-mode
>> uses HZ.  That's the reason why later versions of the kernel are
>> able to use dynamic HZ.
>
> That means Linux is not a suitable operating system for multimedia
> applications.
> MIDI needs to schedule in 1 ms or smaller increments. The userland
> application
> should be able to set this. It should be able to determine this. If it
> cannot
> then it is useless. (It also explains why MIDI based applications are so
> absolutely dreadful on Linux.)
>
> {^_^}   Joanne Dow said that.
>
>

Well no. MIDI stuff has drivers that interface with precision timers
in your audio board such as Creative Labs Soundblaster. They have
a serial connection that, with a simple adapter becomes MIDI I/O.
These boards, and even the ones built into motherboards can (do)
generate and receive precision MIDI.

Although I use Cakewalk Home Studio for my MIDI stuff, there is
similar software and drivers for Linux. Search on "MIDI Linux".
In any event, the MIDI stuff could care less about the usual user-
mode timers. That's now how MIDI works. If you intend to make some
MIDI stuff in user-mode, not using hardware timing, your code is
broken from the start. Note that M$ has worse timer resolution
than Linux and the Cakewalk stuff is superb.

If there are MIDI programs that are, as you say, dreadful on
linux, then it's because the programs suck, not because of any
kernel timers.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
