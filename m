Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHCX4M>; Sat, 3 Aug 2002 19:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSHCX4M>; Sat, 3 Aug 2002 19:56:12 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:28130 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S318028AbSHCX4L>; Sat, 3 Aug 2002 19:56:11 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc Lefranc <lefranc.m@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Problem with AHA152X driver in 2.4.19
References: <p6r65yrlvt1.fsf@free.fr>
	<1028414114.1760.40.camel@irongate.swansea.linux.org.uk>
From: Marc Lefranc <Marc.Lefranc@LaPoste.net>
Date: 04 Aug 2002 01:58:48 +0200
In-Reply-To: <1028414114.1760.40.camel@irongate.swansea.linux.org.uk>
Message-ID: <p6rr8hfo5on.fsf@free.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Aug 2002 23:35:14 +0100, 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote :

> You need to run through the oops through the ksymoops decoder (see
> REPORTING-BUGS in the kernel)

Sorry about that. Here is a new one:

Aug  4 01:51:14 socrate kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001b
Aug  4 01:51:14 socrate kernel: c68a21d9
Aug  4 01:51:14 socrate kernel: *pde = 00000000
Aug  4 01:51:14 socrate kernel: Oops: 0000
Aug  4 01:51:14 socrate kernel: CPU:    0
Aug  4 01:51:14 socrate kernel: EIP:    0010:[<c68a21d9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  4 01:51:14 socrate kernel: EFLAGS: 00010006
Aug  4 01:51:14 socrate kernel: eax: 00000000   ebx: c2738000   ecx: c30a5e30   edx: c5c58b20
Aug  4 01:51:14 socrate kernel: esi: c5319000   edi: 0000000c   ebp: c5319000   esp: c29dde30
Aug  4 01:51:14 socrate kernel: ds: 0018   es: 0018   ss: 0018
Aug  4 01:51:14 socrate kernel: Process tar (pid: 1120, stackpage=c29dd000)
Aug  4 01:51:14 socrate kernel: Stack: 00000297 c116feb4 c2738000 c68a22e3 c2738000 00000000 00000000 00000000 
Aug  4 01:51:14 socrate kernel:        c687fab0 c687f517 c2738000 c687fab0 00000000 c2738000 c116feb4 c27380b8 
Aug  4 01:51:14 socrate kernel:        c116feb4 c688662f c2738000 c2738000 00000000 c5319000 c59d3c00 c116fe60 
Aug  4 01:51:14 socrate kernel: Call Trace:    [<c68a22e3>] [<c687fab0>] [<c687f517>] [<c687fab0>] [<c688662f>]
Aug  4 01:51:14 socrate kernel:   [<c6885a5f>] [<c6885ab9>] [<c68984cc>] [<c6898300>] [<c6899e99>] [<c689a4e0>]
Aug  4 01:51:14 socrate kernel:   [<c0132ac8>] [<c01394a5>] [<c01088b3>]
Aug  4 01:51:14 socrate kernel: Code: 0f b6 50 1b 8b 14 95 dc 24 27 c0 2b 82 a0 00 00 00 69 c0 a3 

>>EIP; c68a21d9 <[aha152x]aha152x_internal_queue+f9/1f0>   <=====
Trace; c68a22e3 <[aha152x]aha152x_queue+13/20>
Trace; c687fab0 <[scsi_mod]scsi_done+0/90>
Trace; c687f517 <[scsi_mod]__kstrtab_scsi_deregister_blocked_host+17/27>
Trace; c687fab0 <[scsi_mod]scsi_done+0/90>
Trace; c688662f <[scsi_mod]scsi_request_fn+2bf/300>
Trace; c6885a5f <[scsi_mod]__scsi_insert_special+5f/70>
Trace; c6885ab9 <[scsi_mod]scsi_insert_special_req+19/30>
Trace; c68984cc <[st]st_do_scsi+10c/150>
Trace; c6898300 <[st]st_sleep_done+0/c0>
Trace; c6899e99 <[st]read_tape+119/390>
Trace; c689a4e0 <[st]st_read+3d0/500>
Trace; c0132ac8 <sys_read+98/100>
Trace; c01394a5 <sys_stat64+65/70>
Trace; c01088b3 <system_call+33/40>
Code;  c68a21d9 <[aha152x]aha152x_internal_queue+f9/1f0>
00000000 <_EIP>:
Code;  c68a21d9 <[aha152x]aha152x_internal_queue+f9/1f0>   <=====
   0:   0f b6 50 1b               movzbl 0x1b(%eax),%edx   <=====
Code;  c68a21dd <[aha152x]aha152x_internal_queue+fd/1f0>
   4:   8b 14 95 dc 24 27 c0      mov    0xc02724dc(,%edx,4),%edx
Code;  c68a21e4 <[aha152x]aha152x_internal_queue+104/1f0>
   b:   2b 82 a0 00 00 00         sub    0xa0(%edx),%eax
Code;  c68a21ea <[aha152x]aha152x_internal_queue+10a/1f0>
  11:   69 c0 a3 00 00 00         imul   $0xa3,%eax,%eax


And while we are at it, here is the information from the driver as it
starts

Aug  4 01:51:11 socrate kernel: SCSI subsystem driver Revision: 1.00
Aug  4 01:51:12 socrate kernel: aha152x: BIOS test: passed, detected 1 controller(s)
Aug  4 01:51:12 socrate kernel: aha152x: resetting bus...
Aug  4 01:51:12 socrate kernel: aha152x0: vital data: rev=1, io=0x140 (0x140/0x140), irq=11, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
Aug  4 01:51:12 socrate kernel: aha152x0: trying software interrupt, ok.
Aug  4 01:51:12 socrate kernel: scsi0 : Adaptec 152x SCSI driver; $Revision: 2.5 $
Aug  4 01:51:13 socrate kernel: (scsi0:3:0) Synchronous Data Transfer Request period = 200 ns, offset = 8
Aug  4 01:51:13 socrate kernel:   Vendor: HP        Model: C1533A            Rev: A812
Aug  4 01:51:13 socrate kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Aug  4 01:51:14 socrate kernel: st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Aug  4 01:51:14 socrate kernel: Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
Aug  4 01:51:14 socrate kernel: st0: Block limits 1 - 16777215 bytes.
