Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSGRM3H>; Thu, 18 Jul 2002 08:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318037AbSGRM3H>; Thu, 18 Jul 2002 08:29:07 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:30480 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S318036AbSGRM3F>; Thu, 18 Jul 2002 08:29:05 -0400
Date: Thu, 18 Jul 2002 14:34:59 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
cc: Filip Van Raemdonck <filipvr@xs4all.be>, Martin Diehl <lists@mdiehl.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] aha152x fix
In-Reply-To: <20020718055204.GA10357@linux-buechse.de>
Message-ID: <Pine.LNX.4.21.0207181240110.6083-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Juergen E. Fischer wrote:

> I tested the driver using a cdrom and can smoothly load and remove the
> modules here.

Yes, this was my impression with your/Filip's patch too. I've a scanner
connected there and on insmod the bus scan succeeded and the scanner
was detected - fine. Unfortunately, I hadn't tried to go any further :-(

However, when I try to scan some image using xscanimage the scanner starts
to operate for a few seconds (probably initialisation and move to starting
position) and then the box locks up solid (no reaction to SysRq, power
cycle required for both the box and the scanner to recover). With 2.5.25
this does not happen, i.e. I do get real scans there without problem.

Due to NULL pointer dereferencing I'm getting an Oops - see below. This
was taken from the console with the aha152x running with debug enabled.
And yes, this should be completely unrelated to the detection problem.

As we are close to -final, what about reverting -pre10 (the 2.5 backport)?

Martin

-----------------------------------

aha152x: BIOS test: passed, detected 1 controller(s)
aha152x0: vital data: rev=3, io=0x140 (0x140/0x140), irq=10, scsiid=0,
 reconnect=disabled, parity=disabled, synchronous=disabled, delay=0,
 extended translation=disabled
aha152x0: trying software interrupt, ok.
scsi0 : Adaptec 152x SCSI driver; $Revision: 2.5 $
  Vendor:           Model: scanner V636A4    Rev: 1.10
  Type:   Scanner                            ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 6

>>> start of scan (debug=0x3883)

(scsi0:6:0) queue: cmd_len=10 pieces=0 size=9 cmnd=Read (10) 00 81 00 00 00 00 00 09 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=9 cmnd=Read (10) 00 81 00 00 00 00 00 09 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=9 cmnd=Write (10) 00 81 00 00 00 00 00 09 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=24576 cmnd=Write (10) 00 03 00 00 61 00 60 00 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=69 cmnd=Define window parameters 00 00 00 00 00 00 00 45 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=16 cmnd=Read (10) 00 80 00 00 00 00 00 10 00 
(scsi0:6:0) inbound status 00 Good 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=0 size=0 cmnd=Read (10) 00 83 00 00 00 00 00 01 00 
(scsi0:6:0) inbound status 08 Busy 
(scsi0:6:0) calling scsi_done(cb7f5000)
(scsi0:6:0) scsi_done(cb7f5000) returned
(scsi0:6:0) queue: cmd_len=10 pieces=2 size=49632 cmnd=Read (10) 00 00 00 00 00 00 c1 e0 00 

>>> complete lockup due to:

Unable to handle kernel NULL pointer dereference at virtual address 0000001b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<cd0ae4b7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: c44b9400   ecx: cba06000   edx: c2a501a4
esi: cb7f5000   edi: 00000020   ebp: ca8bfda4   esp: ca8bfd98
ds: 0018   es: 0018   ss: 0018
Process xscanimage (pid: 1942, stackpage=ca8bf000)
Stack: 00000293 cbba1c10 cb7f5000 ca8bfdc0 cd0ae854 cb7f5000 00000000 00000000 
       00000000 cd082240 ca8bfde4 cd08185c cb7f5000 cd082240 00000000 c44b9400 
       cb7f5000 cbba1c10 cb7f50b8 ca8bfe14 cd08ad0c cb7f5000 cb7f5000 cbba1c10 
Call Trace: [<cd0ae854>] [<cd082240>] [<cd08185c>] [<cd082240>] [<cd08ad0c>] 
   [<cd089f1b>] [<cd089faa>] [<cd081e0e>] [<cd09d510>] [<cd09c0ce>] [<cd09d510>] 
   [<cd09be55>] [<cd09ba68>] [<c0142a09>] [<c0109393>] 
Code: 0f b6 50 1b 8b 14 95 a4 f1 2f c0 2b 82 a4 00 00 00 69 c0 a3 
Error (Oops_bfd_perror): set_section_contents Section has no contents

>>EIP; cd0ae4b7 <[aha152x]aha152x_internal_queue+147/4d0>   <=====
Trace; cd0ae854 <[aha152x]aha152x_queue+14/20>
Trace; cd082240 <[scsi_mod]scsi_done+0/120>
Trace; cd08185c <[scsi_mod]scsi_dispatch_cmd+1cc/560>
Trace; cd082240 <[scsi_mod]scsi_done+0/120>
Trace; cd08ad0c <[scsi_mod]scsi_request_fn+3ac/420>
Trace; cd089f1b <[scsi_mod]__scsi_insert_special+9b/e0>
Trace; cd089faa <[scsi_mod]scsi_insert_special_req+1a/30>
Trace; cd081e0e <[scsi_mod]scsi_do_req+16e/1b0>
Trace; cd09d510 <[sg]sg_cmd_done_bh+0/3d0>
Trace; cd09c0ce <[sg]sg_common_write+24e/270>
Trace; cd09d510 <[sg]sg_cmd_done_bh+0/3d0>
Trace; cd09be55 <[sg]sg_new_write+215/240>
Trace; cd09ba68 <[sg]sg_write+f8/2d0>
Trace; c0142a09 <sys_write+99/190>
Trace; c0109393 <system_call+33/40>

