Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbRGITJQ>; Mon, 9 Jul 2001 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRGITJG>; Mon, 9 Jul 2001 15:09:06 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:37391 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264689AbRGITIu>; Mon, 9 Jul 2001 15:08:50 -0400
Message-ID: <3B4A0133.D7270B6D@netpathway.com>
Date: Mon, 09 Jul 2001 14:08:35 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VMWare crashes
In-Reply-To: <82677BD2F89@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results of ksymoops...

Unable to handle kernel NULL pointer dereference at virtual address 00000070
e1af85e1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e1af85e1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 00000000   ebx: 00000000   ecx: c243e000   edx: 00000000
esi: d6b2f480   edi: dfe24df4   ebp: dfe24dc0   esp: c243feb0
ds: 0018   es: 0018   ss: 0018
Process vmware (pid: 487, stackpage=c243f000)
Stack: de7aac04 00000000 de7aac00 d6b2fd80 de7aac3c 00000001 dfe212c0 dfe4d400
       dfe212c0 dfe212c0 d6b2fd80 e1af6f9e dfe24e14 c76f1e00 00003202 de7aac04
       00000000 de7aac00 d6b2fd80 e1af74e6 de7aac04 c76f1e00 c76f1e00 c0203fe4
Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]
Code: 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 0c 83 c4

>>EIP; e1af85e1 <[vmnet]VNetHubCycleDetect+69/7c>   <=====
Trace; c0203fe4 <analyze_sbs+694/710>
Trace; c0203fe4 <analyze_sbs+694/710>
Trace; c011722f <it_real_fn+1f/50>
Trace; c012eb26 <shmem_file_setup+26/120>
Trace; c0106dc3 <lcall27+2f/4c>
Code;  e1af85e1 <[vmnet]VNetHubCycleDetect+69/7c>
0000000000000000 <_EIP>:
Code;  e1af85e1 <[vmnet]VNetHubCycleDetect+69/7c>   <=====
   0:   8b 42 70                  mov    0x70(%edx),%eax   <=====
Code;  e1af85e4 <[vmnet]VNetHubCycleDetect+6c/7c>
   3:   83 f8 01                  cmp    $0x1,%eax
Code;  e1af85e7 <[vmnet]VNetHubCycleDetect+6f/7c>
   6:   74 0a                     je     12 <_EIP+0x12> e1af85f3 <[vmnet]VNetHubCycleDetect+7b/7c>
Code;  e1af85e9 <[vmnet]VNetHubCycleDetect+71/7c>
   8:   ff 4a 70                  decl   0x70(%edx)
Code;  e1af85ec <[vmnet]VNetHubCycleDetect+74/7c>
   b:   0f 94 c0                  sete   %al
Code;  e1af85ef <[vmnet]VNetHubCycleDetect+77/7c>
   e:   84 c0                     test   %al,%al
Code;  e1af85f1 <[vmnet]VNetHubCycleDetect+79/7c>
  10:   74 0c                     je     1e <_EIP+0x1e> e1af85ff <[vmnet]VNetHubPortsChanged+b/ec>
Code;  e1af85f3 <[vmnet]VNetHubCycleDetect+7b/7c>
  12:   83 c4 00                  add    $0x0,%esp



Petr Vandrovec wrote:
> 
> On  9 Jul 01 at 9:49, Gary White (Network Administr wrote:
> > I realize this may be a VMWare problem, but I just waited to
> > bring this to the attention of the developers in case it was related
> > to the kernel and to also see if anyone else is having the same
> > problem. VMWare dies under load with all kernel versions up to and
> > including ac versions after 2.4.6. Kernel version up to and including
> > 2.4.5-ac15 I know all run fine. Somewhere between 2.4.5-ac15 and 2.4.6
> > is where the problem started. I have backed up to 2.4.5 now and VMWare
> > is rock solid.
> 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000070
> >  printing eip:
> > e1af85e1
> > Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]
> 
> Could you feed these oopeses through ksymoops?
> 
> I'm now running vmware 24h/day with linux and win98 as guest, doing
> network transfers between host and guest, and I did not noticed any problems.
> 
> It worked fine with 2.4.5-ac24 from wednesday to sunday, and yesterday
> I upgraded to 2.4.6-ac2, and it still works. Kernel compiled with
> Debian's gcc-3.0-3 or gcc-3.0-4, Asus A7V, KT133, 1GHz Athlon, and
> Chaintech 6BTM, 440BX, 300MHz Celeron... I did not tested Linus's kernel
> for more than 6 months now, so I cannot tell whether it works with Linus's
> 2.4.6, or not...
>                                         Best regards,
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
> 

-- 
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314

