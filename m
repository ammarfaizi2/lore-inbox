Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314328AbSDRL4d>; Thu, 18 Apr 2002 07:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSDRL4c>; Thu, 18 Apr 2002 07:56:32 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:16298 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S314328AbSDRL4a>;
	Thu, 18 Apr 2002 07:56:30 -0400
Message-ID: <00e901c1e6d0$0a384350$e1de11cc@csihq.com>
Reply-To: "Mike Black" <mblack@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.17-pre7 oops
Date: Thu, 18 Apr 2002 07:56:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having problems resyncing my 2TB RAID5 Ultra160 array for every
kernel version I've tried.  Here's the latest.
The drive being resynced is mounted and exported via NFS while it's
resyncing.
I'll try it one more time while it's not exported.

md6 : active raid5 sdm1[12] sdb1[1] sdl1[11] sdk1[10] sdj1[9] sdi1[8]
sdh1[7] sdg1[6] sdf1[5] sde1[4] sdd1[3] sdc1[2]
      1950225024 blocks level 5, 128k chunk, algorithm 2 [12/11]
[_UUUUUUUUUUU]
      [>....................]  recovery =  2.7% (4919104/177293184)
finish=2569.6min speed=1117K/sec

Once the oops occurs on the raid resync thread I end up having to do a hard
reboot

ksymoops 2.4.5 on i686 2.4.19-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7/ (default)
     -m /System.map (specified)

Apr 18 07:37:33 yeti kernel: kernel BUG at ll_rw_blk.c:862!
Apr 18 07:37:33 yeti kernel: invalid operand: 0000
Apr 18 07:37:33 yeti kernel: CPU:    1
Apr 18 07:37:33 yeti kernel: EIP:    0010:[__make_request+138/1588]
Tainted: P
Apr 18 07:37:33 yeti kernel: EFLAGS: 00010246
Apr 18 07:37:33 yeti kernel: eax: 00000000   ebx: f5effba0   ecx: 00002000
edx: 00000000
Apr 18 07:37:33 yeti kernel: esi: 00000000   edi: 00000000   ebp: 0a9147fc
esp: f6255e2c
Apr 18 07:37:33 yeti kernel: ds: 0018   es: 0018   ss: 0018
Apr 18 07:37:33 yeti kernel: Process raid5d (pid: 147, stackpage=f6255000)
Apr 18 07:37:33 yeti kernel: Stack: 00000871 f5effba0 00000000 0a9147fc
f7b18e38 00002000 f7b2ce40 f7b18e38
Apr 18 07:37:33 yeti kernel:        00000400 00000000 00000000 00000000
f7b151a0 c018a90c f7b2ce18 00000000
Apr 18 07:37:33 yeti kernel:        f5effba0 0000001c 000000c4 f5f18400
00000002 f88265f7 00000000 f5effba0
Apr 18 07:37:33 yeti kernel: Call Trace: [generic_make_request+284/300]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-277001/96]
[bh_action+76/136]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-275842/96]
[md_thread+341/440]
Apr 18 07:37:33 yeti kernel: Code: 0f 0b 5e 03 62 66 25 c0 53 56 e8 6f be fa
ff 89 c3 0f b6 43
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f5effba0 <_end+35bc22ec/384df74c>
>>ecx; 00002000 Before first symbol
>>ebp; 0a9147fc Before first symbol
>>esp; f6255e2c <_end+35f18578/384df74c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   5e                        pop    %esi
Code;  00000003 Before first symbol
   3:   03 62 66                  add    0x66(%edx),%esp
Code;  00000006 Before first symbol
   6:   25 c0 53 56 e8            and    $0xe85653c0,%eax
Code;  0000000b Before first symbol
   b:   6f                        outsl  %ds:(%esi),(%dx)
Code;  0000000c Before first symbol
   c:   be fa ff 89 c3            mov    $0xc389fffa,%esi
Code;  00000011 Before first symbol
  11:   0f b6 43 00               movzbl 0x0(%ebx),%eax



________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

