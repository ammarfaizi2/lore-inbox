Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbRCZRdN>; Mon, 26 Mar 2001 12:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRCZRcx>; Mon, 26 Mar 2001 12:32:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132471AbRCZRcs>;
	Mon, 26 Mar 2001 12:32:48 -0500
From: idalton@ferret.phonewave.net
Date: Sun, 25 Mar 2001 21:37:38 -0800
To: linux-kernel@vger.kernel.org
Subject: paride error, aparantly with VFS
Message-ID: <20010325213738.A18626@ferret.phonewave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I appear to have found a problem reading from paride hard disks under
2.4.2

Reading from the raw block devices seems to be fine.

# dd if=/dev/pd/disc0/disc of=/dev/null
works.

However, accessing partitions on the device through VFS by mounting them
hangs the machine.

With vfat and msdos partitions: 
# mount -t (vfat|msdos) /dev/pd/disc0/part1 /mnt
and then
# cat /mnt/* > /dev/null
or
# dd if=/mnt/drvspace.000 of=/dev/null

I eventually see the following error message, and all logins are
unresponsive. I can reboot with SysRq.

do_pd_read_drq: status = 0x10050 = SEEK READY TMO

Doing a similar test with an ext2 fs on the drive:

do_pd_read_drq: status = 0x10052 = SEEK READY TMO

Changing parallel port mode in the BIOS does not make any difference.

The paride controller is a Shuttle EPAT plus. The parallel port is an
Intel 82371AB (I think)

-- Ferret
