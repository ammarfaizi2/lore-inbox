Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUHVQNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUHVQNn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUHVQNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:13:43 -0400
Received: from tufnell.lon1.poggs.net ([193.109.194.18]:21724 "EHLO
	tufnell.lon1.poggs.net") by vger.kernel.org with ESMTP
	id S267696AbUHVQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:13:39 -0400
Date: Sun, 22 Aug 2004 17:13:38 +0100
From: Peter Hicks <peter.hicks@poggs.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 crash on Toshiba Tecra 9100
Message-ID: <20040822161338.GA21087@tufnell.lon1.poggs.net>
Reply-To: Peter Hicks <peter.hicks@poggs.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm having a bit of grief with 2.6.8.1 on a Toshiba Tecra 9100.  Earlier 2.6
kernels worked fine including 2.6.7.  An afternoon of kernel-fiddling has
shown that CONFIG_EDD causes the following oops whilst booting.

I'm now running 2.6.8.1 with CONFIG_EDD disabled and it works a treat.

=====
Unable to handle kernel NULL pointer dereference at virtual address 000007ff
dfc77704
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<dfc77704>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.8.1) 
eax: dfe94000   ebx: dfe94000   ecx: 00000006   edx: dfe941c0
esi: 000007ff   edi: dfe94000   ebp: 00000000   esp: deb7bedc
ds: 007b   es: 007b   ss: 0068
Stack: c0208dbd dfe94000 c019ca84 000000a0 e08ffd80 e0937b7c e09382a0 e0937f3f 
       e093aec0 dfe94000 ffffffed c019df54 dfe94000 e093aec0 ffffffed c019df93 
       e093aec0 dfe94000 c019dfc6 e093aee4 dfe94044 c01d7e2c dfe9404c e093aee4 
Call Trace:
 [<c0208dbd>] pcibios_enable_device+0x14/0x17
 [<c019ca84>] pci_enable_device_bars+0x1e/0x32
 [<e0937b7c>] agp_intel_probe+0x10e/0x409 [intel_agp]
 [<c019df54>] pci_device_probe_static+0x46/0x55
 [<c019df93>] __pci_device_probe+0x30/0x40
 [<c019dfc6>] pci_device_probe+0x23/0x3f
 [<c01d7e2c>] bus_match+0x32/0x5b
 [<c01d7f2d>] driver_attach+0x51/0x7b
 [<c0197b8b>] kobject_register+0x22/0x53
 [<c01d8333>] bus_add_driver+0x88/0xa3
 [<c01d879f>] driver_register+0x28/0x2c
 [<c019e1a4>] pci_register_driver+0x56/0x7c
 [<e091301d>] init_module+0x1d/0x2b [intel_agp]
 [<c012bc8b>] sys_init_module+0xe6/0x1f4
 [<c0103dbf>] syscall_call+0x7/0xb
Code: a4 87 a4 87 00 00 00 00 10 77 c7 df 69 6e 74 31 33 5f 64 65 


>>EIP; dfc77704 <__crc_pci_bus_alloc_resource+2d57cb/50a035>   <=====

>>eax; dfe94000 <__crc_pci_bus_alloc_resource+4f20c7/50a035>
>>ebx; dfe94000 <__crc_pci_bus_alloc_resource+4f20c7/50a035>
>>edx; dfe941c0 <__crc_pci_bus_alloc_resource+4f2287/50a035>
>>edi; dfe94000 <__crc_pci_bus_alloc_resource+4f20c7/50a035>
>>esp; deb7bedc <__crc_generic_file_aio_write+a1f10/8380b1>

Trace; c0208dbd <pcibios_enable_device+14/17>
Trace; c019ca84 <pci_enable_device_bars+1e/32>
Trace; e0937b7c <__crc_sleep_on+2be13d/547b36>
Trace; c019df54 <pci_device_probe_static+46/55>
Trace; c019df93 <__pci_device_probe+30/40>
Trace; c019dfc6 <pci_device_probe+23/3f>
Trace; c01d7e2c <bus_match+32/5b>
Trace; c01d7f2d <driver_attach+51/7b>
Trace; c0197b8b <kobject_register+22/53>
Trace; c01d8333 <bus_add_driver+88/a3>
Trace; c01d879f <driver_register+28/2c>
Trace; c019e1a4 <pci_register_driver+56/7c>
Trace; e091301d <__crc_sleep_on+2995de/547b36>
Trace; c012bc8b <sys_init_module+e6/1f4>
Trace; c0103dbf <syscall_call+7/b>

Code;  dfc77704 <__crc_pci_bus_alloc_resource+2d57cb/50a035>
00000000 <_EIP>:
Code;  dfc77704 <__crc_pci_bus_alloc_resource+2d57cb/50a035>   <=====
   0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
Code;  dfc77705 <__crc_pci_bus_alloc_resource+2d57cc/50a035>
   1:   87 a4 87 00 00 00 00      xchg   %esp,0x0(%edi,%eax,4)
Code;  dfc7770c <__crc_pci_bus_alloc_resource+2d57d3/50a035>
   8:   10 77 c7                  adc    %dh,0xffffffc7(%edi)
Code;  dfc7770f <__crc_pci_bus_alloc_resource+2d57d6/50a035>
   b:   df 69 6e                  fildll 0x6e(%ecx)
Code;  dfc77712 <__crc_pci_bus_alloc_resource+2d57d9/50a035>
   e:   74 31                     je     41 <_EIP+0x41>
Code;  dfc77714 <__crc_pci_bus_alloc_resource+2d57db/50a035>
  10:   33 5f 64                  xor    0x64(%edi),%ebx
Code;  dfc77717 <__crc_pci_bus_alloc_resource+2d57de/50a035>
  13:   65 00 00                  add    %al,%gs:(%eax)
=====

Problem is reproducable and I'm happy to test changes etc. as required.



Peter.
