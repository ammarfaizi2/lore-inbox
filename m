Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbRGMQ7V>; Fri, 13 Jul 2001 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRGMQ7M>; Fri, 13 Jul 2001 12:59:12 -0400
Received: from mail7.bigmailbox.com ([209.132.220.38]:61190 "EHLO
	mail7.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S267504AbRGMQ64>; Fri, 13 Jul 2001 12:58:56 -0400
Date: Fri, 13 Jul 2001 09:58:51 -0700
Message-Id: <200107131658.JAA07099@mail7.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.52.217]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: rickos@ifrance.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: compile and bootdisk problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date:      Fri, 13 Jul 2001 18:38:45 +0200
> Brunet Eric <rickos@ifrance.com> linux-kernel@vger.kernel.orgCC: eric.brunet@voila.fr
> compile and bootdisk problems
>Hello,
>
>i meet some problems in order to create a linux bootdisk:
>therefore, i tries to make a polyvalent kernel (in one floppy) with:
>-no module
>-a lot of ethernet card drivers
>This flopppy disk will be used to boot windows machine with partimage
>program in order to backup entire FS to a backup server!!
>
>The first, i couldn't compile the kernel with all ethernets card
>drivers, specially i have an errors for the drivers
>"CONFIG_ARM_AM79C961A" and "CONFIG_FEALNX" for kernels 2.4.3 and 2.4.6(i
>think others version too), is it normal??
>
>For "CONFIG_ARM_AM79C961A":
>am79c961a.c: In function `am79c961_init':
>am79c961a.c:638: `IRQ_EBSA110_ETHERNET' undeclared (first use in this
>function)
>am79c961a.c:638: (Each undeclared identifier is reported only once
>am79c961a.c:638: for each function it appears in.)
>make[3]: *** [am79c961a.o] Erreur 1
>make[2]: *** [first_rule] Erreur 2
>make[1]: *** [_subdir_net] Erreur 2
>make: *** [_dir_drivers] Erreur 2
>notice: the definition of IRQ_EBSA110_ETHERNET is in ./include/asm_arm
># define IRQ_EBSA110_ETHERNET   3
>I understand that device is supported only by arm architecure, it >don't compile because it's a x86 machine?? and if yes,why aren't >anywarning message to indicate me that drivers is useless????

Make sure you've run "make <whatever>config", saved a configuration, and then run "make dep".  If this doesn't help, talk to the driver's maintainer (look in /path/to/the/kernel/source/tree/MAINTAINERS).  Regarding the inclusion of a (maybe) useless driver: in the interest of keeping up code reuse, sometimes the kernel will compile in drivers that aren't needed -- call it an added bonus. 8-)

>-the other problem is in boot sequence, i prapre the kernel image for
>the rootdisk(it work with a Slackware bootdisk) like this:
>>   rdev bzImage /dev/fd0
>>   rdev -r bzImage 49152 (49152 = ask disk, and read from 0)
>>   rdev -R bzImage 0 (to make the root RW and allow to login)
>>  dd if=bzImage of=/dev/fd0 bs=1k
>
>howener then i insert root disk, 10 second oafter, i see this >message:
>>wrong magic

(I could be talking out my butt here and for the rest of my reply; I'd appreciate it if filesystem gurus would back me up... or not)  In every boot sector is written a "magic number".  This is unique for each filesystem type, and is used upon initial mount for partition type identification; apparently the wrong magic number was written to the disk.  (or none at all)

>>MSDOS: Harware sector size is 1024
>>fatfs: bogus cluster size
>>MSDOS: Harware sector size is 1024
>>fatfs: bogus cluster size
>>MSDOS: Harware sector size is 1024
>>fatfs: bogus cluster size
>>UMSDOS: msdos_read_super failed, mount aborted.
>>kernel panic: VFS: Unable to mount fs on 01:00
>

These are (probably) caused by an incorrect creation of the boot disk; the most foolproof way of making a boot disk at kernel compile-time is simply to run "make bzdisk" (assuming you want ext2 on the floppy).  If I'm wrong (and I frequently am; I'm merely a newbie with ambition), I'm sorry (read: don't flame me).


Colin Bayer <vogon_jeltz@users.sourceforge.net>
"Nothing's tweaked to the limit until it's broken.  The only good thing about Windows is that it comes like this out of the box."
fortytwo: Linux kernel 2.4.7-pre5 (i686; 1854.66 BogoMips)

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
