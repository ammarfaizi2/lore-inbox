Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRLMMTP>; Thu, 13 Dec 2001 07:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRLMMTF>; Thu, 13 Dec 2001 07:19:05 -0500
Received: from mail.advfn.com ([212.161.99.149]:6161 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S283782AbRLMMTC>;
	Thu, 13 Dec 2001 07:19:02 -0500
Message-Id: <200112131218.fBDCIuv03741@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: CML2 <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at boot (kernel NULL pointer deref)
Date: Thu, 13 Dec 2001 12:16:42 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-- 
Randy,
        sorry about the delay, actually had 2 days holiday!! Here's the oops 
report 
from ksymoops, kernel version 2.4.14.

Best Wishes,

Tim

Reading Oops report from the terminal
c01fe566
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01fe566>]    Not tainted
EFLAGS: 00010202
eax: 00000246   ebx: dfe52200   ecx: df1cae00   edx: 00000246
esi: d0d21000   edi: 000001be   ebp: 000002bc   esp: d3d17f24
ds: 0018   es: 0018   ss: 0018
Process sadc (pid: 18159, stackpage=d3d17000)
Stack: 00000000 dfe52200 c01fe674 d0d21000 dfe52200 000002bc 00000c00 00001000
       d0d21000 c015ff94 d0d21000 d3d17f68 000002bc 00000c00 c18f0960 00000000
       00000000 00000000 d9d02960 ffffffea 00000000 40017000 c013e296 d9d02960
Call Trace: [<c01fe674>] [<c015ff94>] [<c013e296>] [<c010758b>]

Code: 8b 42 58 50 8b 4a 44 8b 42 40 01 c8 8b 4a 50 01 c8 8b 4a 4c
 <3>APIC error on CPU0: 01(02)
c01fe566
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01fe566>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000246   ebx: dfe52200   ecx: df1cae00   edx: 00000246
esi: d0d21000   edi: 000001be   ebp: 000002bc   esp: d3d17f24
ds: 0018   es: 0018   ss: 0018
Process sadc (pid: 18159, stackpage=d3d17000)
Stack: 00000000 dfe52200 c01fe674 d0d21000 dfe52200 000002bc 00000c00 00001000
       d0d21000 c015ff94 d0d21000 d3d17f68 000002bc 00000c00 c18f0960 00000000
       00000000 00000000 d9d02960 ffffffea 00000000 40017000 c013e296 d9d02960
Call Trace: [<c01fe674>] [<c015ff94>] [<c013e296>] [<c010758b>]
Code: 8b 42 58 50 8b 4a 44 8b 42 40 01 c8 8b 4a 50 01 c8 8b 4a 4c

>>EIP; c01fe566 <sprintf_stats+26/c0>   <=====
Trace; c01fe674 <dev_get_info+74/c0>
Trace; c015ff94 <proc_file_read+94/190>
Trace; c013e296 <sys_read+96/d0>
Trace; c010758b <system_call+33/38>
Code;  c01fe566 <sprintf_stats+26/c0>
00000000 <_EIP>:
Code;  c01fe566 <sprintf_stats+26/c0>   <=====
   0:   8b 42 58                  mov    0x58(%edx),%eax   <=====
Code;  c01fe569 <sprintf_stats+29/c0>
   3:   50                        push   %eax
Code;  c01fe56a <sprintf_stats+2a/c0>
   4:   8b 4a 44                  mov    0x44(%edx),%ecx
Code;  c01fe56d <sprintf_stats+2d/c0>
   7:   8b 42 40                  mov    0x40(%edx),%eax
Code;  c01fe570 <sprintf_stats+30/c0>
   a:   01 c8                     add    %ecx,%eax
Code;  c01fe572 <sprintf_stats+32/c0>
   c:   8b 4a 50                  mov    0x50(%edx),%ecx
Code;  c01fe575 <sprintf_stats+35/c0>
   f:   01 c8                     add    %ecx,%eax
Code;  c01fe577 <sprintf_stats+37/c0>
  11:   8b 4a 4c                  mov    0x4c(%edx),%ecx




On Saturday 08 Dec 2001 00:04, rddunlap@osdl.org wrote:
> On Fri, 7 Dec 2001, Tim Kay wrote:
> | I've posted about this before but as we now have more debug I'll try
> | again. The apic thing is VERY worrying. We have 30+ Poweredges running
> | Linux and they all have trouble with apic
> | APIC error on CPU0: 02(02)
> | APIC error on CPU1: 01(02)
> | even with noapic set on boot up.
>
> Wow.  There was some email a few months back about some motherboards
> and/or chipsets with known problems similar to this.
> I'll see if I can find it.
>
> | /proc/interrupts says everythings using XT-PIC :
> |            CPU0       CPU1
> |   0:  242819123          0          XT-PIC  timer
> |   1:       1121          0          XT-PIC  keyboard
> |   2:          0          0          XT-PIC  cascade
> |   3:    9531664          0          XT-PIC  aic7xxx
> |   5:  874076356          0          XT-PIC  e100
> |  11:         16          0          XT-PIC  aic7xxx
> |  14:       1273          0          XT-PIC  ide0
> | NMI:          0          0
> | LOC:  242810985  242810942
> | ERR:       1967
> | MIS:          0
> | Now we have this as well, I assume it's related:
>
> I can't tell if it's related or not.
> Can you run this Oops message thru ksymoops and post that?
>
> | Unable to handle kernel NULL pointer dereference at virtual address
> | 0000029e printing eip:
> | c01fe566
> | *pde = 00000000
> | Oops: 0000
> | CPU:    0
> | EIP:    0010:[<c01fe566>]    Not tainted
> | EFLAGS: 00010202
> | eax: 00000246   ebx: dfe52200   ecx: df1cae00   edx: 00000246
> | esi: d0d21000   edi: 000001be   ebp: 000002bc   esp: d3d17f24
> | ds: 0018   es: 0018   ss: 0018
> | Process sadc (pid: 18159, stackpage=d3d17000)
> | Stack: 00000000 dfe52200 c01fe674 d0d21000 dfe52200 000002bc 00000c00
> | 00001000 d0d21000 c015ff94 d0d21000 d3d17f68 000002bc 00000c00 c18f0960
> | 00000000 00000000 00000000 d9d02960 ffffffea 00000000 40017000 c013e296
> | d9d02960 Call Trace: [<c01fe674>] [<c015ff94>] [<c013e296>] [<c010758b>]
> |
> | Code: 8b 42 58 50 8b 4a 44 8b 42 40 01 c8 8b 4a 50 01 c8 8b 4a 4c
> |  <3>APIC error on CPU0: 01(02)
> |
> | Strangely the machine is still responding although it always seemed to
> | die under heavy load before. Is this a problem with the Serverworks
> | m'board or the Dell BIOS or the kernel??
>
> Don't know...
>
> Regards,

----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
timk@advfn.com
Tel: 020 7070 0941
Fax: 020 7070 0959
