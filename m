Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSKDAlO>; Sun, 3 Nov 2002 19:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSKDAlO>; Sun, 3 Nov 2002 19:41:14 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5841 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264010AbSKDAlM>; Sun, 3 Nov 2002 19:41:12 -0500
Message-ID: <3DC5C3A9.3060608@nortelnetworks.com>
Date: Sun, 03 Nov 2002 19:47:37 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE BUG REPORT: 2.5.45 killed my / partition
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


duron, kt133 motherboard, ide disks, new clean mandrake 9 install with 
ext3, running fine over several boots

Yesterday I compiled 2.5.45 after working around some build glitches, 
booted fine and ran it for several hours.  I just turned on your basic 
generic IDE stuff and the VIA ide controllers, nothing fancy or (at 
least so I thought) dangerous.

Today I booted but it wouldn't let me log in as normal user (error 
message flashed too quickly for me to be able to read it, looked like it 
began with "critical") but I could log in as root so I did.  I poked 
around and didn't see anything odd, so I went to reboot onto the 
mandrake kernel.

I boot up, and it gets to the point where it checks the root filesystem 
and it halts with an error:

Checking root filesystem
fsck.ext3/dev/hdb9:
The superblock could not be read or does not describe a correct ext2 
filesystem. If the device is valid and it really contains an ext2 
filesystem (and not swap or ufs or something else), then the superblock 
is corrupt, and you might try running e2fsck with an alternate superblock:
      e2fsck -b 8193 <device>

: No such file or directory while trying to open /dev/hdb9
Failed to check filesystem.  Do you want to repair the errors? (Y/N)
(beware, you can lose data)


A bit worried, I rebooted with the rescue disk and ran fsck.ext3, which 
found a bunch of errors that I told it to clean.  Still on my rescue 
kernel/ramdisk I mounted the filesystem and tried listing a few files 
and everything was fine.  I then rebooted and the boot-time fsck gave me 
the same error as above.

I thought that 2.5.45 wasn't supposed to have ide problems like this 
anymore...

Anyways, the only thing left that I can see is to re-install--anyone 
else have a better idea?  I'll hold off on doing that for a few days in 
case someone wants more information on the system.

Any ideas why the rescue fsck passes but boot-time fails?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

