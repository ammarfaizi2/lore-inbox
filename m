Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281659AbRKUHwi>; Wed, 21 Nov 2001 02:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281662AbRKUHw3>; Wed, 21 Nov 2001 02:52:29 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:18448 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S281659AbRKUHwO>; Wed, 21 Nov 2001 02:52:14 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <15355.27299.252362.983624@beta.reiserfs.com>
Date: Wed, 21 Nov 2001 11:49:39 +0300
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: ReiserFS List <reiserfs-list@Namesys.COM>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com>
In-Reply-To: <200111210110.fAL1Atc11275@beta.namesys.com>
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel writes:
 > Sorry Nikita,
 > 
 > but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
 > I've tried it with "old" and "new" (current) N-inode-attrs.patch. But that doesn't matter.
 > 
 > [-]
 > IP: routing cache hash table of 8192 buckets, 64Kbytes
 > TCP: Hash tables configured (established 262144 bind 65536)
 > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 > reiserfs: checking transaction log (device 08:03) ...
 > Using r5 hash to sort names
 > ReiserFS version 3.6.25
 > VFS: Mounted root (reiserfs filesystem) readonly.
 > Freeing unused kernel memory: 208k freed
 > "Warning: unable to open an initial console." 

N-inode-attrs.patch uses previously unused field in reiserfs on-disk
inode structure to store inode attributes. It seems that in some cases
this field actually contains garbage. It may happen that you have got
immutable bit for your console device this way.

As a work around try to boot with ext2, do

lsattr /dev/console to check, and run 

chattr -R -SAadiscu /reiserfs-mount-point

for each reiserfs file system to clear all attributes. Yes, it's silly.

 > 
 > SysRq: Show Regs
 > 
 > Pid: 1, comm: init
 > EIP: 0023 : [<0804c842>] CPU: 0 ESP: 002b:bffffe10 EFLAGS: 00010246 Not tainted
 > EAX: ffffffff EBX: bfffff00 ECX: 0000000d EDX: ffffffff
 > ESI: bffffef4 EDI: 00000002 EBP: bffffe78 DS: 002b ES: 002b
 > CR0: 8005003b CR2: 080609c0 CR3: 27adc000 CR4: 000002d0
 > Call Trace:
 > 
 > SysRq: Show State
 > 
 > init, keventd, ksoftirqd_CPU, kswapd, bdflush, kupdated, scsi_eh_0, kreiserfsd
 > 
 > Thanks,
 > 	Dieter
 > -- 
 > Dieter Nützel
 > Graduate Student, Computer Science
 > @home: Dieter.Nuetzel@hamburg.de

Nikita.
