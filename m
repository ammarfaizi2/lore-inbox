Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSANEmW>; Sun, 13 Jan 2002 23:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSANEmE>; Sun, 13 Jan 2002 23:42:04 -0500
Received: from mtiwmhc24.worldnet.att.net ([204.127.131.49]:35735 "EHLO
	mtiwmhc24.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S288748AbSANElr>; Sun, 13 Jan 2002 23:41:47 -0500
Message-Id: <5.1.0.14.0.20020113212754.00a686a0@postoffice.att.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 13 Jan 2002 21:40:34 -0700
To: linux-kernel@vger.kernel.org
From: "Larry W. Finger" <Larry.Finger@lwfinger.net>
Subject: PROBLEM: kernel 2.4.17 unable to mount root fs when initial
  ram disk size set to 0 with LILO
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have detected a problem. When kernel 2.4.17 is configured with a 4096K 
initial ram disk, but the ramsize = 0 parameter is specified in lilo.conf, 
the system is unable to boot due to the following set of events:
    a) In routine rd_load_image, line 660 of file linux/drivers/block/rd.c, 
nblocks is 0 at
       line 710. Next, the call to crd_load returns 0 and control transfers 
to label
       successful_load, where ROOT_DEV is changed to 01:00 from the initial 
value (03:03 on
       my system).
    b) In routine mount_root in file linux/fs/super.c, control proceeds to 
the "for (p =
       fs_names" loop at line 1039. Of course, none of the configured file 
types has a
       root fs at 01:00, and the loop falls through to the panic statement 
at line 1049 with
       the message "VFS: Unable to mount root fs on 01:00".
    c) If lilo.conf contains the statement "ramdisk = 100" rather than 
"ramdisk = 0", the system
       boots normally.

Kernel version 2.4.16, with the same configuration, boots normally with 
"ramdisk = 0".

Thank you,

Larry
--
Larry W. Finger                     Larry.Finger@lwfinger.net
1400 Colorado St.	             Phone: +1 (240) 463-2051
Boulder City, NV 89005              FAX:   +1 (209) 844-9855

http://www.lwfinger.net/ 

