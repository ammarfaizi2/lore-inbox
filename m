Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288578AbSAHXd3>; Tue, 8 Jan 2002 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288575AbSAHXdK>; Tue, 8 Jan 2002 18:33:10 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:36365 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S288574AbSAHXdB>; Tue, 8 Jan 2002 18:33:01 -0500
Date: Tue, 8 Jan 2002 17:32:54 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108173254.B9318@asooo.flowerfire.com>
In-Reply-To: <E16Nyaf-0000A5-00@starship.berlin> <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it>; from kernel@Expansa.sns.it on Wed, Jan 09, 2002 at 12:02:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 12:02:48AM +0100, Luigi Genoni wrote:
| Probably sometimes they are not making a good business. In the reality
| preempt is good in many scenarios, as I said, and I agree that for
| desktops, and dedicated servers where just one application runs, and
| probably the CPU is idle the most of the time, indeed users have a speed
| feeling. Please consider that on eavilly loaded servers, with 40 and more
| users, some are running gcc, others g77, others g++ compilations, someone
| runs pine or mutt or kmail, and netscape, and mozilla, and emacs (someone
| form xterm kde or gnome), and and
| and... You can have also 4/8 CPU butthey are not infinite ;) (but I talk
| mainly thinking of dualAthlon systems).
| there is a lot of memory and disk I/O.
| This is not a strange scenary on the interactive servers used at SNS.
| Here preempt has a too high price

MacOS 9 is the OS for you.

Essentially what the low-latency patches are is cooperative
multitasking.  Which has less overhead in some cases than preemptive as
long as everyone is equally nice and calls WaitNextEvent() within the
right inner loops.  In the absence of preemptive, Andrew's patch is the
next best thing.  But Bad Things happen without preemptive.  Just try
using Mac OS 9. ;)

Preemptive gives better interactivity under load, which is the whole
point of multitasking (think about it).  If you don't want the overhead
(which also exists without preemptive) run #processes == #processors.

Whether or not preemptive is applied, having a large number of processes
active is a performance hit from context switches, cache thrashing, etc.
Preemptive punishes (and rewards) everyone equally, thus better latency.

I'm really surprised that people are still actually arguing _against_
preemptive multitasking in this day and age.  This is a no-brainer in
the long run, where current corner cases aren't holding us back.

At least IMVHO.
-- 
Ken.
brownfld@irridia.com

| > By the way, have you measured the cost of -preempt in practice?
| >
| Yes, I did a lot of tests, and with current preempt patch definitelly
| I was seeing a too big performance loss.
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
