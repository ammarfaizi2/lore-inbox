Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUHRFoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUHRFoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 01:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUHRFoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 01:44:19 -0400
Received: from constellation.doubledimension.com ([63.90.75.35]:29049 "EHLO
	constellation.doubledimension.com") by vger.kernel.org with ESMTP
	id S268641AbUHRFoG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 01:44:06 -0400
Subject: Help with mapping memory into kernel space?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 17 Aug 2004 22:39:38 -0700
Content-class: urn:content-classes:message
Message-ID: <E6456D527ABC5B4DBD1119A9FB461E3501E00B@constellation.doubledimension.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help with mapping memory into kernel space?
thread-index: AcSE5cBSyTERZaKeSvqLSOsQPtjXvw==
From: "Brian McGrew" <Brian@doubledimension.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day All:

The problems that I am currently seeing under the 2.4.20 kernel are
very very stange and therefor this will be quite a long message
(against my better judgement) with a bit of background information.

My company produces a custom hardware solution for examining printed
circuit boards and it is currently a Linux based system.  In this
system, we put in a real time controller card (RTC), some image
buffer boards (IBB) and attach some cameras; one camera per IBB,
up to four IBB's.

The RTC card we install is no problem; there are 4MB of mappable
register address space on the card and we map that to kernel
memory with no problems.

The IBB's on the other hand are.  Now I'll try and expalin this
as best I can, since I'm somewhat new to this whole system so
if I don't make any sense, let me know and I'll try and clarify.

The overall problem is that the more system memory we install,
the fewer IBB's we can use.  For instance, 256MB lets us use
four IBB's; 512MB lets us use three IBB's and so on.  Basicly,
the kernel blows up trying to map memory.  Each IBB has two
banks of 64MB of RAM on them which we try and memmap to system
memory for speed of addressing.  So essentaily, we're sending
out four camera systems with only 256MB of memory which is only
about one quarter of what we need.

I can't think of any better way to explain it other than it's
almost like adding system memory subtracts from kernel memory.
Does that make any sense?  We've tried building the kernel with
the 4GB memory model and the 64GB memory model and had no success.

I'll post a snipped copy of /var/log/messages at the end of this
message and maybe someone who knows more than I can make sense of
it.  If needed, I can also post the source code for the device
driver and maybe someone can spot a flaw in there.  

This problem is driving me nuts ... I realize that are hardware is
very unique but I'd find it hard to beleive that we're the only
ones trying to map memory from PCI cards to host memory.  If fact
I know we're not because I've worked on a CAD system that has a 4GB
video card and they map half that memory to host memory for blowing
pixels on the screen.

Any help that can be offered would be GREATLY useful!
(I'll post the code for the driver if needed)

Thanks in advance,

-brian

Brian D. McGrew { brian@doubledimension.com || brian@visionpro.com }

---[ Begin /var/log/messages ]---

Aug 17 14:59:47 mvp-221 kernel: ibb_init_module: Start
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: enter
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: IBB Device 0x00000cb1 has been found @bus 1 dev 4 func 0
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: device 0
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Control Register
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Height Sensor
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Col Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Row Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map FB Addr Count
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Cameral Delay Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Frame Size Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Exposure Time Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Pixel LUT Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Frame Buffer 0 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 0 64 put CE1E57E at addr e0931000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 0 64 read CE1E57E at addr e0931000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 0 64 read A5AAD8B6 at addr e2931000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(0): fb0 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(0): Successful map Frame Buffer 1 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 1 64 put CE1E57E at addr e4932000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 1 64 read CE1E57E at addr e4932000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(0): Frame Buffer 1 64 read 17A8D6A6 at addr e6932000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(0): fb1 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(0): IbbUserShared 4
Aug 17 14:59:47 mvp-221 kernel: ibb_probe(0): got major 254
Aug 17 14:59:47 mvp-221 kernel: MVP Camera Link Single IBB: ibb0,CB1. , Int: 17
Aug 17 14:59:47 mvp-221 kernel: MVP driver(0) $Id: ibb.c,v 1.2 2004/08/03 21:49:48 celeste Exp $(c) MVP 
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: enter
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: IBB Device 0x00000cb1 has been found @bus 1 dev 6 func 0
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: device 1
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Control Register
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Height Sensor
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Col Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Row Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map FB Addr Count
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Cameral Delay Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Frame Size Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Exposure Time Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Pixel LUT Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Frame Buffer 0 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 0 64 put CE1E57E at addr e8947000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 0 64 read CE1E57E at addr e8947000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 0 64 read B5BE784B at addr ea947000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(1): fb0 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(1): Successful map Frame Buffer 1 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 1 64 put CE1E57E at addr ec948000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 1 64 read CE1E57E at addr ec948000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(1): Frame Buffer 1 64 read A5BBBB99 at addr ee948000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(1): fb1 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(1): IbbUserShared 4
Aug 17 14:59:47 mvp-221 kernel: ibb_probe(1): got major 253
Aug 17 14:59:47 mvp-221 kernel: MVP Camera Link Single IBB: ibb1,CB1. , Int: 20
Aug 17 14:59:47 mvp-221 kernel: MVP driver(1) $Id: ibb.c,v 1.2 2004/08/03 21:49:48 celeste Exp $(c) MVP 
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: enter
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: IBB Device 0x00000cb1 has been found @bus 1 dev 8 func 0
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: device 2
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Control Register
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Height Sensor
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Col Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Row Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map FB Addr Count
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Cameral Delay Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Frame Size Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Exposure Time Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Pixel LUT Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Frame Buffer 0 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 0 64 put CE1E57E at addr f095d000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 0 64 read CE1E57E at addr f095d000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 0 64 read A187853A at addr f295d000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(2): fb0 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(2): Successful map Frame Buffer 1 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 1 64 put CE1E57E at addr f495e000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 1 64 read CE1E57E at addr f495e000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(2): Frame Buffer 1 64 read A5AAA5E6 at addr f695e000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(2): fb1 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(2): IbbUserShared 4
Aug 17 14:59:47 mvp-221 kernel: ibb_probe(2): got major 252
Aug 17 14:59:47 mvp-221 kernel: MVP Camera Link Single IBB: ibb2,CB1. , Int: 21
Aug 17 14:59:47 mvp-221 kernel: MVP driver(2) $Id: ibb.c,v 1.2 2004/08/03 21:49:48 celeste Exp $(c) MVP 
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: enter
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: IBB Device 0x00000cb1 has been found @bus 1 dev 10 func 0
Aug 17 14:59:47 mvp-221 kernel: ibb_probe: device 3
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Control Register
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Height Sensor
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Col Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Row Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map FB Addr Count
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Cameral Delay Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Frame Size Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Exposure Time Reg
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Pixel LUT Sram
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Frame Buffer 0 64
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(3): Frame Buffer 0 64 put CE1E57E at addr f8973000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(3): Frame Buffer 0 64 read CE1E57E at addr f8973000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_frame_buffer(3): Frame Buffer 0 64 read 5A75DA1D at addr fa973000
Aug 17 14:59:47 mvp-221 kernel: ibb_do_all_mappings(3): fb0 Mapped Size 4000000
Aug 17 14:59:47 mvp-221 kernel: ibb_map_one(3): Successful map Frame Buffer 1 64
Aug 17 14:59:47 mvp-221 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug 17 14:59:47 mvp-221 kernel:  printing eip:
Aug 17 14:59:48 mvp-221 kernel: e08c1204
Aug 17 14:59:48 mvp-221 kernel: *pde = 1a9d1001
Aug 17 14:59:48 mvp-221 kernel: *pte = 00000000
Aug 17 14:59:48 mvp-221 kernel: Oops: 0002
Aug 17 14:59:48 mvp-221 kernel: CPU:    1
Aug 17 14:59:48 mvp-221 kernel: EIP:    0010:[<e08c1204>]    Tainted: P 
Aug 17 14:59:48 mvp-221 kernel: EFLAGS: 00010246
Aug 17 14:59:48 mvp-221 kernel: eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c032f20c
Aug 17 14:59:48 mvp-221 kernel: esi: 0ce1e57e   edi: db8d9e64   ebp: da9d3e4c   esp: da9d3dc4
Aug 17 14:59:48 mvp-221 kernel: ds: 0018   es: 0018   ss: 0018
Aug 17 14:59:48 mvp-221 kernel: Process insmod (pid: 1331, stackpage=da9d3000)
Aug 17 14:59:48 mvp-221 kernel: Stack: 6d617246 75422065 72656666 36203120 c0330034 00000030 00000286 da9d3e7c 
Aug 17 14:59:48 mvp-221 kernel:        c012145f c032f214 c03cd7aa 00000001 00000286 00000001 c032f20c c0121555 
Aug 17 14:59:48 mvp-221 kernel:        0000485a 0000485a 00000000 ffffee28 00000033 da9d3e7c c01219e9 00004827 
Aug 17 14:59:48 mvp-221 kernel: Call Trace:    [<c012145f>] [<c0121555>] [<c01219e9>] [<c0121809>] [<e08c1648>]
Aug 17 14:59:48 mvp-221 kernel:   [<e08c39c9>] [<c02d458f>] [<e08c1c09>] [<e08c1b20>] [<c0121555>] [<e08c449c>]
Aug 17 14:59:48 mvp-221 kernel:   [<e08c44e0>] [<c0266f25>] [<e08c449c>] [<e08c44e0>] [<c0266fcc>] [<e08c44e0>]
Aug 17 14:59:48 mvp-221 kernel:   [<e08c201e>] [<e08c44e0>] [<e08c2011>] [<c0122c4d>] [<e08c0060>] [<e08c0060>]
Aug 17 14:59:48 mvp-221 kernel:   [<c0109863>]
Aug 17 14:59:48 mvp-221 kernel: 
Aug 17 14:59:48 mvp-221 kernel: Code: 89 33 83 3d e4 43 8c e0 2d 76 1f 83 ec 0c 53 56 8d 85 78 ff 

---[ End /var/log/messages ]---
