Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSCDB4P>; Sun, 3 Mar 2002 20:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSCDB4G>; Sun, 3 Mar 2002 20:56:06 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:16263 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S290827AbSCDBzs>;
	Sun, 3 Mar 2002 20:55:48 -0500
Date: Mon, 4 Mar 2002 02:55:44 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request when accessing /proc/bus/pnp/escd
 in 2.4.19-pre1-ac2
Message-ID: <Pine.LNX.4.21.0203040246470.8495-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was just looking around in /proc/bus a little and I tried 
'cat /proc/bus/pnp/escd' and I got this:

Unable to handle kernel paging request at virtual address ffffa00a
00007598
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0068:[<00007598>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210086
eax: 000022ff   ebx: 00806b06   ecx: 00000070   edx: 00000000
esi: 0000000a   edi: 00200000   ebp: c6f87737   esp: c6f83eb0
ds: 0080   es: 0078   ss: 0018
Process cat (pid: 8454, stackpage=c6f83000)
Stack: 000a0002 00800000 00060078 7741757a 00000000 687a0070 6b1f3ee4 00180000 
       02460018 69740042 00960078 cb4c6000 0060000b 00000042 00800078 00000070 
       00000000 c01d3956 00000010 00200046 00000000 00200000 d0aa0018 c0110018 
Call Trace: [<c01d3956>] [<c0110018>] [<c01d39ac>] [<c01d402f>] [<c014ed1a>] 
   [<c0130ec6>] [<c0106b1b>] 
Code:  Bad EIP value.

>>EIP; 00007598 Before first symbol   <=====
Trace; c01d3956 <__pnp_bios_read_escd+ce/114>
Trace; c0110018 <apm_mainloop+38/a0>
Trace; c01d39ac <pnp_bios_read_escd+10/30>
Trace; c01d402e <proc_read_escd+6e/e8>
Trace; c014ed1a <proc_file_read+f2/194>
Trace; c0130ec6 <sys_read+96/e4>
Trace; c0106b1a <system_call+32/38>

I assume this is for ISA Plug 'n Pray devices. I currently have no such
devices in my machine (I have an old sb16 and an ne2k ISA NIC but none are
operating in pnpmode)

This is from my bootmessages:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7540
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x68f4, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x4d0-0x4d1 has been reserved
PnPBIOS: PNP0c02: ioport range 0xcf8-0xcff could not be reserved
PnPBIOS: PNP0c02: ioport range 0x400-0x43f has been reserved
PnPBIOS: PNP0c02: ioport range 0x440-0x44f has been reserved
PnPBIOS: PNP0c02: ioport range 0x290-0x297 has been reserved

It's an Award BIOS on a Tyan S1830S board.

and now that I ran 'dmesg' again I see this:
 <3>PnPBIOS: get_stat_res: Unexpected status 0x8d

Hopefully someone knows what the problem is.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

