Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317014AbSFKMP3>; Tue, 11 Jun 2002 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSFKMP2>; Tue, 11 Jun 2002 08:15:28 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:23481 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S317014AbSFKMP1>;
	Tue, 11 Jun 2002 08:15:27 -0400
Message-ID: <036501c21141$926934f0$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RAID resync oops 2.4.19-pre10
Date: Tue, 11 Jun 2002 08:14:44 -0400
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

I'm still try to get my 2TB raid array to resync without oopsing -- since pre10 has new aic7xxx SCSI code I figured I'd try that.
This oops occurred and the kernel was still running.
I've seen this type of NFS oops on numerous previous kernels doing this same resync.
I'll try removing the NFS module again and see what happens.
If ANYBODY has any bright ideas on this it would be much appreciated....I can't test 2.5 because RAID5 won't compile on it.
This situation is repeatable as all get out -- I can move this array to another (slower) box and it will resync just fine.  So I'm
of the opinion that this is a race condition that is only exposed on the much faster box.

ksymoops 2.4.5 on i686 2.4.19-pre10.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /System.map (specified)

Jun 11 08:03:50 yeti kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun 11 08:03:50 yeti kernel: f88254c7
Jun 11 08:03:50 yeti kernel: *pde = 00000000
Jun 11 08:03:50 yeti kernel: Oops: 0002
Jun 11 08:03:50 yeti kernel: CPU:    1
Jun 11 08:03:50 yeti kernel: EIP:    0010:[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre10/kernel/fs/nfs/nfs.o+-281401/96]    Not
tainted
Jun 11 08:03:50 yeti kernel: EFLAGS: 00010202
Jun 11 08:03:50 yeti kernel: eax: 00000000   ebx: 0000000a   ecx: 00000001   edx: d420f001
Jun 11 08:03:50 yeti kernel: esi: 00000000   edi: f5833e6c   ebp: f4f96414   esp: f5833dcc
Jun 11 08:03:50 yeti kernel: ds: 0018   es: 0000   ss: 0018
Jun 11 08:03:50 yeti kernel: Process raid5d (pid: 333, stackpage=f5833000)
Jun 11 08:03:50 yeti kernel: Stack: f4f96400 0000000c f4f96400 f4f96414 f7a81800 f5833e00 f4f96414 00000018
Jun 11 08:03:50 yeti kernel:        f5832000 00000246 00000001 0000000c 00000006 00000000 00000000 00000000
Jun 11 08:03:50 yeti kernel:        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Jun 11 08:03:50 yeti kernel: Call Trace: [md_done_sync+42/88]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre10/kernel/fs/nfs/nfs.o+-277360/96]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre10/kernel/fs/nfs/nfs.o+-277774/96] [rw_intr+406/416]
[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre10/kernel/fs/nfs/nfs.o+-275826/96]
Jun 11 08:03:50 yeti kernel: Code: 00 00 8d b4 26 00 00 00 00 83 bc 24 bc 00 00 00 03 0f 85 af
Using defaults from ksymoops -t elf32-i386 -a i386


>>edx; d420f001 <_end+13ecf6ed/384dd6ec>
>>edi; f5833e6c <_end+354f4558/384dd6ec>
>>ebp; f4f96414 <_end+34c56b00/384dd6ec>
>>esp; f5833dcc <_end+354f44b8/384dd6ec>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   00 00                     add    %al,(%eax)
Code;  00000002 Before first symbol
   2:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  00000009 Before first symbol
   9:   83 bc 24 bc 00 00 00      cmpl   $0x3,0xbc(%esp,1)
Code;  00000010 Before first symbol
  10:   03
Code;  00000011 Before first symbol
  11:   0f 85 af 00 00 00         jne    c6 <_EIP+0xc6> 000000c6 Before first symbol



Michael D. Black mblack@csihq.com
http://www.csihq.com/
http://www.csihq.com/~mike
321-676-2923, x203
Melbourne FL

