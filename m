Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSGPIFy>; Tue, 16 Jul 2002 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317783AbSGPIFx>; Tue, 16 Jul 2002 04:05:53 -0400
Received: from avtodor.gorny.ru ([212.164.99.171]:22026 "EHLO mail.ruad")
	by vger.kernel.org with ESMTP id <S317782AbSGPIFw>;
	Tue, 16 Jul 2002 04:05:52 -0400
Date: Tue, 16 Jul 2002 15:08:17 +0700
From: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Mailer: The Bat! (v1.60c) Personal
Reply-To: Sokolov Sergei <s_sokolov@avtodor.gorny.ru>
X-Priority: 3 (Normal)
Message-ID: <9320413493.20020716150817@avtodor.gorny.ru>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at buffer.c:549
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 16.07.2002 15:08:15,
	Serialize by Router on mail/Gorno-Altaiavtodor(Release 5.0.9a |January 7, 2002) at
 16.07.2002 15:08:25,
	Serialize complete at 16.07.2002 15:08:25
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I have linux kernel 2.4.19-rc1 with xfs enabled.
RedHat 7.2:
Linux version 2.4.19-rc1-xfs (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))

My xfs partitions locates on /dev/ataraid devices (Promise FastTrak Tx4),
Two mirror on   four disks "Seagate Barracuda IV 80GB".

I have two problems:

1) [root@ws188 linux-2.4.19-rc1-xfs]# mkfs.xfs /dev/ataraid/d1p2
   mkfs.xfs: warning - cannot set blocksize on block device /dev/ataraid/d1p2: Invalid argument

2)When I copying files between partitions, I receive message.

Jul 12 17:01:19 ws188 kernel: kernel BUG at buffer.c:549!
Jul 12 17:01:19 ws188 kernel: invalid operand: 0000
Jul 12 17:01:19 ws188 kernel: CPU:    0
Jul 12 17:01:19 ws188 kernel: EIP:    0010:[__insert_into_lru_list+37/112]    Not tainted
Jul 12 17:01:19 ws188 kernel: EIP:    0010:[<c012f335>]    Not tainted
Jul 12 17:01:19 ws188 kernel: EFLAGS: 00010206
Jul 12 17:01:19 ws188 kernel: eax: 00000000   ebx: 00000008   ecx: d6e297c0   edx: c02ec594
Jul 12 17:01:19 ws188 kernel: esi: 00000002   edi: 00001000   ebp: 00000000   esp: df0ebe18
Jul 12 17:01:19 ws188 kernel: ds: 0018   es: 0018   ss: 0018
Jul 12 17:01:19 ws188 kernel: Process mc (pid: 872, stackpage=df0eb000)
Jul 12 17:01:19 ws188 kernel: Stack: 00000002 d6e297c0 c012fb64 d6e297c0 00000002 d6e297c0 00001000 c012fb7a
Jul 12 17:01:19 ws188 kernel:        d6e297c0 c01305a5 d6e297c0 00000000 d09b22c0 484cc000 00000000 d6e297c0
Jul 12 17:01:19 ws188 kernel:        c0130c56 d09b22c0 c10acf20 00000000 00001000 00001000 00001000 00000000
Jul 12 17:01:19 ws188 kernel: Call Trace: [__refile_buffer+84/96] [refile_buffer+10/16] [__block_commit_write+
117/192] [generic_commit_write+54/96] [pagebuf_generic_file_write+613/768]
Jul 12 17:01:19 ws188 kernel: Call Trace: [<c012fb64>] [<c012fb7a>] [<c01305a5>] [<c0130c56>] [<c01cea75>]
Jul 12 17:01:19 ws188 kernel:    [xfs_write+1032/1808] [linvfs_pb_bmap+0/208] [linvfs_write+812/864] [sys_writ
e+150/240] [system_call+51/56]
Jul 12 17:01:19 ws188 kernel:    [<c01d44a8>] [<c01d30b0>] [<c01cfe5c>] [<c012e026>] [<c01089bb>]
Jul 12 17:01:19 ws188 kernel:
Jul 12 17:01:19 ws188 kernel: Code: 0f 0b 25 02 60 9e 26 c0 8b 02 85 c0 75 07 89 0a 89 49 24 8b  

-- 
Sergei Sokolov

