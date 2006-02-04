Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWBDUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWBDUYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBDUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:24:06 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:3445 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932561AbWBDUYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:24:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nSnWCtObx1tJ7cHh73zQryHp0aBy9BOaP2Yk7Dv0bFze6zGsTPfUFbu8AZ3Ff/P08kDiPy0xBB6b6oJ/BGv5B09iyvdtBPWTmdvVg420olgzWf9qqdEEGmbEekk2aESKCrDm7pIzlfaK3sJDpLKf5yA8liiF5vrLMHxdwd3Zmyk=
Message-ID: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
Date: Sat, 4 Feb 2006 15:24:04 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       safemode@comcast.net
Subject: Re: athlon 64 dual core tsc out of sync
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan writes:
> On Saturday 04 February 2006 19:03, Lee Revell wrote:
>> On Fri, 2006-02-03 at 21:10 -0500, Ed Sweetman wrote:

>>> I know this has been gone over before, and I am aware of
>>> the possible fix being the use of the pmtmr.
>>>
>>> My question is, if there is support builtin to the kernel for more than
>>> one timer, and we know that no timer but the pmtimer is reliable on a
>>> dual core system, why doesn't the startup of the kernel choose the
>>> pmtimer based on if it detects the system is a dual core proc with smp
>>> enabled?   And if the pmtimer doesn't fix this sync issue, is there a
>>> fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot
>>> args to the kernel results in these messages.
>>
>> Excellent question.  What's the status of this bug?  It's a
>> showstopper for a ton of people on the JACK list...
>
> As Andi has recounted many times already, pmtmr is now the
> default on x86-64 if it's built in. I'm sure you can confirm
> this from the sources.

That's unhelpful unless you are suggesting that Linux no
longer supports running the 32-bit kernel on 64-bit hardware.
If that is the case, it ought to detect the incompatibility
and refuse to boot.

My clock was going about 1.414 times as fast as it ought to.
Why that looks like the square root of two I don't know.

There have been far too many other problems with i386 timekeeping as well.
Really, it's crazy to not use the pmtmr if the pmtmr is available. The next
best choice would be HPET. After that, pre-SMM systems should count clock
ticks and post-SMM systems should read the RTC or PIT registers. Until we
accept this, we'll always be suffering clock problems.
