Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRFRND0>; Mon, 18 Jun 2001 09:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRFRNDQ>; Mon, 18 Jun 2001 09:03:16 -0400
Received: from c012-h012.c012.sfo.cp.net ([209.228.13.212]:59313 "HELO
	c012.sfo.cp.net") by vger.kernel.org with SMTP id <S262076AbRFRNDD>;
	Mon, 18 Jun 2001 09:03:03 -0400
Date: 18 Jun 2001 06:03:02 -0700
Message-ID: <20010618130302.15892.cpmta@c012.sfo.cp.net>
X-Sent: 18 Jun 2001 13:03:02 GMT
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Ralph Jones <ralph.jones@altavista.com>
X-Mailer: Web Mail 3.9.3.1
Subject: pivot_root from non-interactive script
X-Sent-From: ralph.jones@altavista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have followed the instructions given in Documentation/initrd.txt with regard to pivot_root, but am unable to unmount the filesystem, when everything is called from a non-interactive script. 

ie. When I set a link from linuxrc to /bin/ash and then manually go through the commands in the shell script, I am able to unmount the old initrd filesystem.  However, when linuxrc is a shell script containing the same commands, I am unable to umount the old initrd fs.  I get instead: "Device or resource busy".

The contents of my linuxrc script are as follows:
--------------------
#!/bin/ash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
 
cd /
mkdir /new
mount -t shm /dev/shm /new
cp -pdR * new
 
cd new
pivot_root . initrd
 
cd /
exec chroot . /bin/ash <dev/console > dev/console 2>&1
-------------
ash is a static binary.  chroot, mount and pivot_root are from busybox.  

- Ralph Jones

Find the best deals on the web at AltaVista Shopping!
http://www.shopping.altavista.com
