Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271825AbTGRXGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271846AbTGRXGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:06:36 -0400
Received: from eq11.auctionwatch.com ([66.7.130.106]:46417 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id S271825AbTGRXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:05:57 -0400
Date: Fri, 18 Jul 2003 16:20:37 -0700
From: Petro <petro@corp.vendio.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20030718232037.GA6125@corp.vendio.com>
References: <20030715223342.GH26404@corp.vendio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715223342.GH26404@corp.vendio.com>
User-Agent: Mutt/1.5.4i
Subject: Kernel Oops--2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I sent a similar email out earlier in the week, but received only one
reply, so I'm trying again)

I'm repeatedly getting:

kernel BUG at vmalloc.c:236!
invalid operand: 0000
CPU:    2
EIP:    0010:[__vmalloc+53/512]    Not tainted
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c02c80e0   edx: 000055a2
esi: 00000000   edi: f705a600   ebp: fffffff4   esp: f6fc9d18
ds: 0018   es: 0018   ss: 0018
Process lvcreate (pid: 400, stackpage=f6fc9000)
Stack: c026c0d5 000000ec 00000000 00000000 f705a600 fffffff4 000001f0 f8d4e000 
       00000001 fffffff4 c02c94e8 c02c9638 000001f0 00000001 c0216165 00000000 
       000001f2 00000163 f705a76c 00000000 f705a600 f6fc9df8 c0216218 f705a600 
Call Trace: [lvm_snapshot_alloc_hash_table+69/140] [lvm_snapshot_alloc+108/224] [lvm_do_lv_create+1292/2140] [lvm_chr_ioctl+1820/2088] [sys_ioctl+443/520] 
   [system_call+51/56] 

Code: 0f 0b 83 c4 08 31 c0 e9 b7 01 00 00 8d 76 00 6a 02 53 e8 2c 

Which decodes to: 

ksymoops 2.4.1 on i686 2.4.18.  Options used
     -V (default)
     -k /var/log/ksymoops/20030718143024.ksyms (specified)
     -l /var/log/ksymoops/20030718143024.modules (specified)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c020b870, System.map says c0158b10.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says f8973af0, /lib/modules/2.4.18/kernel/fs/lockd/lockd.o says f8972f48.  Ignoring /lib/modules/2.4.18/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says f89660e4, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8965dc4.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says f89660e8, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8965dc8.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says f89660ec, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8965dcc.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says f89660e0, /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o says f8965dc0.  Ignoring /lib/modules/2.4.18/kernel/net/sunrpc/sunrpc.o entry
kernel BUG at vmalloc.c:236!
invalid operand: 0000
CPU:    2
EIP:    0010:[__vmalloc+53/512]    Not tainted
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c02c80e0   edx: 000055a2
esi: 00000000   edi: f705a600   ebp: fffffff4   esp: f6fc9d18
ds: 0018   es: 0018   ss: 0018
Process lvcreate (pid: 400, stackpage=f6fc9000)
Stack: c026c0d5 000000ec 00000000 00000000 f705a600 fffffff4 000001f0 f8d4e000 
       00000001 fffffff4 c02c94e8 c02c9638 000001f0 00000001 c0216165 00000000 
       000001f2 00000163 f705a76c 00000000 f705a600 f6fc9df8 c0216218 f705a600 
Call Trace: [lvm_snapshot_alloc_hash_table+69/140] [lvm_snapshot_alloc+108/224] [lvm_do_lv_create+1292/2140] [lvm_chr_ioctl+1820/2088] [sys_ioctl+443/520] 
Code: 0f 0b 83 c4 08 31 c0 e9 b7 01 00 00 8d 76 00 6a 02 53 e8 2c 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   31 c0                     xor    %eax,%eax
Code;  00000007 Before first symbol
   7:   e9 b7 01 00 00            jmp    1c3 <_EIP+0x1c3> 000001c3 Before first symbol
Code;  0000000c Before first symbol
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  0000000f Before first symbol
   f:   6a 02                     push   $0x2
Code;  00000011 Before first symbol
  11:   53                        push   %ebx
Code;  00000012 Before first symbol
  12:   e8 2c 00 00 00            call   43 <_EIP+0x43> 00000043 Before first symbol


6 warnings issued.  Results may not be reliable.

When trying to do create a snapshot with lvcreate -L10G -s -n snaptest
/dev/vg0/lv0. 

The kernel source is mildly patched with (in order)
lmsensors-patch-2.7.0vs2.4.18
i2cpatch-2.7.0vs2.4.18lvm    
lvm-1.0.7-2.4.18.patch
linux-2.4.18-VFS-lock.patch  
linux-2.4.18-sard.patch
3ware 7.5.2 drivers (copied over by hand). 

and built using  gcc --version 2.95.4

The hardware is: 

     4 gig ram, 
     2x2.4Ghz. Xeon processors (hyperthreading on). 
     6 200 gig Western Digital drives attached to a 3ware 7800 card. 
     1 200 Gig Western Digital drive attachedt to the motherboard. 
     Motherboard is a Supermicro SUPER P4DPi-G2 (MBD-P4DPi-G2-B)


I have:
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y

I am told by the LVM Guy that this is a kernel VM bug. Is this the case?
If so, is there a patch I can apply to let me get this stuff into
production? 


-- 
"On two occasions, I have been asked [by members of Parliament], 'Pray, 
Mr. Babbage, if you put into the machine wrong figures, will the right 
answers come out?' I am not able to rightly apprehend the kind of confusion 
of ideas that could provoke such a question." -- Charles Babbage 
