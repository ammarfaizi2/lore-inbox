Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270847AbTGVO3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270850AbTGVO3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:29:18 -0400
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:23301 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id S270847AbTGVO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:29:12 -0400
Message-ID: <3F1D4DBA.4010700@cendatsys.com>
Date: Tue, 22 Jul 2003 09:44:10 -0500
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John V. Martinez" <jvm@snarkhunter.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <3F1C54A8.5020404@snarkhunter.com>
In-Reply-To: <3F1C54A8.5020404@snarkhunter.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John:

Quick fix to the problem is remove devfs -- it appears that the devfs 
code doesn't like to have the raid layered on top of it, and it loses 
interrupts.

I've got two systems now running 4 200GB WD's connected to a single 
promise card (ATA100/TX2)  with the booting drive (a 5th drive) attached 
to the motherboard.  The raid works flawlessly and is fast -- I imagine 
there'd be a speedup by keeping all the drives as master (with 2 pdc's) 
and it would be more robust, but those aren't issues.

Hope this helps -- I'll post this to the mailing list to help anyone 
else with this problem.

- Ed

John V. Martinez wrote:

> Hi Ed,
>
> I found a linux-kernel post you made back in March about problems 
> running two Promise IDE controllers in the same system. I have a 
> similar configuration, (and a similar problem,) and I was wondering if 
> you ever found a solution, or if one of the more recent 2.4.21-foo 
> kernels solved it for you.
>
> (I have two Promise ATA-100/TX2 (20268 chip) controllers, and I have 
> one 200GB WD drive as a single master on each channel. The two 
> controllers are sharing interrupts with othwer cards, but not with 
> each other. I can access each disk individually, but when I tried to 
> make them work hard: mkraid a RAID5 array using these four drives, the 
> system freezes HARD until I hit the big red button. [Then it reboots, 
> spots the raid superblock, tries to rebuild my RAID5 array, and 
> freezes again, until I get a clue and unplug the drives in question 
> while powered down :^))
>
> Anyway, if you have any more insight into this problem than you did in 
> March, and care to share, I'd be much obliged.
>
> Cheers,
>
> -(-- John


