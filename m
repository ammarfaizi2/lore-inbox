Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLGPi7>; Thu, 7 Dec 2000 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLGPit>; Thu, 7 Dec 2000 10:38:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6407 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129413AbQLGPie>;
	Thu, 7 Dec 2000 10:38:34 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012071503.eB7F3AS11880@flint.arm.linux.org.uk>
Subject: getcwd() returning -ENOENT???
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Dec 2000 15:03:10 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone explain why I'm seeing the following on test12-pre7:

bash# /bin/pwd
/bin/pwd: cannot get current directory: No such file or directory
bash# vdir /proc/self/.
...
lrwxrwxrwx    1 root     root           0 Dec  7 14:52 cwd -> /net/raistlin/raistlin-v2.4/linux-ebsa285 (deleted)
...
lrwxrwxrwx    1 root     root           0 Dec  7 14:52 root -> /
...
bash# vdir
... <complete listing of directory> ...
bash# cat /proc/mounts
/dev/root / ext2 rw,noatime 0 0
/proc /proc proc rw 0 0
/dev/hda3 /var ext2 rw,nodiratime 0 0
/dev/hda5 /usr ext2 rw,noatime 0 0
/dev/hda6 /home ext2 rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm shm rw 0 0
automount(pid482) /net/flint autofs rw 0 0
automount(pid499) /net/raistlin autofs rw 0 0
raistlin:/usr/src/v2.4 /net/raistlin/raistlin-v2.4 nfs rw,v2,rsize=4096,wsize=4096,hard,udp,lock,addr=raistlin 0 0

Rebooting the machine and trying again caused this weirdness to disappear.

First time around, the network wasn't initially available when autofs
started.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
