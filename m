Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSHNPv5>; Wed, 14 Aug 2002 11:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSHNPv5>; Wed, 14 Aug 2002 11:51:57 -0400
Received: from wasala.fi ([212.50.129.162]:52750 "EHLO wasala.fi")
	by vger.kernel.org with ESMTP id <S318907AbSHNPv4>;
	Wed, 14 Aug 2002 11:51:56 -0400
Date: Wed, 14 Aug 2002 18:55:05 +0300
From: Antti Salmela <asalmela@iki.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
Message-ID: <20020814185505.A23923@wasala.fi>
References: <20020814145454.A21254@wasala.fi> <1029328630.26226.21.camel@irongate.swansea.linux.org.uk> <20020814161037.A22388@wasala.fi> <1029331629.26227.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1029331629.26227.36.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 14, 2002 at 02:27:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 14, 2002 at 02:27:09PM +0100, Alan Cox wrote:
> On Wed, 2002-08-14 at 14:10, Antti Salmela wrote:
> > On Wed, Aug 14, 2002 at 01:37:10PM +0100, Alan Cox wrote:
> > > On Wed, 2002-08-14 at 12:54, Antti Salmela wrote:
> > > > Oopsed soon after boot up. Stable with vanilla 2.4.19. The board is Intel
> > > > SDS2. dnetc was running.
> > > 
> > > Does vanilla 2.4.20pre1 run ok ?
> > 
> > Seems to work just fine.
> 
> Really we need to find which kernel the problem started with then. If
> you've got the time to spend on this try 2.4.19-ac1

2.4.19-rc1-ac2 appears to be the first one that does not work.

ksymoops 2.4.5 on i686 2.4.19-rc1-ac1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.19-rc1-ac2 (specified)
     -m /boot/System.map-2.4.19-rc1-ac2 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 0000002a
c0116f0c
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0116f0c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 0000008c   ebx: c0327680   ecx: c03276a4   edx: f6760000
esi: ffffffd6   edi: f676002c   ebp: f6761fa4   esp: f6761f88
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 511, stackpage=f6761000)
Stack: f6760000 00000a00 f676002c 00000001 c011428f f6760000 f6760000 f6761fbc 
       c0117eef f6760000 000000b5 000b2390 c0327680 bffff934 c01088eb 00000000 
       00000000 40026004 000000b5 000b2390 bffff934 0000009e c010002b 0000002b 
Call Trace: [<c011428f>] [<c0117eef>] [<c01088eb>] 
Code: 8b 7e 54 8b 4a 58 89 4d f4 85 ff 75 37 89 4e 58 f0 ff 41 14 


>>EIP; c0116f0c <schedule+198/394>   <=====

>>ebx; c0327680 <runqueues+a00/14000>
>>ecx; c03276a4 <runqueues+a24/14000>
>>edx; f6760000 <END_OF_CODE+363b9844/????>
>>esi; ffffffd6 <END_OF_CODE+3fc5981a/????>
>>edi; f676002c <END_OF_CODE+363b9870/????>
>>ebp; f6761fa4 <END_OF_CODE+363bb7e8/????>
>>esp; f6761f88 <END_OF_CODE+363bb7cc/????>

Trace; c011428f <smp_apic_timer_interrupt+f3/114>
Trace; c0117eef <sys_sched_yield+113/11c>
Trace; c01088eb <system_call+33/38>

Code;  c0116f0c <schedule+198/394>
00000000 <_EIP>:
Code;  c0116f0c <schedule+198/394>   <=====
   0:   8b 7e 54                  mov    0x54(%esi),%edi   <=====
Code;  c0116f0f <schedule+19b/394>
   3:   8b 4a 58                  mov    0x58(%edx),%ecx
Code;  c0116f12 <schedule+19e/394>
   6:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
Code;  c0116f15 <schedule+1a1/394>
   9:   85 ff                     test   %edi,%edi
Code;  c0116f17 <schedule+1a3/394>
   b:   75 37                     jne    44 <_EIP+0x44> c0116f50 <schedule+1dc/394>
Code;  c0116f19 <schedule+1a5/394>
   d:   89 4e 58                  mov    %ecx,0x58(%esi)
Code;  c0116f1c <schedule+1a8/394>
  10:   f0 ff 41 14               lock incl 0x14(%ecx)

-- 
Antti Salmela
