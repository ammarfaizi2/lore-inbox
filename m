Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263750AbREYOBn>; Fri, 25 May 2001 10:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263753AbREYOBd>; Fri, 25 May 2001 10:01:33 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:44148 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263750AbREYOBX>; Fri, 25 May 2001 10:01:23 -0400
Date: Fri, 25 May 2001 17:01:08 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: 2.4.4ac17 + LVM-0.9.1beta7: Oops on unmount initrd
Message-ID: <20010525170108.B11709@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I try to boot with root on LVM (using initrd), I get an oops. The
oops happens right after (trying to) unmount old (initrd) root. It also
happens when I run it with root=/dev/sdb (which is a plain ext2fs with no
LVM involved, other than the lvmcreate_initrd-generated initrd).

I patched 2.4.4ac17 with LVM-0.9.1beta7; (the generated patch applied clean
other than that I had to add int get_hardblocksize(kdev_t) {} to fs/buffer.c
(seems to have been removed somewhere between 2.4.1 and 2.4.4). I also tried
2.4.4ac17 vanilla and 2.4.4ac15 vanilla with the same results.

Which is the recommended kernel/LVM version to be used at this time?

Below is the oops and the ksymoops output (gathered by hand, please excuse
possible typos):

(...)
vgscan -- reading all physical volumes (this may take a while...)
vgscan -- found inactive volume group "root-stripe"
vgscan -- "/etc/lvmtab" and "/etc/lvmtab.d" succesfully created
vgscan -- WARNING: This program does not do a VGDA backup of your volume
group
vgchange -- volume group "root-stripe" successfully activated

VFS: Mounted root (ext2 filesystem).
Trying to unmount old root ... (1)Unable to handle kernel NULL pointer
dereferen
ce at virtual address 00000013
  printing eip:
c01997f6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02997f6>]
EFLAGS: 00010202
eax: 00000003   ebx: 00001261  ecx: 00000000   edx: cfff3d78
esi: 00000000   edi: c15d3160  ebp: 00000000   esp: cfff3d58
ds: 0018  es: 0018  ss:  0018
Process swapper (pid: 1, stackpage cfff3000)
Stack: cfff2000 ffffffff c15d3160 c0136447 cfff3d78 00000000 00001261 00000000
       c0258528 c017fec3 cfff3d94 cfff3d94 00000000 c0228769 cfffa320 c02b5e6c
       c02b5e6c c011b0f6 00000001 c011b304 00000001 00000000 c02a0100 00000000

Call trace: [<c0136447>] [<c017fec3>] [<c0118769>] [<c011b0f6>] [<c011b304>]
    [<c011868c>] [<c0118596>] [<c011849b>] [<c010832f>] [<c0106f14>] [<c0199756>]
    [<c01330d6>] [<c0131447>] [<c0122cf5>] [<c01416db>] [<c0142b81>] [<c0136641>]
    [<c013484a>] [<c0134ab0>] [<c0105000>] [<c01177e6>] [<c0105000>] [<c01051da>]
    [<c010520e>] [<c0105000>] [<c01056a6>] [<c0105200>]

Code: 8b 40 10 83 f8 02 7e 62 b8 f0 ff ff ff eb 74 85 c9 b8 ea ff
 <0>Kernel panic: attempted to kill init!



ksymoops -o /lib/modules/2.4.4-ac17/ -m /usr/src/linux/System.map 
 -v ./vmlinux -K -L  < /root/herkules-oops.txt
ksymoops 2.4.1 on i686 2.4.2-2.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.4-ac17/ (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Trying to unmount old root ... (1)Unable to handle kernel NULL pointer
dereferen
c01997f6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02997f6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000003   ebx: 00001261  ecx: 00000000   edx: cfff3d78
esi: 00000000   edi: c15d3160  ebp: 00000000   esp: cfff3d58
ds: 0018  es: 0018  ss:  0018
Stack: cfff2000 ffffffff c15d3160 c0136447 cfff3d78 00000000 00001261 00000000
       c0258528 c017fec3 cfff3d94 cfff3d94 00000000 c0228769 cfffa320 c02b5e6c
       c02b5e6c c011b0f6 00000001 c011b304 00000001 00000000 c02a0100 00000000
Call trace: [<c0136447>] [<c017fec3>] [<c0118769>] [<c011b0f6>] [<c011b304>]
    [<c011868c>] [<c0118596>] [<c011849b>] [<c010832f>] [<c0106f14>] [<c0199756>]
    [<c01330d6>] [<c0131447>] [<c0122cf5>] [<c01416db>] [<c0142b81>] [<c0136641>]
    [<c013484a>] [<c0134ab0>] [<c0105000>] [<c01177e6>] [<c0105000>] [<c01051da>]
    [<c010520e>] [<c0105000>] [<c01056a6>] [<c0105200>]
Code: 8b 40 10 83 f8 02 7e 62 b8 f0 ff ff ff eb 74 85 c9 b8 ea ff

>>EIP; c02997f6 <__devices_1045+5a/a8>   <=====
Trace; c0136447 <ioctl_by_bdev+77/90>
Trace; c017fec3 <batch_entropy_process+b3/c0>
Trace; c0118769 <__run_task_queue+49/60>
Trace; c011b0f6 <update_wall_time+16/50>
Trace; c011b304 <timer_bh+24/250>
Trace; c011868c <bh_action+1c/60>
Trace; c0118596 <tasklet_hi_action+36/60>
Trace; c011849b <do_softirq+5b/80>
Trace; c010832f <do_IRQ+9f/b0>
Trace; c0106f14 <ret_from_intr+0/20>
Trace; c0199756 <rd_make_request+d6/100>
Trace; c01330d6 <try_to_free_buffers+f6/140>
Trace; c0131447 <getblk+e7/100>
Trace; c0122cf5 <truncate_list_pages+145/170>
Trace; c01416db <destroy_inode+1b/20>
Trace; c0142b81 <iput+121/130>
Trace; c0136641 <blkdev_put+71/a0>
Trace; c013484a <kill_super+da/100>
Trace; c0134ab0 <do_umount+e0/f0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01177e6 <sys_waitpid+16/20>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01051da <prepare_namespace+fa/120>
Trace; c010520e <init+e/140>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01056a6 <kernel_thread+26/30>
Trace; c0105200 <init+0/140>
Code;  c02997f6 <__devices_1045+5a/a8>
00000000 <_EIP>:
Code;  c02997f6 <__devices_1045+5a/a8>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c02997f9 <__devices_1045+5d/a8>
   3:   83 f8 02                  cmp    $0x2,%eax
Code;  c02997fc <__devices_1045+60/a8>
   6:   7e 62                     jle    6a <_EIP+0x6a> c0299860
<__devices_104a
+c/20>
Code;  c02997fe <__devices_1045+62/a8>
   8:   b8 f0 ff ff ff            mov    $0xfffffff0,%eax
Code;  c0299803 <__devices_1045+67/a8>
   d:   eb 74                     jmp    83 <_EIP+0x83> c0299879
<__devices_104b
+5/18>
Code;  c0299805 <__devices_1045+69/a8>
   f:   85 c9                     test   %ecx,%ecx
Code;  c0299807 <__devices_1045+6b/a8>
  11:   b8 ea ff 00 00            mov    $0xffea,%eax


-- v --

v@iki.fi
