Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293628AbSCERfP>; Tue, 5 Mar 2002 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293637AbSCERfG>; Tue, 5 Mar 2002 12:35:06 -0500
Received: from web14604.mail.yahoo.com ([216.136.224.84]:32270 "HELO
	web14604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293628AbSCERez>; Tue, 5 Mar 2002 12:34:55 -0500
Message-ID: <20020305173454.67635.qmail@web14604.mail.yahoo.com>
Date: Tue, 5 Mar 2002 09:34:54 -0800 (PST)
From: Chr H-N <chn65@yahoo.com>
Subject: Kernel hangs after "Loading Linux ...." but before "Uncompressing Linux"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject      : Kernel hangs after "Loading Linux ...."
but before "Uncompressing Linux"
CC reply to  : chn65@yahoo.com
Scenario     : Building a RAMDISK for linux root file
system.

I want to boot up a Linux kernel with an initial
ramdisk and root=/dev/ram0.
It works fine ... in most cases.

As I change the contents of the RAMDISK and try with
new ones, I sometimes get stuck in the booting phase:
It hangs after writing "Loading Linux" and a varying
number of dots. It does not display "Uncompressing
Linux".

I use the same kernel all the time.
I only change the contents of my ramdisk.gz file and
run lilo.

--------------------------------------------
My lilo entry looks like this:

image=/boot/vmlinuz-2.4.18
        label=RAM_disk
        initrd=/boot/ramdisk.gz
        root=/dev/ram0
        vga=1

Yes I have initrd support in the kernel, and gave it
256M to play with. My machine has 768M.
I want a ramdisk of some hundred megs to get optimum
speed. It is realistic after all.

And the hard disk file system I have /boot/ on is also
below cyl 1024:

Disk /dev/hde: 255 heads, 63 sectors, 7476 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id 
System
/dev/hde1             1       709   5695011   83 
Linux

--------------------------------------------

Can there be a problem when the size of the ramdisk
gets too big?
I tried this:

Having a working version:
Zipped size = 9769185 bytes


The same version adding linux-2.4.18.tar.gz (approx 30
megs) to the ramdisk:
Not working! It writes almost two lines of dots before
it stops and does no more.
Zipped size = 39899378 bytes

As I see it, I have a working RAM disk image.
Then I add one big file, and it breaks the boot.
Strange from an end-user's point of view ...

I even tried the following:
Copy the /etc/termcap file over the /boot/ramdisk.gz
file, so the contents is invalid.
This has the expected result that the kernel boots but
complains about the disk.

Now for a systematic test:
dd if=/dev/zero of=/boot/ramdisk.gz bs=1024
count=variable number
run lilo afterwards every time

15 MB ramdisk boots but complains about not possible
to mount root
31 MB ramdisk (all zeroes) writes almost four lines of
dots after "Loading ...", and then reboots!
A valid zip file instead of the /dev/zero-based one
(trying the 30MB linux-2.4.18.tar.gz) as the ram disk
image - hangs after almost four lines of dots.
I understand that these files would never be valid RAM
disk images, I only used them for testing if size has
anything to do with it. And it has, it seems.

--------------------------------------------

The kernel never gets to check the root file system
(it never gets uncompressed).
All lilo entries use the same kernel, only the RAM
disk entry has problems, the others work fine.

The kernel is compiled with the "make dep clean
install modules modules_install" command.
The kernel options are the ones I "always" use.
I have seen this with other kernel versions too.

Thus 
- the contents and validity of the ramdisk doesn't
matter - unless it is checked by the loader (not
likely).
- it is not a kernel version problem.
- it seems that size does matter.


I have noticed that there were previous threads about
this issue, so it must be a known problem.

Kind regards
Christian Hildebrandt-Nielsen


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
