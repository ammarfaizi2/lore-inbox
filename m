Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRKMRaX>; Tue, 13 Nov 2001 12:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKMRaN>; Tue, 13 Nov 2001 12:30:13 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:8224 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S276094AbRKMRaD>; Tue, 13 Nov 2001 12:30:03 -0500
From: joeja@mindspring.com
Date: Tue, 13 Nov 2001 12:26:22 -0500
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.4.9 to 2.4.14 bug & workaround
Message-ID: <Springmail.105.1005672382.0.20999700@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it were just a case of mount complainig about partitions or something I could live with that, but it is not.  

If the partition is bad it should not mount it.  Plain and simple and it should compain. The fact is that it does mount it.  

If it was really mounted read only, cp should fail, rather than trying to cp to the drive and complain 'could not copy'.  

If I do a kill -9 on the process ID of cp, cp should die.  It does not.  EVER.  Instead the console starts to fill up with messages about hdd.  I'll see if I can get the exact message.

If I try to shut down the system it does not.  It kills all processes except for the zip drive, then I see the console fill and scroll (super fast) with hdd messages.

So who is the maintainer of the ide-floppy as that is what I am using.  

Joe 

(reformatted quote to heed line length provisions)
> I have an internal iomega 'type' (not iomega) IDE zip drive.  It
> mounts as /dev/hdd instead of /dev/hdd4.  Mounting as /dev/hdd seems
> okay.
> 
> Mounting as /dev/hdd4 will hang my kernel( 2.4.9-2.4.14).  I have read
> that on some MB you can change the bios to none for the ide device and
> this works on certain mb.  I tried this and it did not change
> anything.

Well, all this depends on how the media has been formatted. From what I
heard (I have no exchangable drives since I sold my SyQuest crap), some
ZIP (presumably) media are partitioned and have their fourth partition
formatted, giving your data as /dev/hdd4 or /dev/sdb4 or something other
with 4 to the end. Then, the entire media might be formatted "raw" with
Linux, so you'd have to mount /dev/hdd instead.

The BIOS is only involved for booting and come APM or ACPI (power
saving) stuff, maybe also for VESA frame buffer stuff, but other than
that, its settings are partially read and the BIOS is no longer taken
into account.

Of course, a system hang is Not Nice[tm] and should be fixed by the
respective maintainers IF IT IS an actual bug. Please check the cabling
or use hdparm to use more conservative transfer modes before assuming
it's a bug with Linux -- a "cp" hang certainly warrants investigation.

OTOH, mount should not hang if you mount the wrong part of the disk, but
complain instead, however, I'm not sure if a bogus partition entry can
cause these hangs.

