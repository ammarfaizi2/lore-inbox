Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSKKUNR>; Mon, 11 Nov 2002 15:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSKKUNQ>; Mon, 11 Nov 2002 15:13:16 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:17363 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261286AbSKKUNP> convert rfc822-to-8bit; Mon, 11 Nov 2002 15:13:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: acenic problems on 2.5.47
Date: Mon, 11 Nov 2002 14:16:56 -0600
User-Agent: KMail/1.4.3
Cc: linux-acenic@SunSITE.dk
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211111416.56167.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to be having a driver issue with acenic Gb adapters on 2.5.47.  Out of 
four adapters, usually one, but sometimes two of the four adapters are 
initialized upon 'insmod acenic':

acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk
                            http://home.cern.ch/~jes/gige/acenic.html
eth1: Alteon AceNIC Gigabit Ethernet at 0xfba00000, irq 3
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:cf:21:2a:78
  PCI cache line size set incorrectly (64 bytes) by BIOS/FW, correcting to 128
  PCI bus width: 64 bits, speed: 66MHz, latency: 240 clks
  Disabling PCI memory write and invalidate
eth1: Firmware NOT running!
eth1: Alteon AceNIC Gigabit Ethernet at 0xfbb00000, irq 4
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:cf:21:2a:7c
  PCI cache line size set incorrectly (64 bytes) by BIOS/FW, correcting to 128
  PCI bus width: 64 bits, speed: 66MHz, latency: 240 clks
  Disabling PCI memory write and invalidate
eth1: Firmware NOT running!
eth1: Alteon AceNIC Gigabit Ethernet at 0xfbc00000, irq 10
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:cf:21:27:df
  PCI cache line size set incorrectly (64 bytes) by BIOS/FW, correcting to 128
  PCI bus width: 64 bits, speed: 66MHz, latency: 240 clks
  Disabling PCI memory write and invalidate
eth1: Firmware NOT running!
eth1: Alteon AceNIC Gigabit Ethernet at 0xfbc04000, irq 11
  Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:cf:21:27:e5
  PCI cache line size set incorrectly (64 bytes) by BIOS/FW, correcting to 128
  PCI bus width: 64 bits, speed: 66MHz, latency: 240 clks
  Disabling PCI memory write and invalidate
eth1: Firmware up and running


It appears the first three cards do not get the firmware up and running, while 
the fourth one does, and is assigned eth1.  I swear I have seen this before, 
but can't remember what the problem was.  Anybody know?  Also, an oops on 
rmmod:

Unable to handle kernel paging request at virtual address f8956140
f891b562
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<f891b562>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: f7c72000   ebx: 000003fc   ecx: 37d4a200   edx: f8956000
esi: f7c72160   edi: 00000100   ebp: f7c72000   esp: f6821f84
ds: 0068   es: 0068   ss: 0068
Stack: f891b000 fffffff0 f891b000 bfffe6fc c0116e53 f891b000 fffffff0 f6845000
       bfffe6fc c011639f f891b000 00000000 f6820000 0805fbf4 bfffe6dc c010874f
       bffff8f2 08067008 00000100 0805fbf4 bfffe6dc bfffe6fc 00000081 0000002b
Call Trace: [<c0116e53>]  [<c011639f>]  [<c010874f>]
Code: 8b 82 40 01 00 00 0d 00 00 01 00 89 82 40 01 00 00 83 7e 14

>>EIP; f891b562 <END_OF_CODE+384afc46/????>   <=====
Trace; c0116e52 <free_module+16/98>
Trace; c011639e <sys_delete_module+ea/1b0>
Trace; c010874e <syscall_call+6/a>
Code;  f891b562 <END_OF_CODE+384afc46/????>
00000000 <_EIP>:
Code;  f891b562 <END_OF_CODE+384afc46/????>   <=====
   0:   8b 82 40 01 00 00         mov    0x140(%edx),%eax   <=====
Code;  f891b568 <END_OF_CODE+384afc4c/????>
   6:   0d 00 00 01 00            or     $0x10000,%eax
Code;  f891b56c <END_OF_CODE+384afc50/????>
   b:   89 82 40 01 00 00         mov    %eax,0x140(%edx)
Code;  f891b572 <END_OF_CODE+384afc56/????>
  11:   83 7e 14 00               cmpl   $0x0,0x14(%esi)



Thanks,

Andrew Theurer
