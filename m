Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293051AbSB0X1a>; Wed, 27 Feb 2002 18:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293055AbSB0X1C>; Wed, 27 Feb 2002 18:27:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56850 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293051AbSB0X0w>; Wed, 27 Feb 2002 18:26:52 -0500
Subject: Re: Linux 2.4.19pre1-ac1
To: afranck@gmx.de (Andreas Franck)
Date: Wed, 27 Feb 2002 23:41:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), florin@iucha.net (Florin Iucha),
        linux-kernel@vger.kernel.org
In-Reply-To: <02022723312400.01097@dg1kfa> from "Andreas Franck" at Feb 27, 2002 11:31:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gDhO-0006OL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can reproduce this too on ext2, so this does not seem to be FS related. 
> 
> However, I do not get this error messages, the patch runs just fine,
> but corrupts all files it touches, leaving them to be all a bit less than 
> 1MiB of size, and all exactly the same size.
> 
> There is no filesystem corruption however, e2fsck runs just fine without any 
> error. Just the files are all damaged. I looked inside them, and it seems 
> huge parts of other files from the patch have been "attached" to them.
> 
> > 18-rc2-ac1 works fine on the same partition.
> 
> ACK, for me too; as well as 2.4.18-rc2-ac2 for me. The breakage starts with
> 2.4.18-ac1 here.  Plain 2.4.18 from Marcelo works fine as well.

What compiler firstly, and what I/O subsystem. Are you using highmem,
did you build from a clean tree ?

I also think your report is unrelated to the reiserfs one. 2.4.18 proper
and -ac have a small reiserfs fix which is a viable candidate for 
reiserfs funnies while what you report is somewhat different


The actual differences between 2.4.18-rc2-ac2 and 2.4.18-ac2 that are not
in 2.4.18 are:

Maybe a candidate
	shared memory filesystem fixes (also used for sys5 shm
		and anonymous shared maps)
		[copy mm/shmem.c from the working -ac to the current -ac 
		 and retest]
	Small pnpbios update (only relevant if building with PNPBIOS)
		[Build without PNPbios and retest]

Wildly improbable
	Correct NULL check in the sd scsi code
	open fix for ps2 driver

Hw specific (check your hardware and config and you can rule these out I guess)
	JFS specific fixes
	A sparc64 specific compile fix
	An off by one fix for loop that only affects using a specific
		option with maxloop=256
	Patches that only impact users of nbd
	An AMD ELan specific driver for watchdog - no affect on others
	Locking fixes for the softdog driver
	A serverworks specific ide=nodma fix
	LS220 experimental code (which shouldnt be enabled or matter)
	Tiny tweaks to the margi DVD card driver
	Ifdef of two lines specific to promise sx6000 raid
	3c359 token ring driver (doesnt touch generic code)
	olypmic token ring specific locking change
	netrom specific fixes

Alan
