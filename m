Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262735AbRE3LST>; Wed, 30 May 2001 07:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbRE3LSJ>; Wed, 30 May 2001 07:18:09 -0400
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:48003 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262735AbRE3LR6>; Wed, 30 May 2001 07:17:58 -0400
Date: Wed, 30 May 2001 12:17:55 +0100 (BST)
From: Stephen Cornell <cornell@zoo.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.2.18 oops
Message-Id: <Pine.GSO.3.95.1010530120922.1083A-100000@parasite>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, after reading the documentation I couldn't figure out who to send this
to.  ksymoops doesn't seem to have done its job correctly, but I include the
output anyway.  The problem seems to have occured during updatedb (creates the
slocate file database), which runs daily as a cron job (and has done so
flawlessly on this machine since installation 2 years ago).  The machine is an
SMP i686 machine, all IDE disks, running Red Hat 6.0 (+updates), and has been
running kernel 2.2.18 (compiled by me) since February.  The oops causes the
machine to hang completely.


torus:ksymoops (14)% ./ksymoops  < ~/oops.txt
WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from
ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops
Options used: -V (default)
              -o /lib/modules/2.2.18/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

You did not tell me where to find symbol information.  I will assume
that the log matches the kernel and modules that are running right now
and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning, no symbols in lsmod, is /proc/modules a valid lsmod file?
May 26 04:02:57 localhost kernel: Unable to handle kernel NULL pointer
dereference at
May 26 04:02:57 localhost kernel: current->tss.cr3 = 0f952000, %%cr3 =
0f952000
May 26 04:02:57 localhost kernel: *pde = 00000000
May 26 04:02:57 localhost kernel: Oops: 0002
May 26 04:02:57 localhost kernel: CPU:    1
May 26 04:02:57 localhost kernel: EIP:    0010:[dput+310/328]
May 26 04:02:57 localhost kernel: EFLAGS: 00010286
May 26 04:02:57 localhost kernel: eax: 00000027   ebx: cad3a580   ecx:
0000004a   edx: 0000002e
May 26 04:02:57 localhost kernel: esi: ffffffff   edi: c959f80c   ebp:
000004d5   esp: cdcf1e50
May 26 04:02:57 localhost kernel: ds: 0018   es: 0018   ss: 0018
May 26 04:02:57 localhost kernel: Process updatedb (pid: 32052, process nr:
45, stackpage=cdcf1000)
May 26 04:02:57 localhost kernel: Stack: cf822520 cad3a5e0 cad3a580 c4341220
c0134db4
cad3a580 cdcf1eb0 cdcf1eb0
May 26 04:02:57 localhost kernel:        c02054e8 00001004 cdcf1eb0 00000001
00001004
c0135efc fffff4bb 00001004
May 26 04:02:57 localhost kernel:        00000000 c022d548 c02054e8 c022d548
c0140ed3
c01d3be0 c2a95440 cbb60888
May 26 04:02:57 localhost kernel: Call Trace: [prune_dcache+248/300]
[try_to_free_inodes+316/396] [ext2_find_entry+455/752] [cprt+5472/41797]
[grow_inodes+30/440] [get_new_inode+197/312] [iget4+134/144]
May 26 04:02:57 localhost kernel: Code: c7 05 00 00 00 00 00 00 00 00 83 c4 10
5b 5e c3 89 f6 56 53
 
Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    c7 05 00 00 00 00 00
movl
 $0x0,0x0 <===
Code:  00000007 Before first symbol               7:    00 00 00
Code:  0000000a Before first symbol               a:    83 c4 10
addl
 $0x10,%esp
Code:  0000000d Before first symbol               d:    5b
popl
 %ebx
Code:  0000000e Before first symbol               e:    5e
popl
 %esi
Code:  0000000f Before first symbol               f:    c3
ret
 
Code:  00000010 Before first symbol              10:    89 f6
movl
 %esi,%esi
Code:  00000012 Before first symbol              12:    56
pushl
 %esi
Code:  00000013 Before first symbol              13:    53
pushl
 %ebx
 
 
4 warnings issued.  Results may not be reliable.

-- 
Stephen Cornell          cornell@zoo.cam.ac.uk         Tel/fax +44-1223-336644
University of Cambridge, Zoology Department, Downing Street, CAMBRIDGE CB2 3EJ

