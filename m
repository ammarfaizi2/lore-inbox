Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313166AbSC1OdL>; Thu, 28 Mar 2002 09:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313165AbSC1OdE>; Thu, 28 Mar 2002 09:33:04 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:43669 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313164AbSC1Oc5>; Thu, 28 Mar 2002 09:32:57 -0500
Message-Id: <5.1.0.14.2.20020328142625.00ab1b10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 28 Mar 2002 14:33:38 +0000
To: Andre Hedrick <andre@linux-ide.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: LinuxATADeveloment-2.5.7.patch
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10203272351240.6661-300000@master.linux-ide.
 org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:57 28/03/02, Andre Hedrick wrote:

>Anton, please try to break it :-/

I did. )-: There is no change in behaviour to the previous patch for 2.5.7 
you sent out. Still lost interrupts and eventually kernel crash due to NULL 
pointer dereference.

I typed out the oops and decoded it later, you will find it at bottom of 
this email. I hope it helps you to find why that is being triggered.

Just as a very random idea: is it possible the kernel logic is trying to 
upgrade PIO to DMA (even though I haven't configured the kernel with dma 
support in it!) which causes the lost interrupts and for some reason it all 
dies from there, i.e. it never manages to enter PIO successfully again?

>If this is fixed, I am out of 2.5 until I can fix BLOCK to allow for
>in process bio walking.

Unfortunately still broken. )-:

Best regards,

         Anton

---decoded oops---
ksymoops 2.3.7 on i586 2.5.6.  Options used
      -V (default)
      -K (specified)
      -L (specified)
      -o /lib/modules/2.5.7 (specified)
      -m /boot/System.map-2.5.7 (specified)
No modules in ksyms, skipping objects
c01e25e1
*pde = 00000000
Oops: 8000
CPU: 0
EIP: 0010:[<c01e25e1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: c10f4200 ebx: 00000000 ecx: c037c6e4 edx: 00000001
esi: 00000000 edi: c037c6e4 ebp: 00000246 esp: c10dbe04
ds: 0018 es: 0018 ss: 0018
Call Trace: [<c01e62a1>] [<c01e1151>] [<c01e1a7a>] [<c01e1a10>] [<c01e0f00>]
[<c01e12c5>] [<c01ea05b>] [<c01e1a10>] [<c01e0f00>] [<c01e37ac>] [<c01e3aa6>]
[<c01e3f00>] [<c01e3f8f>] [<c01d1c7d>] [<c011aa08>] [<c0138876>] [<c0139a65>]
[<c0138b06>] [<c013bcc2>] [<c0105686>] [<c013bbe0>]
Code: 8b 43 1c c1 e8 05 83 f0 01 83 e0 01 74 08 0f 0b 7c 01 ba da
 >>EIP; c01e25e1 <__ide_end_request+31/100>   <=====
Trace; c01e62a1 <ide_end_request+11/20>
Trace; c01e1151 <task_mulout_intr+251/2b0>
Trace; c01e1a7a <pre_task_mulout_intr+6a/70>
Trace; c01e1a10 <pre_task_mulout_intr+0/70>
Trace; c01e0f00 <task_mulout_intr+0/2b0>
Trace; c01e12c5 <do_rw_taskfile+115/150>
Trace; c01ea05b <lba28_do_request+cb/e0>
Trace; c01e1a10 <pre_task_mulout_intr+0/70>
Trace; c01e0f00 <task_mulout_intr+0/2b0>
Trace; c01e37ac <ide_wait_stat+bc/110>
Trace; c01e3aa6 <start_request+136/1c0>
Trace; c01e3f00 <ide_do_request+340/390>
Trace; c01e3f8f <do_ide_request+f/20>
Trace; c01d1c7d <generic_unplug_device+2d/60>
Trace; c011aa08 <__run_task_queue+68/80>
Trace; c0138876 <__wait_on_buffer+56/90>
Trace; c0139a65 <__refile_buffer+55/60>
Trace; c0138b06 <wait_for_buffers+86/c0>
Trace; c013bcc2 <kupdate+e2/1a0>
Trace; c0105686 <kernel_thread+26/30>
Trace; c013bbe0 <kupdate+0/1a0>
Code;  c01e25e1 <__ide_end_request+31/100>
00000000 <_EIP>:
Code;  c01e25e1 <__ide_end_request+31/100>   <=====
    0:   8b 43 1c                  mov    0x1c(%ebx),%eax   <=====
Code;  c01e25e4 <__ide_end_request+34/100>
    3:   c1 e8 05                  shr    $0x5,%eax
Code;  c01e25e7 <__ide_end_request+37/100>
    6:   83 f0 01                  xor    $0x1,%eax
Code;  c01e25ea <__ide_end_request+3a/100>
    9:   83 e0 01                  and    $0x1,%eax
Code;  c01e25ed <__ide_end_request+3d/100>
    c:   74 08                     je     16 <_EIP+0x16> c01e25f7 
<__ide_end_request+47/100>
Code;  c01e25ef <__ide_end_request+3f/100>
    e:   0f 0b                     ud2a
Code;  c01e25f1 <__ide_end_request+41/100>
   10:   7c 01                     jl     13 <_EIP+0x13> c01e25f4 
<__ide_end_request+44/100>
Code;  c01e25f3 <__ide_end_request+43/100>
   12:   ba da 00 00 00            mov    $0xda,%edx



-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

