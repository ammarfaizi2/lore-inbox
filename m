Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUCSSqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUCSSqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:46:49 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:48610 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S263057AbUCSSqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:46:44 -0500
Date: Fri, 19 Mar 2004 19:46:40 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4 UHCI HCD BUG
Message-ID: <20040319184640.GA1938@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.6.4 if I do rmmod uhci_hcd and then modprobe uhci_hcd while running
X server with USB mouse connected to UHCI USB I got:
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free all object
s
Call Trace:
 [<c013c154>] kmem_cache_destroy+0x85/0xf3
 [<d0e9ec9b>] uhci_hcd_cleanup+0x1c/0x61 [uhci_hcd]
 [<c01307f8>] sys_delete_module+0x12d/0x154
 [<c010af61>] do_IRQ+0x10d/0x140
 [<c01092c9>] sysenter_past_esp+0x52/0x71

drivers/usb/host/uhci-hcd.c: not all urb_priv's were freed!
USB Universal Host Controller Interface driver v2.2
kmem_cache_create: duplicate cache uhci_urb_priv
------------[ cut here ]------------
kernel BUG at mm/slab.c:1314!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c013be42>]    Not tainted
EFLAGS: 00210202
EIP is at kmem_cache_create+0x3e9/0x48f
eax: 00000031   ebx: ceda82c8   ecx: c03df728   edx: cd0ea000
esi: d0e9f2da   edi: d0e9f2da   ebp: ceda81e8   esp: cd0ebf4c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 11450, threadinfo=cd0ea000 task=c32cee40)
Stack: c0304c80 d0e9f2cc 00000000 cd0ebf68 ceda8224 c0000000 fffffffc 00000010 
       00000000 fffffff4 c0342cb8 cd0ea000 d08a60ce d0e9f2cc 0000002c 00000080 
       00000000 00000000 00000000 c0342cd0 d0ea1100 c01321fb c03df5e4 00000001 
Call Trace:
 [<d08a60ce>] uhci_hcd_init+0xce/0x130 [uhci_hcd]
 [<c01321fb>] sys_init_module+0x12e/0x24b
 [<c01092c9>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 22 05 c2 44 30 c0 8b 0b e9 76 ff ff ff 8b 47 34 c7 04

USB in /proc/pci:
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 3).
      IRQ 5.
      I/O at 0x1820 [0x183f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 3).
      IRQ 11.
      I/O at 0x1840 [0x185f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 3).
      IRQ 4.
      I/O at 0x1860 [0x187f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801DB USB2 (rev 3).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xe0100000 [0xe01003ff].


-- 
Luká¹ Hejtmánek
