Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317917AbSFNOOm>; Fri, 14 Jun 2002 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317918AbSFNOOl>; Fri, 14 Jun 2002 10:14:41 -0400
Received: from host194.steeleye.com ([216.33.1.194]:46859 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317917AbSFNOOl>; Fri, 14 Jun 2002 10:14:41 -0400
Message-Id: <200206141414.g5EEEci22528@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andrey Panin <pazke@orbita1.ru>
Cc: Dave Jones <davej@suse.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager 
 (3/4/5xxx series)
In-Reply-To: Message from Andrey Panin <pazke@orbita1.ru> 
   of "Fri, 14 Jun 2002 17:52:29 +0400." <20020614135229.GA313@pazke.ipt> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Jun 2002 10:14:38 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pazke@orbita1.ru said:
> IMHO Voyagers are too old and big machines to get (working) APM, and
> visws have no BIOS or limited BIOS emulation. 

That depends what you mean by `apm'.  In kernel/apm.c, it's tied to the 
existence of the APM bios and since voyagers have no bios per say (they 
actually have a SUS, which is an actively running boot OS on a tiny i386 
processor which can emulate a minimal PC bios when in PC mode) then you're 
correct.

Running Linux on a voyager, I can power off the machine, read the internal 
power source, the status of the front panel switch and even trigger a power 
management shutdown after the AC power is lost for a certain length of time 
(voyagers usually have internal lead acid batteries).  The way it's currently 
set up, if I turn off the front panel switch, the machine will execute a clean 
shutdown and power itself off when the shutdown is finished.  (this is mainly 
done in the voyager_thread.c file, where it keeps a kernel daemon permanently 
monitoring the machine status, if you're interested).

The above are all traditional APM functions, I just don't need apm.c to do 
them.

However, apm.c is still in arch/i386/kernel, just in case, so I think 
mpparse.c should join it, and we should keep all the other pieces (bootflag.c 
and acpi.c) in there just in case.

James


