Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRIZLTY>; Wed, 26 Sep 2001 07:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274307AbRIZLTO>; Wed, 26 Sep 2001 07:19:14 -0400
Received: from Prins.externet.hu ([212.40.96.161]:19477 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S273269AbRIZLSz>; Wed, 26 Sep 2001 07:18:55 -0400
Message-ID: <3BB1BA32.1060105@externet.hu>
Date: Wed, 26 Sep 2001 13:21:22 +0200
From: Boszormenyi Zoltan <zboszor@externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010815
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sym53c8xx driver bug in 2.4.10
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried the latest XINE dvd player and as soon as it wanted
to decrypt a DVD, it caused an oops in the kernel.
After patching the kernel with sym-2.1.13-for-linux-2.4.9.patch.gz
the oops did not appear and I was able to play my DVDs.

For the record, the oops happened on vanilla 2.4.10,
2.4.10 + preempt, 2.4.10 + preempt + block-highmem-all-15,
and 2.4.10 + 00_vm-tweaks-1 + preempt + block-highmem-all-15.
The oops I saved was from the last combination. From these oopses,
I got the idea that the in-kernel sym53c8xx driver has a small bug
which the sym2 driver patch eliminated.

Best regards,
Zoltan Boszormenyi

Sep 25 20:30:16 localhost kernel: Unable to handle kernel NULL pointer 
derefere
Sep 25 20:30:16 localhost kernel: d1a2b523
Sep 25 20:30:16 localhost kernel: *pde = 00000000
Sep 25 20:30:16 localhost kernel: Oops: 0000
Sep 25 20:30:16 localhost kernel: CPU:    0
Sep 25 20:30:16 localhost kernel: EIP:    0010:[<d1a2b523>]
Sep 25 20:30:16 localhost kernel: EFLAGS: 00210202
Sep 25 20:30:16 localhost kernel: eax: 000001fc   ebx: 00000000   ecx: 
0000007f
Sep 25 20:30:16 localhost kernel: esi: 00000000   edi: c009ea00   ebp: 
c009e000
Sep 25 20:30:16 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep 25 20:30:16 localhost kernel: Process xine (pid: 1203, 
stackpage=c4aaf000)
Sep 25 20:30:16 localhost kernel: Stack: 00000000 c009ea00 c02a4a00 
00000000 00
Sep 25 20:30:16 localhost kernel:        c3a26200 00000000 0000016c 
d1a2b75f c3
Sep 25 20:30:16 localhost kernel:        d1a2e420 ca17aa20 ca17aa20 
d1a236e8 c3
Sep 25 20:30:16 localhost kernel: Call Trace: [<d1a2b75f>] [<d1a2e420>] 
[<d1a23
Sep 25 20:30:16 localhost kernel: Call Trace: [<d1a2b75f>] [<d1a2e420>] 
[<d1a23
Sep 25 20:30:16 localhost kernel:    [<c011f881>] [<c013da42>] 
[<c0184ef2>] [<c
Sep 25 20:30:16 localhost kernel:    [<c013d47e>] [<c013c04c>] 
[<c013c0d7>] [<c
Sep 25 20:30:16 localhost kernel: Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 
01 a4

 >>EIP; d1a2b523 <[sr_mod]sr_scatter_pad+1b3/2e0>   <=====
Trace; d1a2b75f <[sr_mod]sr_init_command+10f/260>
Trace; d1a2e420 <[sr_mod]sr_template+0/0>
Trace; d1a236e8 <[scsi_mod]scsi_request_fn+328/410>
Trace; d1a2e420 <[sr_mod]sr_template+0/0>
Trace; d1a2b75f <[sr_mod]sr_init_command+10f/260>
Trace; d1a2e420 <[sr_mod]sr_template+0/0>
Trace; d1a236e8 <[scsi_mod]scsi_request_fn+328/410>
Trace; d1a2e420 <[sr_mod]sr_template+0/0>
Trace; c019ab86 <generic_unplug_device+36/70>
Trace; c011f881 <__run_task_queue+81/90>
Trace; c013da42 <write_unlocked_buffers+52/60>
Trace; c0184ef2 <write_chan+1d2/1f0>
Trace; c013db94 <sync_buffers+14/40>
Trace; c01458ae <__block_fsync+1e/40>
Trace; c01462d3 <blkdev_put+63/1a0> 
Trace; c013d47e <fput+4e/120>
Trace; c013c04c <filp_close+ac/c0>
Trace; c013c0d7 <sys_close+77/b0>
Trace; c01071ab <system_call+33/38>
Code;  d1a2b523 <[sr_mod]sr_scatter_pad+1b3/2e0>
00000000 <_EIP>:
Code;  d1a2b523 <[sr_mod]sr_scatter_pad+1b3/2e0>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  d1a2b525 <[sr_mod]sr_scatter_pad+1b5/2e0>
   2:   a8 02                     test   $0x2,%al
Code;  d1a2b527 <[sr_mod]sr_scatter_pad+1b7/2e0>
   4:   74 02                     je     8 <_EIP+0x8> d1a2b52b 
<[sr_mod]sr_scat
Code;  d1a2b529 <[sr_mod]sr_scatter_pad+1b9/2e0>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  d1a2b52b <[sr_mod]sr_scatter_pad+1bb/2e0>
   8:   a8 01                     test   $0x1,%al
Code;  d1a2b52d <[sr_mod]sr_scatter_pad+1bd/2e0>
   a:   74 01                     je     d <_EIP+0xd> d1a2b530 
<[sr_mod]sr_scat
Code;  d1a2b52f <[sr_mod]sr_scatter_pad+1bf/2e0>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  d1a2b530 <[sr_mod]sr_scatter_pad+1c0/2e0>
   d:   8b 54 24 30               mov    0x30(%esp,1),%edx
Code;  d1a2b534 <[sr_mod]sr_scatter_pad+1c4/2e0>
  11:   0f b7 82 00 00 00 00      movzwl 0x0(%edx),%eax

 


