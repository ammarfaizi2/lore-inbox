Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSHHINH>; Thu, 8 Aug 2002 04:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSHHINH>; Thu, 8 Aug 2002 04:13:07 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:7821 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S316587AbSHHING>; Thu, 8 Aug 2002 04:13:06 -0400
Date: Thu, 8 Aug 2002 10:16:35 +0200
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
Message-ID: <20020808081635.GL23816@os.inf.tu-dresden.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20020807162932.GH23816@os.inf.tu-dresden.de> <1028746623.18156.328.camel@irongate.swansea.linux.org.uk> <20020807180503.GI23816@os.inf.tu-dresden.de> <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 07, 2002 at 20:35:42 +0100, Alan Cox wrote:
> On Wed, 2002-08-07 at 19:05, Adam Lackorzynski wrote:
> > On Wed Aug 07, 2002 at 19:57:03 +0100, Alan Cox wrote:
> > > On Wed, 2002-08-07 at 17:29, Adam Lackorzynski wrote:
> > > > I have a dual Athlon here which ooopses after 2 minutes of dnetc when
> > > > running 2.4.19-ac4 or 2.4.20-pre1-ac1. I cannot reproduce this with
> > > > 2.4.19 or 2.4.20-pre1. The two Athlons are sitting on a A7M266-D.
> > > 
> > > Are you loading the amd76x_pm module for power management ?
> > 
> > No, the module wasn't loaded in any of the cases. Only ipv6 and rtc are
> > loaded.
> 
> Can you reproduce it with ACPI disabled ?

2.4.20-pre1-ac1 with acpi=off, looks like the other ones:

>>EIP; c011831c <schedule+19c/3a0>   <=====

Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 
Unable to handle kernel NULL pointer dereference at virtual address 00000028
c011831c
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c011831c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 0000008c   ebx: ffffffd4   ecx: c03956dc   edx: dd956000
esi: c0395240   edi: dd95602c   ebp: dd957fa4   esp: dd957f88
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 338, stackpage=dd957000)
Stack: dd956000 c03956dc dd95602c 00000001 c011521f dd956000 dd956000 dd957fbc 
       c011935d dd956000 000000c5 00013880 c0395240 bffff7b4 c0108b6b 00000000 
       00000001 40025004 000000c5 00013880 bffff7b4 0000009e 0000002b 0000002b 
Call Trace:    [<c011521f>] [<c011935d>] [<c0108b6b>]
Code: 8b 4b 54 89 4d f4 8b 72 58 85 c9 75 37 89 73 58 f0 ff 46 14 

>>ebx; ffffffd4 <END_OF_CODE+3fbf6838/????>
>>ecx; c03956dc <runqueues+e5c/13800>
>>edx; dd956000 <END_OF_CODE+1d54c864/????>
>>esi; c0395240 <runqueues+9c0/13800>
>>edi; dd95602c <END_OF_CODE+1d54c890/????>
>>ebp; dd957fa4 <END_OF_CODE+1d54e808/????>
>>esp; dd957f88 <END_OF_CODE+1d54e7ec/????>

Trace; c011521f <smp_apic_timer_interrupt+ef/110>
Trace; c011935d <sys_sched_yield+11d/130>
Trace; c0108b6b <system_call+33/38>

Code;  c011831c <schedule+19c/3a0>
00000000 <_EIP>:
Code;  c011831c <schedule+19c/3a0>   <=====
   0:   8b 4b 54                  mov    0x54(%ebx),%ecx   <=====
Code;  c011831f <schedule+19f/3a0>
   3:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c0118322 <schedule+1a2/3a0>
   6:   8b 72 58                  mov    0x58(%edx),%esi
Code;  c0118325 <schedule+1a5/3a0>
   9:   85 c9                     test   %ecx,%ecx
Code;  c0118327 <schedule+1a7/3a0>
   b:   75 37                     jne    44 <_EIP+0x44> c0118360 <schedule+1e0/3
a0>
Code;  c0118329 <schedule+1a9/3a0>
   d:   89 73 58                  mov    %esi,0x58(%ebx)
Code;  c011832c <schedule+1ac/3a0>
  10:   f0 ff 46 14               lock incl 0x14(%esi)


Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
