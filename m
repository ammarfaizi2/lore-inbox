Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbSKEXH5>; Tue, 5 Nov 2002 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSKEXH5>; Tue, 5 Nov 2002 18:07:57 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:30933 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265319AbSKEXHy>;
	Tue, 5 Nov 2002 18:07:54 -0500
Subject: Panic on startup with e1000, PPC64
From: "David C. Hansen" <haveblue@us.ibm.com>
To: scott.feldman@intel.com
Cc: Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 15:13:47 -0800
Message-Id: <1036538028.6194.59.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just put a pair of e1000's in my 4-way PPC64 box and booted a
known-good kernel.  It oopsed on boot.  I'm going to try 2.5 next.

Linux version 2.4.20-pre4 (anton@superego) (gcc version 3.2.1 20021007
(prerelease)) #48 SMP Tue Oct 29 18:14:24 EST 2002
...
Intel(R) PRO/1000 Network Driver - version 4.3.2-k1
Copyright (c) 1999-2002 Intel Corporation.
PCI: Enabling device 40:0b.0 (0140 -> 0143)
eth0: Intel(R) PRO/1000 Network Connection
NIP:  C0000000001D5358 
MSR:  a000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c00000003ff38000[1] swapper Last syscall: 120 
last math 0000000000000000 
GPR00: 0000000000000000 C00000003FF3B8F0 
       C00000000053A000 C00000003FEC3C58 
GPR04: 0000000002205800 0000000000000000 
       0000000000000000 0000000000000000 
GPR08: 0000000000000003 E000000000103000 
       E000000002248000 E000000002308800 
GPR12: C0000000005C5728 C00000003FF38000
       0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000220000
       0000000000000001 C0000000004DC5E0 
GPR24: 0000000000000001 C00000003FF22000
       C00000003FEC3A60 0000000006EC0269 
GPR28: C00000003FEC3C58 0000000002205804
       C000000000423698 C00000003FEC3C58 
cpu 1: Vector: 300 (Data Access) at  [c00000003ff3b670]
    pc: c0000000001d5358 (e1000_io_write+0x50)
   msr: a000000000009032
Warning (Oops_read): Code line not seen, dumping what data is available


>>GPR1; c00000003ff3b8f0 <END_OF_CODE+3f9128f0/????>
>>GPR4; 02205800 Before first symbol
>>GPR9; e000000000103000 <END_OF_CODE+1fffffffffada000/????>
>>GPR12; c0000000005c5728 <running_timer+0/8>
>>GPR13; c00000003ff38000 <END_OF_CODE+3f90f000/????>
>>GPR21; 00220000 Before first symbol
>>GPR25; c00000003ff22000 <END_OF_CODE+3f8f9000/????>
>>GPR28; c00000003fec3c58 <END_OF_CODE+3f89ac58/????>
>>GPR29; 02205804 Before first symbol

Call backtrace: 
C00000003FE7D110 Unknown
C0000000001D6890 e1000_reset_hw+0x544
C0000000001D0600 e1000_reset+0x60
C0000000004C1E34 Unknown
C00000000025BC28 pci_announce_device+0x68
C00000000025BD58 pci_register_driver+0xb0
C0000000004C1974 Unknown
C0000000004AFA44 Unknown
C00000000000C420 init+0x6c
C000000000019514 Unknown
Kernel panic: kernel access of bad area pc c0000000001d5358 lr
c0000000001df4f0 address E000000002308800 tsk swapper/1
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c00000003fe7d110 <END_OF_CODE+3f854110/????>
Trace; c0000000001d6890 <.e1000_reset_hw+544/5b8>
Trace; 000e1000 Before first symbol
Trace; c0000000001d0600 <.e1000_reset+60/11c>
Trace; 000e1000 Before first symbol
Trace; c0000000004c1e34 <.e1000_probe+438/530>
Trace; c00000000025bc28 <.pci_announce_device+68/e8>
Trace; c00000000025bd58 <.pci_register_driver+b0/e8>
Trace; c0000000004c1974 <.e1000_init_module+54/dc>
Trace; c0000000004afa44 <.do_initcalls+3c/8c>
Trace; c00000000000c420 <.init+6c/238>
Trace; c000000000019514 <.kernel_thread+3c/48>

>>NIP; c0000000001d5358 <.e1000_io_write+50/80>   <=====

-- 
Dave Hansen
haveblue@us.ibm.com

