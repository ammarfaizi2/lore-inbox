Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbTAJTMs>; Fri, 10 Jan 2003 14:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbTAJTMs>; Fri, 10 Jan 2003 14:12:48 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:49422 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266259AbTAJTLS>;
	Fri, 10 Jan 2003 14:11:18 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.55, PCI, PCMCIA, XIRCOM]
References: <87znq9ynz4.fsf@jupiter.jochen.org>
	<200301101713.h0AHDYLK010367@turing-police.cc.vt.edu>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Fri, 10 Jan 2003 20:00:31 +0100
In-Reply-To: <200301101713.h0AHDYLK010367@turing-police.cc.vt.edu> (Valdis.Kletnieks@vt.edu's
 message of "Fri, 10 Jan 2003 12:13:34 -0500")
Message-ID: <87y95sakz4.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Fri, 10 Jan 2003 17:21:51 +0100, Jochen Hein <jochen@jochen.org>  said:

>> Jan 10 11:35:24 gswi1164 kernel: PCI: Device 01:00.0 not available because of
>  resource collisions
>
> The problem is (as I understand it) that drivers/pcmcia/cardbus.c ends up
> not allocating the onboard ROM resource for some cards before trying to
> enable it.  I've attached a patch that worked for me on 2.5.52, although
> said patch caused a lot of discussion here about the *right* way to do it
> (even *I* admit it's a hack)

For reference, this is already filed in bugzilla as
http://bugzilla.kernel.org/show_bug.cgi?id=134 . I should have
searched there.

> - and I've seen a report it causes an OOPS
> on 2.5.53.  I've not tried it on post-52, but I had a -54 kernel OOPS
> right around that point in bootup (right after IDE and somewhere in PCI
> init).  Haven't chased that one at all...

It Oopses for me too:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:02.0
PCI: Sharing IRQ 11 with 00:03.0
Module yenta_socket cannot be unloaded due to unsafe usage in
  include/linux/module.h:420
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000020
PCI: Found IRQ 11 for device 00:02.1
Yenta IRQ list 06b0, PCI irq11
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x115d, device 0x0003
PCI: Enabling device 01:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 01:00.0 to 64
Unable to handle kernel NULL pointer dereference at virtual address
  00000004
 printing eip:
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x1000-0x17ff: excluding 0x15e8-0x15ef
cs: IO port probe 0x0a00-0x0aff: clean.
c010e02e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c010e02e>]    Not tainted
EFLAGS: 00010282
EIP is at .text.lock.sys_i386+0x1e/0x88
eax: 00000020   ebx: c571f44c   ecx: 00000000   edx: c571f44c
esi: 00002000   edi: c5e17840   ebp: c5defedc   esp: c5defecc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 310, threadinfo=c5dee000 task=c1125280)
Stack: c571f44c c571f400 c5e17840 c571f400 c5deff08 c6a6d1c3 c571f44c 00002000
       c5e177b4 c6a6f288 00000000 c571f44c c5e177ac c571f44c 02100388 c5deff2c
       c01d6983 c571f400 c6a6f210 ffffffed c6a6f288 c571f44c c571f400 c6a6f260
Call Trace:
 [<c6a6d1c3>] xircom_probe+0xff/0xfffaff53 [xircom_cb]
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c01d6983>] pci_match_device+0x47/0x64
 [<c6a6f210>] xircom_pci_table+0x0/0xfffade07 [xircom_cb]
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c6a6f260>] xircom_ops+0x0/0xfffaddb7 [xircom_cb]
 [<c0218088>] device_bind_driver+0x38/0x64
 [<c0218156>] device_attach+0x42/0x70
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c0218413>] bus_remove_device+0x87/0xa4
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c6a6f300>] +0x0/0xfffadd17 [xircom_cb]
 [<c6a6f2a8>] xircom_ops+0x48/0xfffaddb7 [xircom_cb]
 [<c021877a>] put_driver+0x36/0x3c
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c01d6a84>] pci_device_resume+0x44/0x54
 [<c6a6f288>] xircom_ops+0x28/0xfffaddb7 [xircom_cb]
 [<c6a1d00d>] 0xc6a1d00d
 [<c6a6f260>] xircom_ops+0x0/0xfffaddb7 [xircom_cb]
 [<c012c9d6>] load_module+0x13a/0x1cc
 [<c0108d9b>] system_call+0x7/0xb

Code: 8b 51 04 85 d2 77 09 75 05 83 39 fe 77 02 0c 01 8d 5e ff c1

-- 
#include <~/.signature>: permission denied
