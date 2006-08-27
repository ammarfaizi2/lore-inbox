Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWH0CNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWH0CNG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWH0CNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:13:05 -0400
Received: from es1036.belits.com ([64.58.22.200]:3798 "EHLO es1036.belits.com")
	by vger.kernel.org with ESMTP id S1751013AbWH0CND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:13:03 -0400
Message-ID: <44F0FF87.90907@belits.com>
Date: Sat, 26 Aug 2006 20:12:23 -0600
From: Alex Belits <abelits@belits.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.17.11 (and probably earlier versions) -- crash after  loading
 8250_pnp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.17.11 boots on a dual Athlon Tyan S2669 motherboard with 
serial console enabled. Serial console works until 8250_pnp module 
loads, then crashes.

Disabling the module fixes the problem.

00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
BUG: unable to handle kernel NULL pointer dereference at virtual address 
0000000 c
  printing eip:
c027b60d
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: 8250_pnp psmouse pcspkr rtc hw_random amd76x_edac 
edac_mc amd _k7_agp agpgart ohci_hcd usbcore e100 mii e1000 w83781d 
hwmon_vid hwmon i2c_isa i2c_amd756 i2c_core mousedev ide_cd cdrom 
non_fatal unix
CPU:    0
EIP:    0060:[<c027b60d>]    Not tainted VLI
EFLAGS: 00010296   (2.6.17.11 #1)
EIP is at uart_write_room+0xd/0x20
eax: c154e8c0   ebx: dfe53000   ecx: dea77efc   edx: 00000000
esi: 00000022   edi: dea76000   ebp: df97b000   esp: dea77e98
ds: 007b   es: 007b   ss: 0068
Process isapnp.rc (pid: 2950, threadinfo=dea76000 task=def30a70)
Stack: c026b25f dfe53000 00000282 00000282 00000022 df97b000 dea76000 
dfe53000
        c026d27e dfe53000 df97b000 00000022 dfe53134 00000000 00000000 
def30a70
        c0118cd0 00000000 00000000 c0267d92 c0267d92 c0267d92 00000000 
def30a70
Call Trace:
  <c026b25f> opost_block+0x1f/0x120  <c026d27e> write_chan+0x18e/0x230
  <c0118cd0> default_wake_function+0x0/0x20  <c0267d92> tty_write+0xc2/0x240
  <c0267d92> tty_write+0xc2/0x240  <c0267d92> tty_write+0xc2/0x240
  <c0118cd0> default_wake_function+0x0/0x20  <c0225ef6> 
copy_from_user+0x46/0x90
  <c0267e77> tty_write+0x1a7/0x240  <c026d0f0> write_chan+0x0/0x230
  <c0160a39> vfs_write+0xc9/0x1a0  <c0160be1> sys_write+0x51/0x80
  <c0102ef7> syscall_call+0x7/0xb
Code: 0a bd 0f 00 8b 4c 24 34 89 0c 24 e8 8e f9 ff ff 8b 44 24 10 e9 2b 
ff ff ff  90 8d 74 26 00 8b 44 24 04 8b 80 80 01 00 00 8b 50 10 <8b> 42 
0c 2b 42 08 48 25  ff 0f 00 00 c3 8d b6 00 00 00 00 8b 44
EIP: [<c027b60d>] uart_write_room+0xd/0x20 SS:ESP 0068:dea77e98
  BUG: isapnp.rc/2950, lock held at task exit time!
  [dfe53400] {initialize_tty_struct}
.. held by:         isapnp.rc: 2950 [def30a70, 125]
... acquired at:               tty_write+0xc2/0x240
