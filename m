Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTANU3h>; Tue, 14 Jan 2003 15:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTANU3g>; Tue, 14 Jan 2003 15:29:36 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:18783 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265238AbTANU3E>;
	Tue, 14 Jan 2003 15:29:04 -0500
Message-ID: <3E247548.1000800@acm.org>
Date: Tue, 14 Jan 2003 14:38:32 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: timing an application
References: <Pine.LNX.4.51.0301142044400.6432@dns.toxicfilms.tv> <3E246DE5.7080302@nortelnetworks.com>
In-Reply-To: <3E246DE5.7080302@nortelnetworks.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a patch at http://home.attbi.com/~minyard/highres-2.4.17.patch that
adds a config item that times CPU usage at microsecond resolution.  It's 
only
for the 2.4.17 kernel, I don't know what the porting effort would be for 
other
kernels.

It's not a great patch, it would need some work to be really clean from 
a code
quality point of view, but it does seem to work.  With it you can use 
getrusage()
to get the actual time your process has used between two points.  It 
works on
x86 and PPC.

Plus, obviously, this adds significant time to system calls and interrupts.

-Corey

Chris Friesen wrote:

> Maciej Soltysiak wrote:
>
>> Hi,
>>
>> being inspired by some book about optimizing c++ code i decided to do
>> timing of functions i wrote. I am using gettimeofday to set
>> two timeval structs and calculate the time between them.
>> But the results depend heavily on the load, also i reckon that this
>> is an innacurate timing.
>>
>> Any ideas on timing a function, or a block of code? Maybe some kernel
>> timers or something.
>
>
> gettimeofday() is accurate.  However, your task may be interrupted by
> other tasks, interrupts, etc.
>
> Your best bet may be to do many iterations of the routine in question 
> and then
> do some statistical analysis of the results.
>
> Chris
>
>
>


