Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135764AbRDTASZ>; Thu, 19 Apr 2001 20:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135765AbRDTASQ>; Thu, 19 Apr 2001 20:18:16 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:31237 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S135764AbRDTAR6>; Thu, 19 Apr 2001 20:17:58 -0400
Message-ID: <3ADF802A.1043DB0F@delusion.de>
Date: Fri, 20 Apr 2001 02:17:46 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
In-Reply-To: <E14qNWF-0008Jc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Just built 2.4.3-ac10 and got an oops when booting. It tries to detect
> > the CD and gives the oops.

I'm getting a similar oops with -ac10. I initially thought this might be
a result of switching to gcc-2.95.3, because -ac9 runs fine when built
with gcc-2.95.2, but if others have seen this too, it's probably the
cdrom code indeed.

> Can you back out the ide-cd changes Jens did and see if that fixes it ?

I'll try that tomorrow, too.

Regards,
Udo.

--

ksymoops 2.3.7 on i686 2.4.3-ac9.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-ac10 (specified)
     -m /boot/System.map-2.4.3-ac10 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01b9bac>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: 0000000d  ebx: ffffffff  ecx: 00000000  edx: 00000000
esi: 00000000  edi: c1469ae8  ebp: 00000021  ebp: cffe5ee0
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 1, stackpage=cffe5000)
Stack: c0276018 c0275fb4 c01b9dbf c1469a00 c02e31f4 c1469b18 c02e3100 00000001
       00000286 00000001 00000001 c0113623 c02b5fe1 00000246 c0113574 c0244e02
       c0244e9d c1469a00 c02e3100 c01b91cb c02448ec c02e3100 c1469037 c0244fc0
Call Trace: [<c01b9dbf>] [<c0113623>] [<c0113574>] [<c01b91cb>] [<c01b8d0c>]
            [<c01b976a>] [<c01b9af1>] [<c0105007>] [<c0105488>]
Code: 8b 04 8a 83 f8 ff 75 0c 83 c6 20 eb e7 8d b4 26 00 00 00 00
 
>>EIP; c01b9bac <cdrom_get_entry+1c/50>   <=====
Trace; c01b9dbf <register_cdrom+1bf/250>
Trace; c0113623 <release_console_sem+73/80>
Trace; c0113574 <printk+124/130>
Trace; c01b91cb <ide_cdrom_probe_capabilities+3eb/400>
Trace; c01b8d0c <ide_cdrom_register+13c/150>
Trace; c01b976a <ide_cdrom_setup+49a/4e0>
Trace; c01b9af1 <ide_cdrom_init+e1/180>
Trace; c0105007 <init+7/110>
Trace; c0105488 <kernel_thread+28/40>
Code;  c01b9bac <cdrom_get_entry+1c/50>
00000000 <_EIP>:
Code;  c01b9bac <cdrom_get_entry+1c/50>   <=====
   0:   8b 04 8a                  movl   (%edx,%ecx,4),%eax   <=====
Code;  c01b9baf <cdrom_get_entry+1f/50>
   3:   83 f8 ff                  cmpl   $0xffffffff,%eax
Code;  c01b9bb2 <cdrom_get_entry+22/50>
   6:   75 0c                     jne    14 <_EIP+0x14> c01b9bc0 <cdrom_get_entry+30/50>
Code;  c01b9bb4 <cdrom_get_entry+24/50>
   8:   83 c6 20                  addl   $0x20,%esi
Code;  c01b9bb7 <cdrom_get_entry+27/50>
   b:   eb e7                     jmp    fffffff4 <_EIP+0xfffffff4> c01b9ba0 <cdrom_get_entry+10/50>
Code;  c01b9bb9 <cdrom_get_entry+29/50>
   d:   8d b4 26 00 00 00 00      leal   0x0(%esi,1),%esi
 
<0>Kernel panic: Attempted to kill init!
