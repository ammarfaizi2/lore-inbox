Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSHBOvA>; Fri, 2 Aug 2002 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSHBOvA>; Fri, 2 Aug 2002 10:51:00 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:65336 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S314835AbSHBOu7>; Fri, 2 Aug 2002 10:50:59 -0400
Date: Fri, 2 Aug 2002 09:54:29 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208021454.JAA37529@tomcat.admin.navo.hpc.mil>
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen):
...
> As for finding where to boot from - either have the bootloader define a  
> partition name it wants to see, or put the relevant name into the boot  
> loader config. No need to define that in the partition format. That's  
> trivial: even MS-DOS did that (finding IO.SYS and MSDOS.SYS from the boot  
> loader)! And neither scanning for '=' and '\n' nor comparing one string  
> nor converting one number from decimal is any kind of hardship. Maybe half  
> a screen of assembler, tops.
> 

Nope.

The problem is different - which file system is the file stored in?
How many different filesystems are there?
Do think all of them will fit in a boot loader?
Or even one of them?
How many different logical volume structures are there?

Do do this you first have to convince the development people to say that
"only xxxx filesystem shall be bootable".

Very unlikely.

And now, you also have to add possible logical volumes on top (or under :)
of it.

Even more unlikely.

That is why LILO doesn't use file names for boots. It only uses block
numbers.

Another alternative (possibly just as hard) is to have LILO only
load a more complex and dynamic loader, which could be configured for
each filesystem structure. Once that "dynamic loader" is loaded, it
could find and load the kernel (passing, of course, the boot command line
from LILO).

I know IRIX gets around the problem by having a tiny filesystem for the
"disk label". This filesystem contains only contigeous files, and has
references to the drive partition table, the complex boot program (sash -
stand alone shell), optional diagnostic boot, and logical volume mebership -
one reference per logical volume type and partition .. I think it is
	<lvm type>.<partitionnumber>
The contents of the file is volume name followed by the order of the partition
in the lvm (section 1, 2, 3, ..).

And this is not a "mountable" file system. It is only accessed via special
utilities (like the "mtools" set for non-mounted M$DOS floppies)

At least, I remember IRIX this way - it should be close.

SunOS had something a little different: the initial boot (at the bios level)
use block numbers to locate a "boot" utility. The "boot" utility knew about
the filesystem type. I think it was a link of the boot object with a fs
utility library, where the library was selected by a "makeboot" command
and by the filesystem type that the kernel(s) was(were) stored on. The
"makeboot" utility modified/replace the "boot" program, then set the
block numbers in the boot sector.

All of this has truly horrible effects on boot times though. At a minimum
I would expect it to take twice as long.

You pay for the additional flexibility though.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
