Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSIHQ7n>; Sun, 8 Sep 2002 12:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSIHQ7n>; Sun, 8 Sep 2002 12:59:43 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:63431 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317170AbSIHQ7l>;
	Sun, 8 Sep 2002 12:59:41 -0400
To: Alan Cox <alan@redhat.com>
Cc: bunk@fs.tum.de (Adrian Bunk), hpj@urpla.net (Hans-Peter Jansen),
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac4
References: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 08 Sep 2002 19:03:55 +0200
In-Reply-To: <200209081255.g88CtHJ31280@devserv.devel.redhat.com>
Message-ID: <m3bs789zwk.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > problem reproducible without any non-free module loaded _ever_ since the
> > last reboot?
> 
> I've seen this trace without nvidia etc loaded too. Right now the problem
> I have is that I can't duplicate it. If my box would jut blow up the same
> way all would be well 8)
> 
> What compilers are being used by the folks who see the problem ?

Here we go, 2.4.20-pre-ac4, same crash, this time there's no vmware
and no preempt:

lapper:~$ ksymoops < oops.2 itten
ksymoops 2.4.5 on i686 2.4.20-pre5-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre5-ac4/ (default)
     -m /boot/System.map-2.4.20-pre5-ac4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at /home/alexh/src/linux/linux/include/linux/blkdev.h:153!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01ec1d8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000059   ebx: 00000000   ecx: e5adf680   edx: 00000001
esi: c031d824   edi: 00000000   ebp: e5adf680   esp: ea3cdb5c
ds: 0018   es: 0018   ss: 0018
Process cdrecord (pid: 1880, stackpage=ea3cd000)
Stack: 00000001 00000046 c02f7380 c02ef900 00000000 efdb8000 efdbb000 c031d824 
       00000000 e5adf680 c01ec52c c031d774 e5adf680 c01da93b 00000000 c031d774 
       c031d774 c031d824 e5adf680 e5adf680 c01ecbf7 c031d824 e5adf680 e813aa80 
Call Trace:    [<c01ec52c>] [<c01da93b>] [<c01ecbf7>] [<f092eab4>] [<c01e0801>]
  [<c01e097b>] [<c01e1040>] [<f092f6d1>] [<f09127a4>] [<f09198b0>] [<f0919620>]
  [<f091b3ee>] [<f091a828>] [<f091a8b8>] [<f0912aab>] [<f4d45320>] [<f4d44134>]
  [<f4d45320>] [<f4d43e7b>] [<f4d44c00>] [<c0138a05>] [<c013bd3d>] [<c01b0f5b>]
  [<c01ad3f0>] [<c01ac8dd>] [<c01ad1ff>] [<c01ae9a1>] [<c01acf6b>] [<c01aa72d>]
  [<c01ae840>] [<c014e9a3>] [<c0108fef>]
Code: 0f 0b 99 00 20 11 2a c0 ba ff ff ff ff 31 c0 85 d2 8b 74 24 


>>EIP; c01ec1d8 <ide_build_sglist+48/1d0>   <=====

>>ecx; e5adf680 <_end+257bb9c4/305373a4>
>>esi; c031d824 <ide_hwifs+524/2c88>
>>ebp; e5adf680 <_end+257bb9c4/305373a4>
>>esp; ea3cdb5c <_end+2a0a9ea0/305373a4>

Trace; c01ec52c <ide_build_dmatable+4c/1a0>
Trace; c01da93b <ata_output_data+fb/100>
Trace; c01ecbf7 <__ide_dma_write+37/140>
Trace; f092eab4 <[ide-scsi]idescsi_issue_pc+74/210>
Trace; c01e0801 <start_request+1b1/230>
Trace; c01e097b <ide_do_request+ab/1a0>
Trace; c01e1040 <ide_do_drive_cmd+b0/100>
Trace; f092f6d1 <[ide-scsi]idescsi_queue+1a1/2c0>
Trace; f09127a4 <[scsi_mod]scsi_dispatch_cmd+204/370>
Trace; f09198b0 <[scsi_mod]scsi_old_done+0/640>
Trace; f0919620 <[scsi_mod]scsi_old_times_out+0/140>
Trace; f091b3ee <[scsi_mod]scsi_request_fn+19e/360>
Trace; f091a828 <[scsi_mod]__scsi_insert_special+58/80>
Trace; f091a8b8 <[scsi_mod]scsi_insert_special_req+28/30>
Trace; f0912aab <[scsi_mod]scsi_do_req+eb/1d0>
Trace; f4d45320 <[sg]sg_cmd_done_bh+0/360>
Trace; f4d44134 <[sg]sg_common_write+1f4/280>
Trace; f4d45320 <[sg]sg_cmd_done_bh+0/360>
Trace; f4d43e7b <[sg]sg_new_write+1eb/2b0>
Trace; f4d44c00 <[sg]sg_ioctl+a40/c10>
Trace; c0138a05 <__get_free_pages+45/50>
Trace; c013bd3d <shmem_getpage_locked+2ed/310>
Trace; c01b0f5b <pty_write+14b/150>
Trace; c01ad3f0 <opost_block+e0/180>
Trace; c01ac8dd <tty_default_put_char+2d/40>
Trace; c01ad1ff <opost+9f/1b0>
Trace; c01ae9a1 <write_chan+161/220>
Trace; c01acf6b <do_tty_write+db/134>
Trace; c01aa72d <tty_write+fd/130>
Trace; c01ae840 <write_chan+0/220>
Trace; c014e9a3 <sys_ioctl+c3/240>
Trace; c0108fef <system_call+33/38>

Code;  c01ec1d8 <ide_build_sglist+48/1d0>
00000000 <_EIP>:
Code;  c01ec1d8 <ide_build_sglist+48/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01ec1da <ide_build_sglist+4a/1d0>
   2:   99                        cltd   
Code;  c01ec1db <ide_build_sglist+4b/1d0>
   3:   00 20                     add    %ah,(%eax)
Code;  c01ec1dd <ide_build_sglist+4d/1d0>
   5:   11 2a                     adc    %ebp,(%edx)
Code;  c01ec1df <ide_build_sglist+4f/1d0>
   7:   c0 ba ff ff ff ff 31      sarb   $0x31,0xffffffff(%edx)
Code;  c01ec1e6 <ide_build_sglist+56/1d0>
   e:   c0 85 d2 8b 74 24 00      rolb   $0x0,0x24748bd2(%ebp)


1 warning issued.  Results may not be reliable.
lapper:~$ 

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
