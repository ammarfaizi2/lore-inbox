Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVAOSbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVAOSbG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVAOSbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:31:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25736 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262304AbVAOSbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:31:03 -0500
Date: Sat, 15 Jan 2005 19:30:49 +0100 (MET)
Message-Id: <200501151830.j0FIUnjR020458@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: pavel@ucw.cz
Subject: Re: Screwy clock after apm suspend
Cc: bernard@blackham.com.au, linux-kernel@vger.kernel.org, shawv@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005 14:10:19 +0100, Pavel Machek wrote:
>>  > Looking harder, in arch/i386/kernel/apm.c the system time is also
>>  > saved and restored in a very similar way to timer_suspend/resume.
>>  > Would this account for the time drift in APM mode? (sleep time being
>>  > accounted for twice?)
>> 
>> No, apm.c's update to xtime is absolute, just like time.c's.
>> Doing both is pointless but not harmful. (I've already tried
>> with apm.c's xtime update commented out, but the time-warp
>> bug remained.)
>> 
>> My 0.02 SEK says it's the jiffies update that's broken.
>
>Okay, can you
>
>* kill jiffie update (x86-64, too)
>* remove apm.c variant
>* test it (or make someone test it) with apm?
>
>I now see the drift with acpi, too :-(. I can do the acpi testing...

I'm no longer seeing any time jumps after resumes with the
2.6.11-rc1 kernel. It looks like the wall_jiffies change in
time.c fixed the bug.

/Mikael
