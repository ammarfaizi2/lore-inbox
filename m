Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVGBWIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVGBWIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVGBWIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:08:39 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:47085 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261309AbVGBWG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:06:57 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: CyberOptic <mail@cyberoptic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppa / parport zip-drive / kernel 2.6.12.2
Date: Sun, 03 Jul 2005 08:06:53 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <1a3ec1t4evi7dcops742493hv7vd9aijb5@4ax.com>
References: <42C6FD00.2060408@cyberoptic.de>
In-Reply-To: <42C6FD00.2060408@cyberoptic.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jul 2005 22:45:52 +0200, CyberOptic <mail@cyberoptic.de> wrote:
>
>Surely there is someone out there knowing a hint or solution? At least
>I´m hoping so.

Works for me:

root@pooh:~# mount /dev/sda4 /mnt/hd/
root@pooh:~# ls /mnt/hd/
1210sa~1.pdf*  aar121~1.pdf*  freedb~1.bz2*
root@pooh:~# umount /mnt/hd/
root@pooh:~# mount -t vfat /dev/sda4 /mnt/hd/
root@pooh:~# ls /mnt/hd/
1210SA_datasheet.pdf*  aar1210sa_ug.pdf*  freedb-update-20031102-20031201.tar.bz2*
root@pooh:~# umount /mnt/hd/
root@pooh:~# lsmod
Module                  Size  Used by
ppa                    10280  0
tulip                  45728  0
root@pooh:~# fdisk -l /dev/sda

Disk /dev/sda: 100 MB, 100663296 bytes
64 heads, 32 sectors/track, 96 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda4   *           1          96       98288    6  FAT16
root@pooh:~#

http://scatter.mine.nu/test/linux-2.6/pooh/ for setup, I added 
ppa to .config as module, make && make modules_install, 
modprobe ppa and it worked.  SCSI and parport compiled in.

--Grant.

