Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319163AbSHTOgQ>; Tue, 20 Aug 2002 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319164AbSHTOgQ>; Tue, 20 Aug 2002 10:36:16 -0400
Received: from ifup.net ([217.160.130.191]:28384 "HELO ifup.net")
	by vger.kernel.org with SMTP id <S319163AbSHTOgM>;
	Tue, 20 Aug 2002 10:36:12 -0400
Date: Tue, 20 Aug 2002 16:40:32 +0200
From: "Karsten 'soohrt' Desler" <lkml@soohrt.org>
To: mingo@redhat.com, neilb@cse.unsw.edu.au
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.4.19 Kernel Panic Software Raid 5 (md)
Message-ID: <20020820144032.GA16759@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The panicking server is a AMD TB 850 on a Abit KA7-100 Mainboard with
512mb 'memtested' RAM. The raid5 consists of 8 80gb drives.
hdc: MAXTOR 4K080H4, ATA DISK drive
hdd: WDC WD800AB-00CBA0, ATA DISK drive
hde: MAXTOR 4K080H4, ATA DISK drive
hdf: MAXTOR 4K080H4, ATA DISK drive
hdi: MAXTOR 4K080H4, ATA DISK drive
hdj: WDC WD800AB-00CBA0, ATA DISK drive
hdk: MAXTOR 4K080H4, ATA DISK drive
hdl: WDC WD800AB-00CBA0, ATA DISK drive

root@pikelot:~# cat /proc/mdstat
md0 : active raid5 hdl1[7] hdk1[6] hdj1[5] hdi1[4] hdf1[3] hde1[2] hdd1[1] hdc1[0]
      547054144 blocks level 5, 64k chunk, algorithm 2 [8/8] [UUUUUUUU]
      [=====>...............]  resync = 26.5% (20732272/78150592)
      finish=87.3min speed=10948K/sec
	    
The Filesystem on /dev/md0 is ext3 (mke2fs -j -b 4096 -R stride=16 /dev/md0)

The system runs fine until I try to copy 300gb via rsync over FastEthernet
from my Backup server. After about 70gb I got the following Kernel Panic(s):
unmodified (linewrap) output on:
http://www.soohrt.org/stuff/linux/panic/raid5.txt
--
Aug 20 16:48:55 pikelot kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000003
Aug 20 16:48:55 pikelot kernel:  printing eip:
Aug 20 16:48:55 pikelot kernel: c0195731
Aug 20 16:48:55 pikelot kernel: *pde = 00000000
Aug 20 16:48:55 pikelot kernel: Oops: 0002
Aug 20 16:48:55 pikelot kernel: CPU:    0
Aug 20 16:48:55 pikelot kernel: EIP:    0010:[remove_hash+17/48]    Not
tainted
Aug 20 16:48:55 pikelot kernel: EFLAGS: 00010086
Aug 20 16:48:55 pikelot kernel: eax: ffffffff   ebx: c15b5c00   ecx:
df65e000   edx: dfe69e4c
Aug 20 16:48:55 pikelot kernel: esi: df65e000   edi: 00000001   ebp:
d6fcfe40   esp: dbb3dd9c
Aug 20 16:48:55 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 16:48:55 pikelot kernel: Process kjournald (pid: 751,
stackpage=dbb3d000)
Aug 20 16:48:55 pikelot kernel: Stack: c0195780 df65e000 c15b5c00
00000000 c0195bd9 c15b5c00 c15b5c00 00000000
Aug 20 16:48:55 pikelot kernel:        00000001 d6fcfe40 c15b5c00
00000000 dbb3c000 00001000 00000018 00000080
Aug 20 16:48:55 pikelot kernel:        c0197aa2 2bf75498 c0197ab4
c15b5c00 0647e798 00001000 00000000 d6fcfe40
Aug 20 16:48:55 pikelot kernel: Call Trace:    [get_free_stripe+48/80]
[get_active_stripe+601/1280] [raid5_make_request+66/256]
[raid5_make_request+84/256] [md_make_request+56/112]
Aug 20 16:48:55 pikelot kernel:   [generic_make_request+284/304]
[submit_bh+78/112] [ll_rw_block+311/416]
[journal_commit_transaction+766/3623] [kjournald+278
/432] [commit_timeout+0/16]
Aug 20 16:48:55 pikelot kernel:   [kernel_thread+40/64]
Aug 20 16:48:55 pikelot kernel:
Aug 20 16:48:55 pikelot kernel: Code: 89 50 04 8b 51 04 8b 01 89 02 c7
41 04 00 00 00 00 c3 8d b6
Aug 20 16:48:56 pikelot kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 0000022f
Aug 20 16:48:56 pikelot kernel:  printing eip:
Aug 20 16:48:56 pikelot kernel: c0195960
Aug 20 16:48:56 pikelot kernel: *pde = 00000000
Aug 20 16:48:56 pikelot kernel: Oops: 0000
Aug 20 16:48:56 pikelot kernel: CPU:    0
Aug 20 16:48:56 pikelot kernel: EIP:    0010:[__find_stripe+48/80]
Not tainted
Aug 20 16:48:56 pikelot kernel: EFLAGS: 00010086
Aug 20 16:48:56 pikelot kernel: eax: ffffffff   ebx: 00000008   ecx:
053fdc98   edx: 00000000
Aug 20 16:48:56 pikelot kernel: esi: c15b5c00   edi: 00000393   ebp:
c15ff680   esp: df5d5e70
Aug 20 16:48:56 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 16:48:56 pikelot kernel: Process raid5syncd (pid: 9,
stackpage=df5d5000)
Aug 20 16:48:56 pikelot kernel: Stack: c15b5c00 000a7fb9 053fdc98
c0195bb9 c15b5c00 053fdc98 c15b5c00 000a7fb9
Aug 20 16:48:56 pikelot kernel:        053fdc98 c15ff680 00000000
00000000 df5d4000 00001000 00000000 00000282
Aug 20 16:48:56 pikelot kernel:        c15b5c00 24bf0780 c0197bd6
c15b5c00 053fdc98 00000000 00000000 df5d4000
Aug 20 16:48:56 pikelot kernel: Call Trace:
[get_active_stripe+569/1280] [raid5_sync_request+70/224]
[md_do_sync+458/1040] [raid5syncd+47/112] [md_thread+246/336]
Aug 20 16:48:56 pikelot kernel:   [kernel_thread+40/64]
Aug 20 16:48:56 pikelot kernel:
Aug 20 16:48:56 pikelot kernel: Code: 39 88 30 02 00 00 74 08 8b 00 85
c0 75 f2 31 c0 5b 5e 5f c3
Aug 20 16:48:56 pikelot kernel:  <1>Unable to handle kernel paging
request at virtual address 50b16364
Aug 20 16:48:56 pikelot kernel:  printing eip:
Aug 20 16:48:56 pikelot kernel: c011d2c5
Aug 20 16:48:56 pikelot kernel: *pde = 00000000
Aug 20 16:48:56 pikelot kernel: Oops: 0002
Aug 20 16:48:56 pikelot kernel: CPU:    0
Aug 20 16:48:56 pikelot kernel: EIP:    0010:[add_timer+181/224]    Not
tainted
Aug 20 16:48:56 pikelot kernel: EFLAGS: 00010082
Aug 20 16:48:56 pikelot kernel: eax: dbb3dfdc   ebx: 00000206   ecx:
00000000   edx: 50b16360
Aug 20 16:48:56 pikelot kernel: esi: c159bf2c   edi: 00000000   ebp:
c159bf40   esp: c159bf14
Aug 20 16:48:56 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 16:48:56 pikelot kernel: Process init (pid: 1,
stackpage=c159b000)
Aug 20 16:48:56 pikelot kernel: Stack: c159bf2c 000b545a c0113e45
c159bf2c 00000000 dedec240 00000000 00000000
Aug 20 16:48:56 pikelot kernel:        000b545a c159a000 c0113d80
c159bf74 c013e921 00000004 00000001 da304158
Aug 20 16:48:56 pikelot kernel:        00000104 00000400 c159a000
000001f4 0000000b 00000000 00000000 d5493000
Aug 20 16:48:56 pikelot kernel: Call Trace:
[schedule_timeout+117/160] [process_timeout+0/80] [do_select+417/480]
[sys_select+810/1136] [system_call+51/56]
Aug 20 16:48:56 pikelot kernel:
Aug 20 16:48:56 pikelot kernel: Code: 89 72 04 89 16 89 46 04 89 30 53
9d eb 14 53 9d 8b 44 24 08
Aug 20 16:48:56 pikelot kernel:  <0>Kernel panic: Attempted to kill
init!
--

Additional information (dmesg, lspci, ver_linux) can be found under
http://www.soohrt.org/stuff/linux.html

Cheers,
 Karsten
