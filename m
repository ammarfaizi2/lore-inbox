Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276836AbRJNS6D>; Sun, 14 Oct 2001 14:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276877AbRJNS5x>; Sun, 14 Oct 2001 14:57:53 -0400
Received: from [212.162.12.2] ([212.162.12.2]:38824 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id <S276836AbRJNS5l>;
	Sun, 14 Oct 2001 14:57:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gietl <a.gietl@e-admin.de>
To: linux-kernel@vger.kernel.org
Subject: fs mounted twice, writing to wrong partition with 3ware escalade ide-raid
Date: Sun, 14 Oct 2001 20:57:59 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "=?iso-8859-1?q?Kr=E4mer?=" <kraemer@crasu.de>,
        "=?iso-8859-1?q?K=FChne?=" <kuehne@power-netz.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15sqSI-0008P9-00@d101.x-mailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've got a problem on our new SMP machine with IDE-Raid and kernel 2.4.9 
that's giving me a terrible headache.

Our configuration:

2 WD drives in the raid1 array
1 Maxtor drive on normal ide

mystery #1:

I can mount a ext2 filesystem twice without any errors. The two filesystems 
contain different data and changes to the second mount don't affect the 
first mount. Strange!

Here is a snippet from console with /dev/sda5 mounted twice:

/dev/sda5 / ext2 rw,usrquota,grpquota 0 0
none /proc proc rw 0 0
/dev/sda7 /opt/root ext2 rw,usrquota,grpquota 0 0
/dev/sda6 /var ext2 rw,usrquota,grpquota 0 0
/dev/sda1 /boot ext2 rw 0 0
none /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/sda5 /mnt ext2 rw 0 0

a strace on the mount command shows that the syscall mount is executed w/o 
error.

mount("/dev/sda5", "/mnt/", "ext2", 0xc0ed0000, 0) = 0  

As far as i know it should return EBUSY on a fs that is already mounted.

Second mystery:

the mounted /dev/hda3 contains the same data as /dev/sda5 and changes to one 
of them affect both partitions.

I'm not sure wether this is a kernel issue or a escalade firmware issue but 
perhaps one of you had that problem too and knows a solution.

Thank you

andreas




-- 
e-admin internet gmbh
Andreas Gietl
Roter-Brach-Weg 124a
tel +49 941 3810884
fax +49 941 3810891
mobil +49 171 6070008
