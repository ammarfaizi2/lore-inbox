Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGRaG>; Wed, 7 Feb 2001 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGR35>; Wed, 7 Feb 2001 12:29:57 -0500
Received: from [216.29.39.226] ([216.29.39.226]:5380 "HELO
	mail.acetechnologies.net") by vger.kernel.org with SMTP
	id <S129032AbRBGR3l>; Wed, 7 Feb 2001 12:29:41 -0500
Subject: reiserfs - problems mounting after power outage
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Feb 2001 12:31:43 -0500 (EST)
Cc: Jeff.McWilliams@acetechnologies.net
Reply-To: Jeff.McWilliams@acetechnologies.net
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010207173143.7AC5E1805F@mail.acetechnologies.net>
From: Jeff.McWilliams@acetechnologies.net (Jeff McWilliams)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having difficulty mounting a reiserfs partition after a power outage.

This is 2.4.0-test9 compiled with reiserfs as a module, and 
the ide.2.4.0-t9-6.task.0923.path IDE patch - mostly to get updated support for
the 3WARE IDE RAID controller.  

/dev/sda is the 3ware escalade raid mirror - two Maxtor 20 gig drives.

reiserfs is compiled as a module, the distribution is Debian Linux 
"Potato"

uname -a shows:
Linux ns2 2.4.0-test9 #1 Wed Dec 6 16:28:45 EST 2000 i586 unknown

/etc/fstab shows:

# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>                       <dump> <pass>
/dev/sda1       /               ext2    defaults,errors=remount-ro      0      1
/dev/sda5       none            swap    sw                      0       0
proc            /proc           proc    defaults                        0      0
/dev/sda6       /var/www        reiserfs defaults 0 0
/dev/sda7       /home           reiserfs defaults,noauto 0 0
/dev/fd0        /floppy         auto    defaults,user,noauto            0      0
/dev/cdrom      /cdrom          iso9660 defaults,ro,user,noauto         0      0


The partition I'm having trouble with is /dev/sda7.  /dev/sda6 recovered okay.
/dev/sda7 doesn't have a lot of data on it, and I CAN deal with the lost data,
but it doesn't leave me with a very good feeling of confidence in reiserfs
if I can't successfully recover from a power failure.


What happens when I type mount /dev/sda7 is this:

reiserfs: using 3.5.x disk format
reiserfs: checking transaction log (device 08:07) ...

and then it hangs.  I then have to hit the reset button to reboot.

I've tried running reiserfsck with --check, --correct-bitmap, 
--rebuild-sb, and --rebuild-tree.  NO luck there.

debugreiserfs /dev/sda7 shows:

<-------------debugreiserfs, 2000------------->
reiserfsprogs 3.x
Super block of format 3.5 found on the 0x3 in block 16
Block count 2405720
Blocksize 4096
Free blocks 2397152
Busy blocks (skipped 16, bitmaps - 74, journal blocks - 8193
1 super blocks, 284 data blocks
Root block 8212
Journal block (first) 18
Journal dev 0
Journal orig size 8192
Filesystem state ERROR
Tree height 2
Hash function used to sort names: tea hash

Any help?  Please cc Jeff.McWilliams@acetechnologies.net

Thanks,

Jeff McWilliams
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
