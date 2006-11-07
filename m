Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753782AbWKGWgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbWKGWgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbWKGWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:36:21 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28622 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753782AbWKGWgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:36:20 -0500
Date: Tue, 7 Nov 2006 23:36:19 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2048 CPUs [was: Re: New filesystem for Linux]
In-Reply-To: <20061107212614.GA6730@ucw.cz>
Message-ID: <Pine.LNX.4.64.0611072328220.10497@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
 <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
 <20061107212614.GA6730@ucw.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi!
>
>>> The SGI Altix can have 2048 CPUs.
>>
>> And does it run one image of Linux? Or more images each
>> on few cpus?
>>
>> How do they solve problem with spinlock livelocks?
>>
>> If time-spent-outside-spinlock/time-spent-in-spinlock <
>> number-of-cpus, the spinlock livelock may happen ---
>> this condition is not true normally with 2 or 4 cpus,
>> but for that high amount of cpus, there is a danger.
>
> Lets say time-spent-outside-spinlock == time-spent-in-spinlock and
> number-of-cpus == 2.
>
> 1 < 2 , so it should livelock according to you...

There is off-by-one bug in the condition. It should be:
(time_spent_in_spinlock + time_spent_outside_spinlock) / 
time_spent_in_spinlock < number_of_cpus

... or if you divide it by time_spent_in_spinlock:
time_spent_outside_spinlock / time_spent_in_spinlock + 1 < number_of_cpus

> ...but afaict this should work okay. Even if spinlocks are very
> unfair, as long as time-outside and time-inside comes in big chunks,
> it should work.
>
> If you are unlucky, one cpu may stall for a while, but... I see no
> livelock.

If some rogue threads (and it may not even be intetional) call the same 
syscall stressing the one spinlock all the time, other syscalls needing 
the same spinlock may stall.

Maybe there are so few Altices in the world that no one has yet observed 
it...

Mikulas
