Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbRCADir>; Wed, 28 Feb 2001 22:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRCADih>; Wed, 28 Feb 2001 22:38:37 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:16798 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129473AbRCADiX>; Wed, 28 Feb 2001 22:38:23 -0500
Message-ID: <3A9DC318.F4B3B95B@coplanar.net>
Date: Wed, 28 Feb 2001 22:33:44 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>,
        Per Erik Stendahl <PerErik@onedial.se>, linux-kernel@vger.kernel.org
Subject: Re: Unmounting and ejecting the root fs on shutdown.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Balazic wrote:

  Per Erik Stendahl wrote :

  > What I do know now is how to make the kernel not lock the CD in the
  > first place. Simply ioctl(/dev/cdrom, CDROM_CLEAR_OPTIONS, CDO_LOCK)

  > from /linuxrc in the initrd. This way I can remove the CD anytime
  > I please which is enough for me. And I dont have to patch the
kernel.

  Or : echo 0 > /proc/sys/dev/cdrom/lock
  ( I am not sure if this is the right filename )

  Or run magicdev ;-)


This might save everyone some pain:
from hdparm(8) man page (mine has some format
bugs, but you get the picture)

-L     Set  the  drive's  doorlock  flag.  Setting this to
              will lock the door  mechanism  of  some  removeable
              hard drives (eg. Syquest, ZIP, Jazz..), and setting
              it to maintains the door locking mechanism automat­
              ically, depending on drive usage (locked whenever a
              filesystem is mounted).  But  on  system  shutdown,
              this  can be a nuisance if the root partition is on
              a removeable disk, since the root partition is left
              mounted  (read-only)  after shutdown.  So, by using
              this command to unlock the door -b after  the  root
              filesystem  is  remounted  read-only,  one can then
              remove the cartridge from the drive after shutdown.


  you seem to be into reading the source (tm) so hdparm's
might be a good place to look (if it doesn't just work like it
says above)

