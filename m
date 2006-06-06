Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWFFMtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWFFMtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWFFMtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:49:41 -0400
Received: from mail.charite.de ([160.45.207.131]:4004 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750711AbWFFMtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:49:40 -0400
Date: Tue, 6 Jun 2006 14:49:07 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Cc: Udo Wolter <Udo.Wolter@charite.de>
Subject: Bug: EIP is at clear_inode+0x89/0x11a, 2.6.17-rc3-git9, SMP
Message-ID: <20060606124907.GZ29326@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Udo Wolter <Udo.Wolter@charite.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something killed the kswapd:

# uname -a
Linux postamt.charite.de 2.6.17-rc3-git9 #1 SMP Thu May 4 16:23:26
CEST 2006 i686 GNU/Linux

from dmesg output

BUG: unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c106bd20
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: tg3 dm_mod aic7xxx rtc
CPU:    1
EIP:    0060:[<c106bd20>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc3-git9 #1) 
EIP is at clear_inode+0x89/0x11a
eax: 00000000   ebx: c53652f8   ecx: db28edd0   edx: 00000000
esi: c536546c   edi: 00000030   ebp: 00000080   esp: c2d1cef0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 129, threadinfo=c2d1c000 task=c2d1a580)
Stack: <0>f7994d28 c53652f8 f7994d28 c106c3d6 c53652f8 c39b6d94 c106b3f6 c39b6dbc 
       c106a2b1 0004bfa0 c1327500 00000129 0001c207 c106a30c c10405f1 c181bb80 
       c191e8c0 c14e24a0 00000159 00000000 00000100 000000d0 00000064 c1263180 
Call Trace:
 <c106c3d6> generic_drop_inode+0x11f/0x140   <c106b3f6> iput+0x5d/0x69
 <c106a2b1> prune_dcache+0xf0/0x114   <c106a30c> shrink_dcache_memory+0x37/0x3d
 <c10405f1> shrink_slab+0x111/0x187   <c10418f9> balance_pgdat+0x20e/0x3bc
 <c1041b84> kswapd+0xdd/0x128   <c102bd74> autoremove_wake_function+0x0/0x37
 <c1041aa7> kswapd+0x0/0x128   <c1000dd5> kernel_thread_helper+0x5/0xb
Code: 8b 72 04 85 f6 74 1d 31 d2 8b 8c 93 18 01 00 00 85 c9 75 71 83 c2 01 83 fa 02 74 08 eb eb 8b 83 b8 00 00 00 85 c0 74 0e 8b 40 20 <8b> 50 3c 85 d2 74 04 89 d8 ff d2 8b 83 2c 01 00 00 85 c0 74 07 
EIP: [<c106bd20>] clear_inode+0x89/0x11a SS:ESP 0068:c2d1cef0
 
# mount
/dev/cciss/c0d0p6 on / type ext3 (rw,errors=panic)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/cciss/c0d0p5 on /boot type ext3 (rw)
/dev/sda5 on /home type ext3 (rw,noatime,quota)

# ps auxwww|grep kswap
root     30024  0.0  0.0   1664   528 pts/3    S+   14:48   0:00 grep kswap

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
