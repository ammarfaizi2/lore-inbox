Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbTIHXWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTIHXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:22:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38474 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263719AbTIHXWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:22:20 -0400
Date: Mon, 08 Sep 2003 19:22:17 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP,
 2.4.21-pre2 and 2.4.21-pre3 ksymoops
In-reply-to: <200309080933.h889X06U011447@harpo.it.uu.se>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca,
       mingo@redhat.com
Message-id: <20030908232217.GA1417@Krystal>
X-Info: http://krystal.dyndns.org
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Editor: vi
X-Operating-System: Linux/2.4.20 (i586)
X-Uptime: 19:15:25 up 4 min,  1 user,  load average: 0.54, 0.46, 0.19
References: <200309080933.h889X06U011447@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On kernel 2.4.21-pre2, there is a kernel oops before this, with a
> >"Dereferencing NULL pointer".
> 
> You didn't run that through ksymoops and post it, so how is anyone
> supposed to be able to debug it?

As only 2.4.21-pre2 and 2.4.21-pre3 kernels show this problem, I thought
it has been corrected in 2.4.21-pre4. But, as it can be very useful in
finding the problem, here are the ksymoops for 2.4.21-pre2 and
2.4.21-pre3 kernels, quite similar though.


-------------------------------------------------------------------------------
2.4.21-pre2 ksymoops

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0115da7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115da7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1163400   ecx: 00000000   edx: 00000000
esi: 00000010   edi: c116bfbb   ebp: 0008e000   esp: c116bf90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c116b000)
Stack: 00000010 ffffffff c1163400 00000010 c116bfbb 0008e000 c02fe4c9 00000000 
       00000001 00000000 0008e000 c116a000 c02f7fc8 c0105000 0008e000 c02fdef9 
       c030c7c6 c116a000 c02f87fb c0105078 00010f00 c02f7fc8 c0105000 0008e000 
Call Trace:    [<c0105000>] [<c0105078>] [<c0105000>] [<c0107406>] [<c0105050>]
Code: 83 3c 90 ff 0f 84 f1 00 00 00 a1 c0 80 34 c0 31 ff 89 04 24 


>>EIP; c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>   <=====

Trace; c0105000 <_stext+0/0>
Trace; c0105078 <init+28/180>
Trace; c0105000 <_stext+0/0>
Trace; c0107406 <kernel_thread+26/30>
Trace; c0105050 <init+0/180>

Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>
00000000 <_EIP>:
Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>   <=====
   0:   83 3c 90 ff               cmpl   $0xffffffff,(%eax,%edx,4)   <=====
Code;  c0115dab <IO_APIC_get_PCI_irq_vector+1b/130>
   4:   0f 84 f1 00 00 00         je     fb <_EIP+0xfb>
Code;  c0115db1 <IO_APIC_get_PCI_irq_vector+21/130>
   a:   a1 c0 80 34 c0            mov    0xc03480c0,%eax
Code;  c0115db6 <IO_APIC_get_PCI_irq_vector+26/130>
   f:   31 ff                     xor    %edi,%edi
Code;  c0115db8 <IO_APIC_get_PCI_irq_vector+28/130>
  11:   89 04 24                  mov    %eax,(%esp,1)

 <0>Kernel panic: Attempted to kill init!

-------------------------------------------------------------------------------
2.4.21-pre3 ksymoops

Unable to handle kernel NULL pointer dereference at virtual address 000000
c0115da7      
*pde = 00000000
Oops: 0000     
CPU:    0 
EIP:    0010:[<c0115da7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246                        
eax: 00000000   ebx: c1163400   ecx: 00000000   edx: 00000000
esi: 00000010   edi: c116bfbb   ebp: 0008e000   esp: c116bf90
ds: 0018   es: 0018   ss: 0018                               
Process swapper (pid: 1, stackpage=c116b000)
Stack: 00000010 ffffffff c1163400 00000010 c116bfbb 0008e000 c02fe549 000 
       00000001 00000000 0008e000 c116a000 c02f7fc8 c0105000 0008e000 c02 
       c030c846 c116a000 c02f87fb c0105078 00010f00 c02f7fc8 c0105000 000 
Call Trace:    [<c0105000>] [<c0105078>] [<c0105000>] [<c0107406>] [<c010]
Code: 83 3c 90 ff 0f 84 f1 00 00 00 a1 c0 80 34 c0 31 ff 89 04 24 


>>EIP; c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>   <=====

Trace; c0105000 <_stext+0/0>
Trace; c0105078 <init+28/180>
Trace; c0105000 <_stext+0/0>
Trace; c0107406 <kernel_thread+26/30>

Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>
00000000 <_EIP>:
Code;  c0115da7 <IO_APIC_get_PCI_irq_vector+17/130>   <=====
   0:   83 3c 90 ff               cmpl   $0xffffffff,(%eax,%edx,4)   <=====
Code;  c0115dab <IO_APIC_get_PCI_irq_vector+1b/130>
   4:   0f 84 f1 00 00 00         je     fb <_EIP+0xfb>
Code;  c0115db1 <IO_APIC_get_PCI_irq_vector+21/130>
   a:   a1 c0 80 34 c0            mov    0xc03480c0,%eax
Code;  c0115db6 <IO_APIC_get_PCI_irq_vector+26/130>
   f:   31 ff                     xor    %edi,%edi
Code;  c0115db8 <IO_APIC_get_PCI_irq_vector+28/130>
  11:   89 04 24                  mov    %eax,(%esp,1)

 <0>Kernel panic: Attempted to kill init!                         

-------------------------------------------------------------------------------


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
