Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264118AbRFHRbY>; Fri, 8 Jun 2001 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264203AbRFHRbO>; Fri, 8 Jun 2001 13:31:14 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:60676 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S264118AbRFHRbG>; Fri, 8 Jun 2001 13:31:06 -0400
Date: Fri, 8 Jun 2001 13:33:03 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: szonyi calin <caszonyi@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: oops with kernel 2.4.5
In-Reply-To: <20010608121633.39690.qmail@web13902.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0106081324470.12366-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well, my guess is that the compiler misscompiles your kernel.

stil _contrary_ to REPORTING_BUGS file you did not gave any info about
your system.

some usefull stuff you should email are (adjust it to your setup)

a)

	cd /usr/src/linux
	rm fs/buffer.o
	make fs/buffer.o

email output of the make then find out what gcc was used (gcc,kgcc etc)
and email what gcc it was, ie
b)

	gcc -v

then run following command
c)

	gdb vmlinux

		disassemble __remove_from_queues

in gdb run the above command and email output of all the 3 above,
then ppl on LKML might be able to help you better.

On Fri, 8 Jun 2001, szonyi calin wrote:

> Hi
> we found in logs a oops and here are the results from
> ksymoops (2.4.1)
>
> Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> c012db89
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c012db89>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: c00725c0   ecx: c00725c0   edx:
> 00000004
> esi: c00725c0   edi: c00725c0   ebp: 00000000   esp:
> c10a9f70
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 3, stackpage=c10a9000)
> Stack: c0130092 c00725c0 c1076e94 c1076e78 c025eb90
> 00000027 c00725c0 00000003
>        c0126cb1 c1076e78 00000000 00000000 00000004
> 00000000 0008e000 00000000
>        00000000 00000004 00000000 0000003c c0127551
> 00000004 00000000 c10a8000
> Call Trace: [<c0130092>] [<c0126cb1>] [<c0127551>]
> [<c01275df>] [<c0105000>] [<c
> 0105463>]
> Code: 89 02 c7 41 30 00 00 00 00 31 c0 66 8b 41 0a 50
> 51 e8 0d ffUnable to handle kernel NULL pointer
> dereference at virtual address 00000004
> c012db89
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c012db89>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: c00725c0   ecx: c00725c0   edx:
> 00000004
> esi: c00725c0   edi: c00725c0   ebp: 00000000   esp:
> c10a9f70
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 3, stackpage=c10a9000)
> Stack: c0130092 c00725c0 c1076e94 c1076e78 c025eb90
> 00000027 c00725c0 00000003
>        c0126cb1 c1076e78 00000000 00000000 00000004
> 00000000 0008e000 00000000
>        00000000 00000004 00000000 0000003c c0127551
> 00000004 00000000 c10a8000
> Call Trace: [<c0130092>] [<c0126cb1>] [<c0127551>]
> [<c01275df>] [<c0105000>] [<c
> 0105463>]
> Code: 89 02 c7 41 30 00 00 00 00 31 c0 66 8b 41 0a 50
> 51 e8 0d ff
> >>EIP; c012db89 <__remove_from_queues+19/34>   <=====
> Trace; c0130092 <try_to_free_buffers+76/164>
> Trace; c0126cb1 <page_launder+329/810>
> Trace; c0127551 <do_try_to_free_pages+1d/58>
> Trace; c01275df <kswapd+53/e0>
> Trace; c0105000 <prepare_namespace+0/8>
> Code;  c012db89 <__remove_from_queues+19/34>
> 00000000 <_EIP>:
> Code;  c012db89 <__remove_from_queues+19/34>   <=====
>    0:   89 02                     movl   %eax,(%edx)
> <=====
> Code;  c012db8b <__remove_from_queues+1b/34>
>    2:   c7 41 30 00 00 00 00      movl
> $0x0,0x30(%ecx)
> Code;  c012db92 <__remove_from_queues+22/34>
>    9:   31 c0                     xorl   %eax,%eax
> Code;  c012db94 <__remove_from_queues+24/34>
>    b:   66 8b 41 0a               movw   0xa(%ecx),%ax
> Code;  c012db98 <__remove_from_queues+28/34>
>    f:   50                        pushl  %eax
> Code;  c012db99 <__remove_from_queues+29/34>
>   10:   51                        pushl  %ecx
> Code;  c012db9a <__remove_from_queues+2a/34>
>   11:   e8 0d ff 00 00            call   ff23
> <_EIP+0xff23> c013daac <d_invalidate+44/60>>>EIP;
> c012db89 <__remove_from_queues+19/34>   <=====
> Trace; c0130092 <try_to_free_buffers+76/164>
> Trace; c0126cb1 <page_launder+329/810>
> Trace; c0127551 <do_try_to_free_pages+1d/58>
> Trace; c01275df <kswapd+53/e0>
> Trace; c0105000 <prepare_namespace+0/8>
> Code;  c012db89 <__remove_from_queues+19/34>
> 00000000 <_EIP>:
> Code;  c012db89 <__remove_from_queues+19/34>   <=====
>    0:   89 02                     movl   %eax,(%edx)
> <=====
> Code;  c012db8b <__remove_from_queues+1b/34>
>    2:   c7 41 30 00 00 00 00      movl
> $0x0,0x30(%ecx)
> Code;  c012db92 <__remove_from_queues+22/34>
>    9:   31 c0                     xorl   %eax,%eax
> Code;  c012db94 <__remove_from_queues+24/34>
>    b:   66 8b 41 0a               movw   0xa(%ecx),%ax
> Code;  c012db98 <__remove_from_queues+28/34>
>    f:   50                        pushl  %eax
> Code;  c012db99 <__remove_from_queues+29/34>
>   10:   51                        pushl  %ecx
> Code;  c012db9a <__remove_from_queues+2a/34>
>   11:   e8 0d ff 00 00            call   ff23
> <_EIP+0xff23> c013daac <d_invalidate+44/60>
>
> Well ?
>
>
> __________________________________________________
> Do You Yahoo!?
> Get personalized email addresses from Yahoo! Mail - only $35
> a year!  http://personal.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


