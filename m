Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSB1AOH>; Wed, 27 Feb 2002 19:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293087AbSB1ANg>; Wed, 27 Feb 2002 19:13:36 -0500
Received: from mout1.freenet.de ([194.97.50.132]:49368 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S293092AbSB1ANT>;
	Wed, 27 Feb 2002 19:13:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre1-ac1
Date: Thu, 28 Feb 2002 01:13:23 +0100
X-Mailer: KMail [version 1.2]
Cc: florin@iucha.net (Florin Iucha), linux-kernel@vger.kernel.org
In-Reply-To: <E16gDhO-0006OL-00@the-village.bc.nu>
In-Reply-To: <E16gDhO-0006OL-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <02022800441601.01097@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan and folks,

> What compiler firstly, and what I/O subsystem. Are you using highmem,
> did you build from a clean tree ?

gcc 2.95.2, I/O subsystem is PIIX4 IDE here. No problems with "pure" reading 
and writing however, so it really seems to be connected to something special 
done by patch. Build was fresh from a clean tree. 

> I also think your report is unrelated to the reiserfs one. 2.4.18 proper
> and -ac have a small reiserfs fix which is a viable candidate for
> reiserfs funnies while what you report is somewhat different

Perhaps - but strange both are only triggered by "patch"? Or maybe the 
reiserfs errors are later consequences of the same problem.

> Maybe a candidate
> 	shared memory filesystem fixes (also used for sys5 shm
> 		and anonymous shared maps)
> 		[copy mm/shmem.c from the working -ac to the current -ac
> 		 and retest]

Will try this now, sounds possible - but does patch really use shared memory?
I will try to narrow it down a bit. There also were some changes to 
mm/memory.c between 2.4.18-rc2-ac2 and 2.4.18-ac1. Also a possibility?

> 	Small pnpbios update (only relevant if building with PNPBIOS)
> 		[Build without PNPbios and retest]

Have bios enabled in all kernels, will try without. But there were no PNPBIOS 
changes between the working 2.4.18-rc2-ac2 and the failing 2.4.18-ac1, so
I would rule this out.

> Wildly improbable
> 	Correct NULL check in the sd scsi code
> 	open fix for ps2 driver

Not using sd driver or ps2 at all.

> Hw specific (check your hardware and config and you can rule these out I
> guess) JFS specific fixes
> 	A sparc64 specific compile fix
> 	An off by one fix for loop that only affects using a specific
> 		option with maxloop=256
> 	Patches that only impact users of nbd
> 	An AMD ELan specific driver for watchdog - no affect on others
> 	Locking fixes for the softdog driver
> 	A serverworks specific ide=nodma fix
> 	LS220 experimental code (which shouldnt be enabled or matter)
> 	Tiny tweaks to the margi DVD card driver
> 	Ifdef of two lines specific to promise sx6000 raid
> 	3c359 token ring driver (doesnt touch generic code)
> 	olypmic token ring specific locking change
> 	netrom specific fixes

Use nothing at all of them, just compiled most things as modules, which are 
not loaded.

Greetings,
Andreas
