Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290115AbSAQS3J>; Thu, 17 Jan 2002 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290118AbSAQS27>; Thu, 17 Jan 2002 13:28:59 -0500
Received: from pa13.bydgoszcz.sdi.tpnet.pl ([213.25.7.13]:26641 "HELO
	pa13.bydgoszcz.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S290115AbSAQS2o>; Thu, 17 Jan 2002 13:28:44 -0500
Date: Thu, 17 Jan 2002 19:27:59 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: OOPS on 2.4.17 -18pre4 while mounting root (reiserfs, on LVM, devfs)
Message-ID: <20020117182758.GA736@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

,

I'm stuck with 2.4.16, because newer kernels oops while booting.
I'm using LVM for root partition, starting system with
initrd.  On working kernels, normally "Mounted devfsd on /dev" appears.


All dumps also avaiable at http://fordon.pl.eu.org/~zdzichu/oops/

WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -V (default)
              -o /lib/modules/2.4.8-pre4 (specified)
              -K (specified)
              -L (specified)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

No modules in ksyms, skipping objects
invalid operand:  0000
CPU:    0
EIP:    0010 [<c01273eb>]       Not tainted
EFLAGS: 00010246
eax:   00000000    ebx: c1187d00    ecx: c1187d68    edx: c1187cf8
esi:   c1187cf1    edi: c0279a74    ebp: c0321f88    esp: c1199f00
ds: 0018       es: 0018      ss: 0018
Process swapper (pid: 1, stackpage=c1199000)
Stack: c1199f68 c11862e0 c11d270e c1199fbc c1199f1c c1187d29 00000004 0000000c
       c02e2f54 c0279a67 00000014 00000020 00000000 00000000 00000000 c02e2979
       c0276480 00000002 00000000 ffffffff 00000007 c1199fe0 c11862e0 00000000
Call Trace: [<c0117976>] [<c0106d1b>] [<c010522c>] [<c0105254>] [<c0105688>]
Code: 0f 0b 8b 12 81 fa c8 e1 2b c0 75 d9 e1 c8 e1 2b e0 89 48 04

>>EIP: c01273eb <kmem_cache_create+eb/328>
Trace: c0117976 <sys_waitpid+16/20>
Trace: c0106d1b <system_call+33/38>
Trace: c010522c <prepare_namespace+120/13c>
Trace: c0105254 <init+c/108>
Trace: c0105688 <kernel_thread+28/38>
Code:  c01273eb <kmem_cache_create+eb/328>     0000000000000000 <_EIP>: <===
Code:  c01273eb <kmem_cache_create+eb/328>        0:	0f 0b                	ud2a    <===
Code:  c01273ed <kmem_cache_create+ed/328>        2:	8b 12                	mov    (%edx),%edx
Code:  c01273ef <kmem_cache_create+ef/328>        4:	81 fa c8 e1 2b c0    	cmp    $0xc02be1c8,%edx
Code:  c01273f5 <kmem_cache_create+f5/328>        a:	75 d9                	jne     c01273d0 <kmem_cache_create+d0/328>
Code:  c01273f7 <kmem_cache_create+f7/328>        c:	e1 c8                	loope   c01273c1 <kmem_cache_create+c1/328>
Code:  c01273f9 <kmem_cache_create+f9/328>        e:	e1 2b                	loope   c0127426 <kmem_cache_create+126/328>
Code:  c01273fb <kmem_cache_create+fb/328>       10:	e0 89                	loopne  c0127386 <kmem_cache_create+86/328>
Code:  c01273fd <kmem_cache_create+fd/328>       12:	48                   	dec    %eax
Code:  c01273fe <kmem_cache_create+fe/328>       13:	04 00                	add    $0x0,%al

 <0>Kernel panic: Attempted to kill init!

2 warnings issued.  Results may not be reliable.

* -------------------------- (

lvm -- lvm_blk_ioctl: unknown command 0x5310
reiserfs: checking transaction log (device 3a:00) ...
Warning, log replay started on readonly filesystem
Using r5 to sort names
Reiserfs version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
devfs: devfs_do_symlink(root): could not append to parent, err: -17
change_root: old root has d_count=2
invalid operand:  0000
CPU:    0
EIP:    0010 [<c01273eb>]       Not tainted
EFLAGS: 00010246
eax:   00000000    ebx: c1187d00    ecx: c1187d68    edx: c1187cf8
esi:   c1187cf1    edi: c0279a74    ebp: c0321f88    esp: c1199f00
ds: 0018       es: 0018      ss: 0018
Process swapper (pid: 1, stackpage=c1199000)
Stack: c1199f68 c11862e0 c11d270e c1199fbc c1199f1c c1187d29 00000004 0000000c
       c02e2f54 c0279a67 00000014 00000020 00000000 00000000 00000000 c02e2979
       c0276480 00000002 00000000 ffffffff 00000007 c1199fe0 c11862e0 00000000
Call Trace: [<c0117976>] [<c0106d1b>] [<c010522c>] [<c0105254>] [<c0105688>]
Code: 0f 0b 8b 12 81 fa c8 e1 2b c0 75 d9 e1 c8 e1 2b e0 89 48 04
 <0>Kernel panic: Attempted to kill init!


* ------------------ *

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux mother 2.4.16 #9 wto lis 27 17:19:56 CET 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11l
mount                  2.11l
modutils               2.4.6
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         8139too es1370 gameport lirc_gpio lirc_dev loop


(gcc from slackware)


-- 
Tomasz Torcz
zdzichu@irc.pl
