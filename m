Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbQLOOJD>; Fri, 15 Dec 2000 09:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQLOOIx>; Fri, 15 Dec 2000 09:08:53 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:30156 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130376AbQLOOIi>; Fri, 15 Dec 2000 09:08:38 -0500
Date: Fri, 15 Dec 2000 15:37:29 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: USB-related Oops in test12
Message-ID: <20001215153729.C829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001214142940.A1018@bloch.verdurin.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001214142940.A1018@bloch.verdurin.priv>; from bloch@verdurin.com on Thu, Dec 14, 2000 at 02:29:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 02:29:40PM +0000, Adam Huffman wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<d086734b>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: 00e08269     ecx: 00888105       edx: 0000000c
> esi: 00000004   edi: cfa84c40     ebp: cfabeb00       esp: c0259ec8
> ds: 0018        es: 0018       ss: 0018
> Process swapper (pid: 0, stackpage=c0259000)
> Stack: 00000000 cfabeb24 cfabc180 cff28cc0 cfa84c40 cff28cdc 00000000 d0867639
>        cff28cc0 cfa84c40 00000020 00000002 00000000 cff28cdc cff28cc0 cff28cdc
>        00000000 d0867848 cff28cc0 cfa84c48 00000000 cfef0001 00000000 c02a7480
> Call Trace: [<d0867639>] [<d0867848>] [<c010c1bf>] [<c010c342>] [<c010afb0>] [<c01c3e62>] [<c01c3b80>]
>        [<c0109150>] [<c01c3b80>] [<c011fc01>] [<c01091d8>] [<c0105000>] [<c0100191>]
> Code: 8b 04 82 c1 e9 08 83 e1 0f d3 e8 83 e0 01 c1 e0 13 09 45 08
> 
> >>EIP; d086734b <[usb-uhci]process_interrupt+10b/1f0>   <=====
> Trace; d0867639 <[usb-uhci]process_urb+79/1f0>
> Trace; d0867848 <[usb-uhci]uhci_interrupt+98/100>
> Trace; c010c1bf <handle_IRQ_event+2f/60>
> Trace; c010c342 <do_IRQ+72/c0>
> Trace; c010afb0 <ret_from_intr+0/20>
> Trace; c01c3e62 <acpi_idle+2e2/330>
> Trace; c01c3b80 <acpi_idle+0/330>
> Trace; c0109150 <default_idle+0/30>
> Trace; c01c3b80 <acpi_idle+0/330>
> Trace; c011fc01 <check_pgt_cache+11/20>
> Trace; c01091d8 <cpu_idle+38/50>

> Trace; c0105000 <empty_bad_page+0/1000>
> Trace; c0100191 <L6+0/2>

Once again we have these two symbols on the stack. 

Anybody else, who thinks this might be related?

I've seen these two symbols on all ix86-Ooopses with no raid
involved.

Does anybody have an idea, why we always see these symbols there?

Is it an common bitmask? L6 (from arch/i386/head.S) is freed after boot AFAICS.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
