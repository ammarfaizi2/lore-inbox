Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269847AbTGOWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbTGOWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:20:44 -0400
Received: from eq16.auctionwatch.com ([66.7.130.111]:37341 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id S269846AbTGOWTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:19:07 -0400
Date: Tue, 15 Jul 2003 15:33:42 -0700
From: Petro <petro@corp.vendio.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20030715223342.GH26404@corp.vendio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Subject: LVM, snapshots and Linux 2.4.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello again. 


    This time I'm having a bit of trouble with getting snapshots to work
    on a 2.4.x kernel. 

    I have a (well, several) machines configured as follows: 

    4 gig ram, 
    2x2.4Ghz. Xeon processors (hyperthreading on). 
    6 200 gig Western Digital drives attached to a 3ware 7800 card. 
    1 200 Gig Western Digital drive attachedt to the motherboard. 
    Motherboard is a Supermicro SUPER P4DPi-G2 (MBD-P4DPi-G2-B)

    I have tried mildly patched (i.e. only the stuff I absolutely need)
    "stock" kernels, and redhat's 2.4.20-18.9 kernel (stock compile). 

    I'm trying to create and mount snapshots using "lvcreate -L10G -s -n
    snaptest /dev/vg0" (and then a mount later). 

    Under 2.4.18 I actually get an oops:
ksymoops 2.4.1 on i686 2.4.18.  Options used
     -V (default)
     -k /var/log/ksymoops/20030715080710.ksyms (specified)
     -l /var/log/ksymoops/20030715080710.modules (specified)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0208860, System.map says c0158050.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says f8984fb0, /lib/modules/2.4.18/kernel/fs/lockd/lockd.o says f8984408.  Ignoring /lib/modules/2.4.18/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says f8977524, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8977204.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says f8977528, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8977208.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says f897752c, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f897720c.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says f8977520, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8977200.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
kernel BUG at vmalloc.c:236!
invalid operand: 0000
CPU:    3
EIP:    0010:[<c012c431>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c02ccde0   edx: 00005647
esi: 00000000   edi: f7162000   ebp: fffffff4   esp: ea799d18
ds: 0018   es: 0018   ss: 0018
Process lvcreate (pid: 10777, stackpage=ea799000)
Stack: c02695b7 000000ec 00000000 00000000 f7162000 fffffff4 000001f0 f8d61000 
       00000001 fffffff4 c02ce188 c02ce2d8 000001f0 00000001 c0212e15 00000000 
              000001f2 00000163 f716216c 00000000 f7162000 ea799df8 c0212ec8 f7162000 
Call Trace: [<c0212e15>] [<c0212ec8>] [<c0210ae0>] [<c020e58c>] [<c0145dc7>] 
         [<c0106e9b>] 
Code: 0f 0b 83 c4 08 31 c0 e9 b7 01 00 00 8d 76 00 6a 02 53 e8 2c 

>>EIP; c012c431 <__vmalloc+35/200>   <=====
Trace; c0212e15 <lvm_snapshot_alloc_hash_table+45/8c>
Trace; c0212ec8 <lvm_snapshot_alloc+6c/e0>
Trace; c0210ae0 <lvm_do_lv_create+50c/850>
Trace; c020e58c <lvm_chr_ioctl+71c/828>
Trace; c0145dc7 <sys_ioctl+1bb/208>
Trace; c0106e9b <system_call+33/38>
Code;  c012c431 <__vmalloc+35/200>
00000000 <_EIP>:
Code;  c012c431 <__vmalloc+35/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c433 <__vmalloc+37/200>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012c436 <__vmalloc+3a/200>
   5:   31 c0                     xor    %eax,%eax
Code;  c012c438 <__vmalloc+3c/200>
   7:   e9 b7 01 00 00            jmp    1c3 <_EIP+0x1c3> c012c5f4 <__vmalloc+1f8/200>
Code;  c012c43d <__vmalloc+41/200>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c012c440 <__vmalloc+44/200>
   f:   6a 02                     push   $0x2
Code;  c012c442 <__vmalloc+46/200>
  11:   53                        push   %ebx
Code;  c012c443 <__vmalloc+47/200>
  12:   e8 2c 00 00 00            call   43 <_EIP+0x43> c012c474 <__vmalloc+78/200>


6 warnings issued.  Results may not be reliable.

On a 2.4.21 kernel I get: 
lvcreate -- WARNING: the snapshot will be automatically disabled once it gets full
lvcreate -- INFO: using default snapshot chunk size of 64 KB for "/dev/vg0/snap"
lvcreate -- ERROR "Cannot allocate memory" creating VGDA for "/dev/vg0/snap" in kernel

This is on a machine with 4 gig of memory running *NOTHING ELSE*. 

This also causes some sort of funkiness with LVM layer requiring a hard
reboot--powercycle--to get it back. 

This is with: 

#CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y

if I turn off HIGHIO, the lvcreate command completes successfully, but
the snapshot is unmountable. 

If I turn off HIGHMEM4G and HIGHIO, then everything works, but I lose
3G. This is non-workable. 

The redhat kernel (2.4.20-18.9) allows the creation of the snapshot but
will not mount it. 

However--the redhat kernel is a real bastard child, as these are Debian
boxes with really old bits on them (pre-3.0 unstable packages). 

At this point these are not production machines, so I'm willing to try
just about anything reasonable to get a *stable* platform that provides:

1) Access to 4G of ram (or most of 4G). 
2) 1Terabyte filesystem (or close to it). 
3) 10-20G snapshots of that filesystem. 


What am I forgetting to mention...Other than I'm at wits ends? 

-- 
"On two occasions, I have been asked [by members of Parliament], 'Pray, 
Mr. Babbage, if you put into the machine wrong figures, will the right 
answers come out?' I am not able to rightly apprehend the kind of confusion 
of ideas that could provoke such a question." -- Charles Babbage 
