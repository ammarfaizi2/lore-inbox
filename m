Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRCAIwG>; Thu, 1 Mar 2001 03:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRCAIvv>; Thu, 1 Mar 2001 03:51:51 -0500
Received: from [138.6.98.137] ([138.6.98.137]:26131 "EHLO
	caspian.prebus.uppsala.se") by vger.kernel.org with ESMTP
	id <S129550AbRCAIvd> convert rfc822-to-8bit; Thu, 1 Mar 2001 03:51:33 -0500
Message-ID: <E44E649C7AA1D311B16D0008C73304460933B6@caspian.prebus.uppsala.se>
From: Per Erik Stendahl <PerErik@onedial.se>
To: "'Jeremy Jackson'" <jerj@coplanar.net>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Unmounting and ejecting the root fs on shutdown.
Date: Thu, 1 Mar 2001 09:47:51 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   > What I do know now is how to make the kernel not lock the 
> CD in the
>   > first place. Simply ioctl(/dev/cdrom, 
> CDROM_CLEAR_OPTIONS, CDO_LOCK)
> 
>   > from /linuxrc in the initrd. This way I can remove the CD anytime
>   > I please which is enough for me. And I dont have to patch the
> kernel.
> 
>   Or : echo 0 > /proc/sys/dev/cdrom/lock
>   ( I am not sure if this is the right filename )

Nah, that looks too easy! ;-)

> This might save everyone some pain:
> from hdparm(8) man page (mine has some format
> bugs, but you get the picture)
> 
> -L     Set  the  drive's  doorlock  flag.  Setting this to
>               will lock the door  mechanism  of  some  removeable
>               hard drives (eg. Syquest, ZIP, Jazz..), and setting
>               it to maintains the door locking mechanism automat­
>               ically, depending on drive usage (locked whenever a
>               filesystem is mounted).  But  on  system  shutdown,
>               this  can be a nuisance if the root partition is on
>               a removeable disk, since the root partition is left
>               mounted  (read-only)  after shutdown.  So, by using
>               this command to unlock the door -b after  the  root
>               filesystem  is  remounted  read-only,  one can then
>               remove the cartridge from the drive after shutdown.

Is it true that the root fs is left mounted read-only? What is the
rationale behind this? It seems to me that it would be better to
completely unmount it and do whatever cleaning up is required (like
cdrom_release()?). But I've been known to miss important issues before!
:-)

BTW, what would be the best way to determine which devices are cdrom
devices? Looks like /proc/sys/dev/cdrom/info could be of use but what
happens on a computer with more than one cdrom device?

Cheers
/Per Erik Stendahl
