Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbRE1IwN>; Mon, 28 May 2001 04:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbRE1IwD>; Mon, 28 May 2001 04:52:03 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:31822 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263012AbRE1Ivn>; Mon, 28 May 2001 04:51:43 -0400
Date: Mon, 28 May 2001 11:51:26 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: initrd oops; still happens with 2.4.5ac2
Message-ID: <20010528115125.O11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi> <20010528001220.M11981@niksula.cs.hut.fi> <20010528102551.N11981@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528102551.N11981@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Mon, May 28, 2001 at 10:25:51AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 10:25:51AM +0300, [Ville Herva] claimed:
> On Mon, May 28, 2001 at 12:12:20AM +0300, [Ville Herva] claimed:
> > On Sun, May 27, 2001 at 07:26:50PM +0300, [Ville Herva] claimed:
> > > 
> > > I have a reproducible oops on 2.4.4ac17 at initrd unmount (see
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2 for
> > > details) that seems to be related:
> > 
> > Ok, some more info:                                                             
> >                                                                                 
> > 2.4.2-2 (redhat)       BOOTS OK                                                 
> > 2.4.4ac17              OOPS                                                     
> > 2.4.4ac17+av           OOPS                                                     
> > 2.4.5                  OOPS                                                     
> > 2.4.5ac1+av            OOPS                                                     
> > 2.4.4                  BOOTS OK                                                 
> > 2.4.4ac9               BOOTS OK                                                 
> > 2.4.4ac10              BOOTS OK                                                 
> > 2.4.4ac11              BOOTS OK                                                 
> > 2.4.4ac12              fails to mount root ("Checking root filesystem.          
> >                                              /dev/sdb is mounted.")             
> > 2.4.4ac14              fails to mount root                                      
> > 2.4.4ac15              OOPS                                                     
> 
> 2.4.5ac2                 OOPS

Here is the ksymoops output for the 2.4.5ac2 initrd umount OOPS:

----------------------------------------------------------------------------
ksymoops 2.4.1 on i686 2.4.4-ac11.  Options used
     -v vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -O (specified)
     -m ./System.map (specified)

No ksyms, skipping lsmod
Trying to unmount old root ... <1>Unable to handle kernel NULL pointer
dereference at virtual address 0000001e
c0199a96
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0199a96>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0000000e   ebx: 00001261   ecx: 00000000   edx: cfff5d64
esi: 00000000   edi: c15dc4a0   ebp: c15d5160   esp: cfff5d44
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=cfff5000)
Stack: cfff4000 ffffffff c15dc4a0 c0136427 cfff5d64 00000000 00001261
00000000
       c15edc00 00000000 00000046 c1462000 c01be02a c1462000 00000046
00000246
       c0267b20 c1467f60 c15edc00 c01ae171 c15edc00 00000246 00000100
c15edc00
Call Trace: [<c0136427>] [<c01be02a>] [<c01ae171>] [<c01b488c>] [<c0112600>]
   [<c011b230>] [<c011b543>] [<c011b0e6>] [<c011b2f4>] [<c011867c>]
[<c0118586>]   [<c011848b>] [<c0133106>] [<c0122d15>] [<c014170b>]
[<c0142bb1>] [<c0136621>]   [<c01347ec>] [<c0105000>] [<c01177d6>]
[<c0105000>] [<c01051da>] [<c010520e>]   [<c0105000>] [<c01056a6>]
[<c0105200>]
Code: 8b 40 10 83 f8 02 7e 62 b8 f0 ff ff ff eb 74 85 c9 b8 ea ff

>>EIP; c0199a96 <rd_ioctl+76/100>   <=====
Trace; c0136427 <ioctl_by_bdev+77/90>
Trace; c01be02a <sym53c8xx_queue_command+4a/80>
Trace; c01ae171 <scsi_dispatch_cmd+111/160>
Trace; c01b488c <scsi_request_fn+2cc/310>
Trace; c0112600 <schedule+220/350>
Trace; c011b230 <update_process_times+20/80>
Trace; c011b543 <do_timer+23/a0>
Trace; c011b0e6 <update_wall_time+16/50>
Trace; c011b2f4 <timer_bh+24/250>
Trace; c011867c <bh_action+1c/60>
Trace; c0118586 <tasklet_hi_action+36/60>
Trace; c011848b <do_softirq+5b/80>
Trace; c0133106 <try_to_free_buffers+f6/140>
Trace; c0122d15 <truncate_list_pages+145/170>
Trace; c014170b <destroy_inode+1b/20>
Trace; c0142bb1 <iput+121/130>
Trace; c0136621 <blkdev_put+71/a0>
Trace; c01347ec <kill_super+ec/100>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01177d6 <sys_waitpid+16/20>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01051da <prepare_namespace+fa/120>
Trace; c010520e <init+e/140>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c01056a6 <kernel_thread+26/30>
Trace; c0105200 <init+0/140>
Code;  c0199a96 <rd_ioctl+76/100>
00000000 <_EIP>:
Code;  c0199a96 <rd_ioctl+76/100>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c0199a99 <rd_ioctl+79/100>
   3:   83 f8 02                  cmp    $0x2,%eax
Code;  c0199a9c <rd_ioctl+7c/100>
   6:   7e 62                     jle    6a <_EIP+0x6a> c0199b00
<rd_ioctl+e0/100>
Code;  c0199a9e <rd_ioctl+7e/100>
   8:   b8 f0 ff ff ff            mov    $0xfffffff0,%eax
Code;  c0199aa3 <rd_ioctl+83/100>
   d:   eb 74                     jmp    83 <_EIP+0x83> c0199b19
<rd_ioctl+f9/100>
Code;  c0199aa5 <rd_ioctl+85/100>
   f:   85 c9                     test   %ecx,%ecx
Code;  c0199aa7 <rd_ioctl+87/100>
  11:   b8 ea ff 00 00            mov    $0xffea,%eax

 <0>Kernel panic: Attempted to kill init!
----------------------------------------------------------------------------

And here is another ksymoopsed OOPS with the same kernel, but booting from
/dev/sdc (on megaraid) with grub:

----------------------------------------------------------------------------
ksymoops 2.4.1 on i686 2.4.4-ac11.  Options used
     -v vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -O (specified)
     -m ./System.map (specified)

No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000001f
c014259a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014259a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: ffffffff   ecx: 0000ffff   edx: 00000000
esi: ffffffff   edi: 00000001   ebp: f7fbec80   esp: c026ff10
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c026f000)
Stack: c025b3c0 f7fbec80 00000001 c1eef000 c0142995 c1eef000 00000001
f7fbec80
       00000000 00000000 00000005 c1eef000 c012a492 00000007 c025b3c0
00000001
       00000000 c025b300 c0145c60 c1eef000 00000001 00000000 00000000
c1eef000
Call Trace: [<c0142995>] [<c012a492>] [<c0145c60>] [<c0145d4c>] [<c01343e2>]
   [<c01348ff>] [<c0105000>] [<c0100197>]
Code: 39 7e 20 75 f1 8b 44 24 14 39 86 90 00 00 00 75 e5 8b 54 24

>>EIP; c014259a <find_inode+1a/50>   <=====
Trace; c0142995 <iget4+45/d0>
Trace; c012a492 <__alloc_pages+62/230>
Trace; c0145c60 <proc_get_inode+40/100>
Trace; c0145d4c <proc_read_super+2c/b0>
Trace; c01343e2 <read_super+62/b0>
Trace; c01348ff <kern_mount+4f/b0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c0100197 <L6+0/2>
Code;  c014259a <find_inode+1a/50>
00000000 <_EIP>:
Code;  c014259a <find_inode+1a/50>   <=====
   0:   39 7e 20                  cmp    %edi,0x20(%esi)   <=====
Code;  c014259d <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c0142590
<find_inode+10/50>
Code;  c014259f <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425a3 <find_inode+23/50>
   9:   39 86 90 00 00 00         cmp    %eax,0x90(%esi)
Code;  c01425a9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c0142590
<find_inode+10/50>
Code;  c01425ab <find_inode+2b/50>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx

 <0>Kernel panic: Attempted to kill the idle task!
----------------------------------------------------------------------------

The bootlog for initrd umount case is at 
http://v.iki.fi/~vherva/tmp/bootlog.initrd
the corresponding ksymoops:
http://v.iki.fi/~vherva/tmp/ksymoops-initrd

and the same for the grub:
http://v.iki.fi/~vherva/tmp/bootlog.grub
http://v.iki.fi/~vherva/tmp/ksymoops-grub

and the .config for both:

http://v.iki.fi/~vherva/tmp/.config


Note that 2.4.4 and 2.4.2-2 boot ok in both cases.


-- v --

v@iki.fi
