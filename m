Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSKVKrJ>; Fri, 22 Nov 2002 05:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKVKrJ>; Fri, 22 Nov 2002 05:47:09 -0500
Received: from redrock.inria.fr ([138.96.248.51]:4002 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S263215AbSKVKrI>;
	Fri, 22 Nov 2002 05:47:08 -0500
SCF: #mh/Mailbox/outboxDate: Fri, 22 Nov 2002 11:39:04 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533 drivers)
Message-Id: <20021122113904.0052e208.Manuel.Serrano@sophia.inria.fr>
References: <20021120094121.7b6c7d34.Manuel.Serrano@sophia.inria.fr>
	<1037800851.3241.10.camel@irongate.swansea.linux.org.uk>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 22 Nov 2002 11:47:47 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I have tried the new 2.4.20-rc2-ac3 and I'm still unable to boot the kernel.

I have the following error message (this is a copy so it might contain
typos)...

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
ALI15X3: simplex device: DMA forced
   ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC25N..., ATA DISK drive
blk: queue c029d6a0, I/O limit 4095Mb (mask 0xffffffff)
Unable to handle kernel NULL pointer dereference at virtual address 00000010
  printing eip:
c0107cab
*pde =   00000000
Ooops:   00000
CPU:     0
EIP:     0010:[<c0107cab>]  Not tainted
EFLAGS:  00010002
eax:  00000000   ebx: 00001fe0  ecx: 00000001  edx: 000000ff
esi:  00000212   edi: c029da4c  ebp: 000000ff  esp: c1a13f64
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 1, stackpage=c1a13000)
Stack: 000000ff 00000001 c029da4c c019ed05 000000ff 00000001 c1a13fa0 c029da4c
       0000e000 00000286 c019f91c c029da4c c0275554 c0267fd8 00000000 00000001
       00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
Call Trace:   [<c019ed05>] [<c019f91c>] [<c0105021>] [<c01054a9>]

Code: 0b 40 10 ff d0 83 c4 04 56 9d 83 3d 84 dc 27 c0 00 75 0f 89
 <0>Kernel panic: Attempted to kill init!
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

> Can you look up the EIP and call trace values in system.map or feed the
> oops data to ksymoops >
Here is what I got with ksymoops:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
sh-2.05b# ksymoops --vmlinux=/usr/src/linux-2.4.20-rc2-ac3/vmlinux --system-map=/usr/src/linux-2.4.20-rc2-ac3/System.map -L -K /tmp/Oops.file
ksymoops 2.4.7 on i686 2.4.20-pre10-ac2.  Options used
     -v /usr/src/linux-2.4.20-rc2-ac3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre10-ac2/ (default)
     -m /usr/src/linux-2.4.20-rc2-ac3/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0107cab
*pde =   00000000
CPU:     0
EIP:     0010:[<c0107cab>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010002
eax:  00000000   ebx: 00001fe0  ecx: 00000001  edx: 000000ff
esi:  00000212   edi: c029da4c  ebp: 000000ff  esp: c1a13f64
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 1, stackpage=c1a13000)
Stack: 000000ff 00000001 c029da4c c019ed05 000000ff 00000001 c1a13fa0 c029da4c
       0000e000 00000286 c019f91c c029da4c c0275554 c0267fd8 00000000 00000001
       00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
Call Trace:   [<c019ed05>] [<c019f91c>] [<c0105021>] [<c01054a9>]
Code: 0b 40 10 ff d0 83 c4 04 56 9d 83 3d 84 dc 27 c0 00 75 0f 89


>>EIP; c0107cab <disable_irq+2f/54>   <=====

>>edi; c029da4c <ide_hwifs+46c/2c38>

Trace; c019ed05 <probe_hwif+b8/2ee>
Trace; c019f91c <ideprobe_init+4d/9a>
Trace; c0105021 <init+7/fe>
Trace; c01054a9 <kernel_thread+28/35>

Code;  c0107cab <disable_irq+2f/54>
00000000 <_EIP>:
Code;  c0107cab <disable_irq+2f/54>   <=====
   0:   0b 40 10                  or     0x10(%eax),%eax   <=====
Code;  c0107cae <disable_irq+32/54>
   3:   ff d0                     call   *%eax
Code;  c0107cb0 <disable_irq+34/54>
   5:   83 c4 04                  add    $0x4,%esp
Code;  c0107cb3 <disable_irq+37/54>
   8:   56                        push   %esi
Code;  c0107cb4 <disable_irq+38/54>
   9:   9d                        popf   
Code;  c0107cb5 <disable_irq+39/54>
   a:   83 3d 84 dc 27 c0 00      cmpl   $0x0,0xc027dc84
Code;  c0107cbc <disable_irq+40/54>
  11:   75 0f                     jne    22 <_EIP+0x22>
Code;  c0107cbe <disable_irq+42/54>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Attempted to kill init!
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Please tell me if I can do something else (in particular, I'm not pretty
sure of the way to invoke ksymoops).

Sincerely,

-- 
Manuel
