Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWBVWDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWBVWDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWBVWDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:03:05 -0500
Received: from smtpout.mac.com ([17.250.248.47]:5116 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751477AbWBVWDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:03:03 -0500
X-PGP-Universal: processed;
	by AlPB on Wed, 22 Feb 2006 16:03:02 -0600
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B9658D7-1522-4936-9492-FED2DFD38D2A@mac.com>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: Linux 2.6.16-rc4 edac oops
Date: Wed, 22 Feb 2006 16:02:48 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find that I sometimes get a non-fatal oops during boot with the  
7520 EDAC stuff in place. It doesn't happen on every boot, but fairly  
often. I also saw it on -rc3, but decided to try -rc4 before  
reporting it. This is in a nearly monolithic kernel, so don't be  
surprised when it shows that there are no modules. Here is the  
ksymoops output:

1023MB LOWMEM available.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
CPU 0 irqstacks, hard=b03ec000 soft=b03ea000
CPU 1 irqstacks, hard=b03ed000 soft=b03eb000
Machine check exception polling timer started.
e1000: 0000:02:03.0: e1000_probe: (PCI-X:133MHz:64-bit)  
00:30:48:2e:ff:82
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:02:03.1: e1000_probe: (PCI-X:133MHz:64-bit)  
00:30:48:2e:ff:83
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:04:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x4)  
00:15:17:00:21:22
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:04:00.1: e1000_probe: (PCI Express:2.5Gb/s:Width x4)  
00:15:17:00:21:23
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
ehci_hcd 0000:00:1d.7: debug port 1
EDAC MC0: Giving out device to "e752x_edac" E7520: PCI 0000:00:00.0
Unable to handle kernel NULL pointer dereference at virtual address  
00000020
b0282dc4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<b0282dc4>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010096   (2.6.16-rc4-750-0a #1)
eax: 00000000   ebx: b1950f94   ecx: 00000040   edx: 00000000
esi: b195a6e0   edi: 00000000   ebp: 00000000   esp: b1950f74
ds: 007b   es: 007b   ss: 0068
Stack: <0>00000001 b195a6e0 00000000 b195a000 b195a000 00000000  
00000000 b0283245
        00000000 00000000 00000000 00000000 00000000 00000000  
00000000 00000000
        00000000 00000000 00000000 b1950fd4 b195a000 00000286  
b0282531 b1950000
Call Trace:
[<b0283245>]
[<b0282531>]
[<b0282582>]
[<b028253e>]
[<b0101af9>]
Code: ed fe ff ff 55 b9 0b 00 00 00 57 56 89 c6 53 89 d3 31 d2 83 ec  
0c 89 df 89 d0 f3 ab 8b 76 4c b9 40 00 00 00 89 74 24 04 8b 7e 08  
<8b> 57 20 8b 47 10 89 1c 24 e8 7c 8f f5 ff 8b 33 85 f6 75 29 8d


 >>EIP; b0282dc4 <e752x_check_hub_interface+3c/a3>   <=====

 >>ebx; b1950f94 <pg0+1536f94/4fbe4400>
 >>esi; b195a6e0 <pg0+15406e0/4fbe4400>
 >>esp; b1950f74 <pg0+1536f74/4fbe4400>

Trace; b0283245 <e752x_get_error_info+f8/389>
Trace; b0282531 <edac_mc_handle_ue+1e7/20e>
Trace; b0282582 <edac_mc_handle_ue_no_info+2a/5c>
Trace; b028253e <edac_mc_handle_ue+1f4/20e>
Trace; b0101af9 <kernel_thread_helper+5/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  b0282d99 <e752x_check_hub_interface+11/a3>
00000000 <_EIP>:
Code;  b0282d99 <e752x_check_hub_interface+11/a3>
    0:   ed                        in     (%dx),%eax
Code;  b0282d9a <e752x_check_hub_interface+12/a3>
    1:   fe                        (bad)
Code;  b0282d9b <e752x_check_hub_interface+13/a3>
    2:   ff                        (bad)
Code;  b0282d9c <e752x_check_hub_interface+14/a3>
    3:   ff 55 b9                  call   *0xffffffb9(%ebp)
Code;  b0282d9f <e752x_check_hub_interface+17/a3>
    6:   0b 00                     or     (%eax),%eax
Code;  b0282da1 <e752x_check_hub_interface+19/a3>
    8:   00 00                     add    %al,(%eax)
Code;  b0282da3 <e752x_check_hub_interface+1b/a3>
    a:   57                        push   %edi
Code;  b0282da4 <e752x_check_hub_interface+1c/a3>
    b:   56                        push   %esi
Code;  b0282da5 <e752x_check_hub_interface+1d/a3>
    c:   89 c6                     mov    %eax,%esi
Code;  b0282da7 <e752x_check_hub_interface+1f/a3>
    e:   53                        push   %ebx
Code;  b0282da8 <e752x_check_hub_interface+20/a3>
    f:   89 d3                     mov    %edx,%ebx
Code;  b0282daa <e752x_check_hub_interface+22/a3>
   11:   31 d2                     xor    %edx,%edx
Code;  b0282dac <e752x_check_hub_interface+24/a3>
   13:   83 ec 0c                  sub    $0xc,%esp
Code;  b0282daf <e752x_check_hub_interface+27/a3>
   16:   89 df                     mov    %ebx,%edi
Code;  b0282db1 <e752x_check_hub_interface+29/a3>
   18:   89 d0                     mov    %edx,%eax
Code;  b0282db3 <e752x_check_hub_interface+2b/a3>
   1a:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  b0282db5 <e752x_check_hub_interface+2d/a3>
   1c:   8b 76 4c                  mov    0x4c(%esi),%esi
Code;  b0282db8 <e752x_check_hub_interface+30/a3>
   1f:   b9 40 00 00 00            mov    $0x40,%ecx
Code;  b0282dbd <e752x_check_hub_interface+35/a3>
   24:   89 74 24 04               mov    %esi,0x4(%esp)
Code;  b0282dc1 <e752x_check_hub_interface+39/a3>
   28:   8b 7e 08                  mov    0x8(%esi),%edi

This decode from eip onwards should be reliable

Code;  b0282dc4 <e752x_check_hub_interface+3c/a3>
00000000 <_EIP>:
Code;  b0282dc4 <e752x_check_hub_interface+3c/a3>   <=====
    0:   8b 57 20                  mov    0x20(%edi),%edx   <=====
Code;  b0282dc7 <e752x_check_hub_interface+3f/a3>
    3:   8b 47 10                  mov    0x10(%edi),%eax
Code;  b0282dca <e752x_check_hub_interface+42/a3>
    6:   89 1c 24                  mov    %ebx,(%esp)
Code;  b0282dcd <e752x_check_hub_interface+45/a3>
    9:   e8 7c 8f f5 ff            call   fff58f8a <_EIP+0xfff58f8a>
Code;  b0282dd2 <e752x_check_hub_interface+4a/a3>
    e:   8b 33                     mov    (%ebx),%esi
Code;  b0282dd4 <e752x_check_hub_interface+4c/a3>
   10:   85 f6                     test   %esi,%esi
Code;  b0282dd6 <e752x_check_hub_interface+4e/a3>
   12:   75 29                     jne    3d <_EIP+0x3d>
Code;  b0282dd8 <e752x_check_hub_interface+50/a3>
   14:   8d                        .byte 0x8d

e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex

I have sometimes seen the oops occur in e752x_get_error_info as well.

-- 
Mark Rustad, MRustad@mac.com

