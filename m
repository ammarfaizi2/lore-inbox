Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRJMXqF>; Sat, 13 Oct 2001 19:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRJMXpq>; Sat, 13 Oct 2001 19:45:46 -0400
Received: from cogito.cam.org ([198.168.100.2]:46344 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S271714AbRJMXpk>;
	Sat, 13 Oct 2001 19:45:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: mount hanging 2.4.12 
Date: Sat, 13 Oct 2001 19:41:20 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011013234121.31B3B24D64@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With kernel 2.4.12 I am having problems with mount hanging.

oscar% mount /fuji
oscar% cd /fuji
oscar% ls
dcim
oscar% cd
oscar% umount /fuji
oscar% mount /fuji
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems
oscar% mount /fuji

and ps shows 

oscar% ps -efl | grep mount
100 D root       876   793  0  69   0 -   368 down   19:28 pts/1    00:00:00 mount /fuji
000 S ed         943   886  0  71   0 -   341 pipe_w 19:31 pts/2    00:00:00 grep mount

With 2.4.10 and below I would get the wrong fs message too.  The next mount would
work.  One interesting thing.  The second mount will work if the media has not 
changed...

mount /fuji
umount /fuji
mount /fuji

will work but

mount /fuji
umount /fuji
<change media>
mount /fuji

hangs.

kern.log shows:

Oct 13 19:28:31 oscar kernel: usb-uhci.c: interrupt, status 2, frame# 1147
Oct 13 19:28:31 oscar kernel:  I/O error: dev 08:01, sector 0
Oct 13 19:28:31 oscar kernel: FAT: unable to read boot sector
Oct 13 19:28:31 oscar kernel: VFS: Disk change detected on device sd(8,1)
Oct 13 19:28:31 oscar kernel: SCSI device sda: 131072 512-byte hdwr sectors (67 MB)
Oct 13 19:28:31 oscar kernel: sda: Write Protect is on
Oct 13 19:28:31 oscar kernel:  sda: sda1

The device is a usb smartmedia reader using the sddr-09 support.

TIA
Ed Tomlinson

