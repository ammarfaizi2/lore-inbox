Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSHDQgi>; Sun, 4 Aug 2002 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSHDQgi>; Sun, 4 Aug 2002 12:36:38 -0400
Received: from RJ226062.user.veloxzone.com.br ([200.165.226.62]:18048 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317984AbSHDQgh>; Sun, 4 Aug 2002 12:36:37 -0400
Subject: Bug at page_alloc.c:183
From: Victor Bogado da Silva Lins <victor@bogado.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Aug 2002 13:40:42 -0300
Message-Id: <1028479242.2599.28.camel@victor.bogado>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I get this error (maybe the source line changes a little). Every time I
try to compile garnome, I do get similar messages when I allow my system
to run for a long time. I was using the last updated kernel from RedHat
(2.4.18-5). I did installed the 2.4.19, witch I have compiled from the
source. 

The kernel BUG message that is in my log is the following: 

Aug  4 12:44:59 victor kernel: kernel BUG at page_alloc.c:183!
Aug  4 12:44:59 victor kernel: invalid operand: 0000
Aug  4 12:44:59 victor kernel: CPU:    0
Aug  4 12:44:59 victor kernel: EIP:    0010:[<c0130031>]    Tainted: P
Aug  4 12:44:59 victor kernel: EFLAGS: 00010086
Aug  4 12:44:59 victor kernel: eax: 0000007e   ebx: c10005f0   ecx: 00000000   edx: 0000001f
Aug  4 12:44:59 victor kernel: esi: c0283f00   edi: 00000001   ebp: 00000000   esp: c2a03ee0
Aug  4 12:44:59 victor kernel: ds: 0018   es: 0018   ss: 0018
Aug  4 12:44:59 victor kernel: Process tar (pid: 13453, stackpage=c2a03000)
Aug  4 12:44:59 victor kernel: Stack: 00000000 0000001f 00000282 00000000 c0283f00 c0284144 0000023f 00000000
Aug  4 12:44:59 victor kernel:        00000000 c01302ff c0283fb4 c028413c 000001d2 00000005 00000000 c1375588
Aug  4 12:44:59 victor kernel:        00000005 00000000 c012bbb5 c2a03f54 00001000 00000000 00001000 fffffff4
Aug  4 12:44:59 victor kernel: Call Trace:    [<c01302ff>] [<c012bbb5>] [<c013e28b>] [<c01364d5>] [<c0135f03>]
Aug  4 12:44:59 victor kernel:   [<c01088bb>]
Aug  4 12:44:59 victor kernel:
Aug  4 12:44:59 victor kernel: Code: 0f 0b b7 00 4f fd 24 c0 ff 74 24 08 9d c7 43 14 01 00 00 00

	The point that this happen during the compilation is somewhat random.
At least I never found out where does it happen. I have an athlon 950mhz
in a Abit KR7A-RAID (KT266A and VIA VT8233 chipset) motherborad, 256 Mb
of DDR ram, GeForce 2 MMX 200 Video (*), soudblaster live, a 40Gb
Seagate IDE harddisk (model ST340823A) and a HP CD R/RW 9340i.

	My harddisk has the following partiotion table : 

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1         7     56196   83  Linux
/dev/hda2   *         8       964   7687102+   b  Win95 FAT32
/dev/hda3           965      1027    506047+   6  FAT16
/dev/hda4          1028      4865  30828735    5  Extended
/dev/hda5          2099      4865  22225896   83  Linux
/dev/hda6          1028      1078    409626   83  Linux
/dev/hda7          1079      2098   8193118+  83  Linux

	witch is mounted into the system as following : 
LABEL=/                 /                       ext3    defaults        1 1
LABEL=/boot             /boot                   ext3    defaults        1 2
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/hda6               swap                    swap    defaults        0 0
/dev/hdd4               /mnt/zip100.0           auto    noauto,owner,kudzu 0 0
/dev/hda5		/opt/			reiserfs defaults	0 0
/dev/hda2		/mnt/c			vfat	noauto	0 0
/dev/cdrom              /mnt/cdrom              iso9660 noauto,owner,kudzu,ro 0 0

	You mey notice that I am using both ext3 and reiserfs, I used to have
only reiserfs disks, but since I noticed this problem I had a number of
tests including reinstalling everything into ext3, the opt partition is
a last reminisent from the time where all I had was reiserfs.

	The garnome test is located in the /opt and is installing to the same
partition. I can't think of anything else I can mention to help in this
(bug?) report. I do know that this can be hardware related, but when I
bougth the athlon machine I had the same problem with a Asus KT133 based
motherboard, i managed to exchange it for this ABIT KT266A that is
showing the same problem.

	I am willing to make tests, and I do have some knowledge (not kernel
related) so if you need info, please ask me that I'll do my best. I am
not subscribed to the list, so if you could forward the replies to my
email.

	Thanks in advance...

(*) I am using the NVidia non-gpl driver, but this test was done in
run-level 3, without any X running (also with the NVdriver module
unloaded).

-- 
