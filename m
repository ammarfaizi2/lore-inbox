Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJEMIN>; Sat, 5 Oct 2002 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262315AbSJEMIN>; Sat, 5 Oct 2002 08:08:13 -0400
Received: from transport.cksoft.de ([62.111.66.27]:43784 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262003AbSJEMIL>; Sat, 5 Oct 2002 08:08:11 -0400
Date: Sat, 5 Oct 2002 12:02:04 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Subject: SCSI st tape wrong minor in 2.5.40 with devfs
Message-ID: <Pine.BSF.4.44.0210051147090.39858-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see a problem with recent 2.5 kernels and SCSI st and devfs.

As you can see from the output down under the minors are off by 4.

I rechecked that 9,128 (as described in Documentation/devices.txt)
would be correct for nst0 by calling mknod and *tata* the backup
would be running fine again (at least mt is working again - not
running a backup...).

So minors should be the number of the tape device and not
the number of the target counting from 0.


This is what it used to be:

bz@megablast:/dev/scsi/host0/bus0/target5/lun0> ls -l
total 0
crw-r-----    1 root     root      21,   3 Jan  1  1970 generic
crw-rw-rw-    1 root     root       9,   0 Jan  1  1970 mt
crw-rw-rw-    1 root     root       9,  96 Jan  1  1970 mta
crw-rw-rw-    1 root     root       9, 224 Jan  1  1970 mtan
crw-rw-rw-    1 root     root       9,  32 Jan  1  1970 mtl
crw-rw-rw-    1 root     root       9, 160 Jan  1  1970 mtln
crw-rw-rw-    1 root     root       9,  64 Jan  1  1970 mtm
crw-rw-rw-    1 root     root       9, 192 Jan  1  1970 mtmn
crw-rw-rw-    1 root     root       9, 128 Jan  1  1970 mtn
bz@megablast:/> uname -a
Linux megablast 2.5.38 #57 SMP Wed Sep 25 17:38:37 UTC 2002 i686 unknown
[this was bk checkout from 20020923-211332 UTC]



this is what I get with latest 2.5.40-bk:

/dev/{nst0 resp nst4}: No such device or address

bz@megablast:/dev/scsi/host0/bus0/target5/lun0> ls -l
total 0
crw-r-----    1 root     root      21,   3 Jan  1  1970 generic
crw-rw-rw-    1 root     root       9,   4 Jan  1  1970 mt
crw-rw-rw-    1 root     root       9, 100 Jan  1  1970 mta
crw-rw-rw-    1 root     root       9, 228 Jan  1  1970 mtan
crw-rw-rw-    1 root     root       9,  36 Jan  1  1970 mtl
crw-rw-rw-    1 root     root       9, 164 Jan  1  1970 mtln
crw-rw-rw-    1 root     root       9,  68 Jan  1  1970 mtm
crw-rw-rw-    1 root     root       9, 196 Jan  1  1970 mtmn
crw-rw-rw-    1 root     root       9, 132 Jan  1  1970 mtn
bz@megablast:/dev/scsi/host0/bus0/target5/lun0> uname -a
Linux megablast 2.5.40 #77 SMP Sat Oct 5 07:43:57 UTC 2002 i686 unknown
[bk-2.5 checkout, 20021005-060333 UTC]

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

