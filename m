Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281415AbRKTWKG>; Tue, 20 Nov 2001 17:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKTWJ4>; Tue, 20 Nov 2001 17:09:56 -0500
Received: from pD951891E.dip.t-dialin.net ([217.81.137.30]:6016 "EHLO charon")
	by vger.kernel.org with ESMTP id <S281415AbRKTWJu>;
	Tue, 20 Nov 2001 17:09:50 -0500
Date: Tue, 20 Nov 2001 23:09:42 +0100
From: Andre Bouillet <Andre.Bouillet@web.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel error during "umount" on ext3 with 2.4.15-pre7
Message-ID: <20011120230942.A540@charon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following error from the kernel:

Unable to handle kernel paging request at virtual address 4bbdc8fd
printing eip:
c0113534
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[add_wait_queue_exclusive+28/36]    Tainted: P EFLAGS: 
00010096
eax: d76512a0   ebx: 4bbdc8fd   ecx: 00000202   edx: c1cebe68
esi: c1cebe60   edi: c1cea000   ebp: cd1d04d0   esp: c1cebe48
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 7461, stackpage=c1ceb000)
Stack: d7651294 c1cebe60 c0105949 c13532c0 00000000 00000000 00000001 
c1cea000          d76512a0 4bbdc8fd c0105aa8 d7651294 00000000 d7651200 
c01d26f5 c13532c0          00000000 00000000 cd1d04d0 ce271f18 00000001 
c01126b0 c014cd12 d7651200 Call Trace: [__down+65/156] 
[__down_failed+8/12] [stext_lock+4133/10892] [schedule+548/852] 
[ext3_flushpage+34/40] charon kernel:    [do_flushpage+25/44] 
[truncate_complete_page+19/72] [truncate_list_pages+254/352] 
[truncate_inode_pages+67/108] [dispose_list+50/84] 
[invalidate_inodes+91/104] [kill_super+167/316] [__mntput+30/36] 
[path_release+39/44] [sys_umount+167/180] [sys_munmap+53/84] 
[sys_oldumount+12/16] [system_call+51/56] Code: 89 13 51 9d 5b 5e c3 90 
9c 58 fa 8b 4a 0c 8b 52 08 89 4a 04 
This error occured during the execution of the "umount" command from 
the following script:

#!/bin/sh
LIST="bin boot dev etc lib opt root sbin usr var"
mount /backup
# System Backup
for d in $LIST; do
    /usr/bin/rsync -ax --delete /$d/ /backup/$d/
done
# Home Backup
/usr/bin/rsync -ax --delete --exclude-from=/etc/rsync/exclude /home/ 
/backup/home/
umount /backup

My fstab looks like:

/dev/hda5       /               ext3    defaults,errors=remount-ro      
0       1
/dev/hda6       none            swap    sw                              
0       0
proc            /proc           proc    defaults                        
0       0
/dev/fd0        /floppy         auto    defaults,user,noauto            
0       0
/dev/hdd        /cdrom          iso9660 defaults,ro,user,noauto         
0       0
/dev/scd0       /cdrw           iso9660 defaults,ro,user,noauto         
0       0
/dev/hda1       /boot           ext3    rw                              
0       2
/dev/hdb1       /backup         ext3    rw,noauto                       
0       2
