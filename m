Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbULJT0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbULJT0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULJT0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:26:13 -0500
Received: from bay23-f4.bay23.hotmail.com ([64.4.22.54]:27143 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261805AbULJT0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:26:09 -0500
Message-ID: <BAY23-F4D13F4603A0C8EC362326AEA80@phx.gbl>
X-Originating-IP: [64.90.198.61]
X-Originating-Email: [jocosby@hotmail.com]
From: "Joseph Cosby" <jocosby@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops: NULL Pointer With Adaptec AIC-7901X Chipset
Date: Fri, 10 Dec 2004 12:25:51 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Dec 2004 19:26:05.0554 (UTC) FILETIME=[17C44D20:01C4DEEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a NULL Pointer oops with the AIC-7901X chipset from Adaptec.

Using a 2.6.9 kernel, and patching in the driver from Adaptec, I am getting 
a NULL pointer oops as linux is booting. The Null pointer is the variable 
sdev->request_queue, in the module scsi.c, in the function 
scsi_adjust_queue_depth.

ksymoops 2.4.9 on i686 2.6.5-1.358.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01f222a>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002   (2.6.9)
eax: 00000000   ebx: f7e91000   ecx: dfe09f40   edx: 00000000
esi: 00000000   edi: 00000002   ebp: 00000002   esp: dfe09f08
ds: 007b   es: 007b   ss: 0068
Stack: dfe09f40 f7ee0000 00000020 f7ee0000 c021b826 f7e91000 00000000 
00000002
       dfe09f40 dffa0180 c0232540 f7ee0000 def09f40 00000000 00000007 
00000000
       00000001 00000000 00000000 dffff241 00000001 c17f4a00 dffa0180 
c17fca00
Call Trace:
[<c021b826>]
[<c0232540>]
[<c022e7c0>]
[<c0230ecc>]
[<c02321b0>]
[<c0230c3c>]
[<c0230b20>]
[<c0104245>]
Code: 00 00 00 08 89 87 4c 01 00 00 eb 9c 90 8d 74 26 00 55 57 56 53 8b 7c 
24 1c


>>EIP; c01f222a <scsi_adjust_queue_depth+1a/b0>   <=====

>>ebx; f7e91000 <pg0+37b7d000/3fcea400>
>>ecx; dfe09f40 <pg0+1faf5f40/3fcea400>
>>esp; dfe09f08 <pg0+1faf5f08/3fcea400>

Trace; c021b826 <ahd_set_tags+16/40>
Trace; c0232540 <aic_linux_device_queue_depth+70/a0>
Trace; c022e7c0 <ahd_linux_queue+100/350>
Trace; c0230ecc <ahd_linux_dv_target+19c/410>
Trace; c02321b0 <ahd_linux_dv_complete+0/40>
Trace; c0230c3c <ahd_linux_dv_thread+11c/190>
Trace; c0230b20 <ahd_linux_dv_thread+0/190>
Trace; c0104245 <kernel_thread_helper+5/10>

Code;  c01f222a <scsi_adjust_queue_depth+1a/b0>
00000000 <_EIP>:
Code;  c01f222a <scsi_adjust_queue_depth+1a/b0>   <=====
   0:   00 00                     add    %al,(%eax)   <=====
Code;  c01f222c <scsi_adjust_queue_depth+1c/b0>
   2:   00 08                     add    %cl,(%eax)
Code;  c01f222e <scsi_adjust_queue_depth+1e/b0>
   4:   89 87 4c 01 00 00         mov    %eax,0x14c(%edi)
Code;  c01f2234 <scsi_adjust_queue_depth+24/b0>
   a:   eb 9c                     jmp    ffffffa8 <_EIP+0xffffffa8>
Code;  c01f2236 <scsi_adjust_queue_depth+26/b0>
   c:   90                        nop
Code;  c01f2237 <scsi_adjust_queue_depth+27/b0>
   d:   8d 74 26 00               lea    0x0(%esi),%esi
Code;  c01f223b <scsi_adjust_queue_depth+2b/b0>
  11:   55                        push   %ebp
Code;  c01f223c <scsi_adjust_queue_depth+2c/b0>
  12:   57                        push   %edi
Code;  c01f223d <scsi_adjust_queue_depth+2d/b0>
  13:   56                        push   %esi
Code;  c01f223e <scsi_adjust_queue_depth+2e/b0>
  14:   53                        push   %ebx
Code;  c01f223f <scsi_adjust_queue_depth+2f/b0>
  15:   8b 7c 24 1c               mov    0x1c(%esp),%edi

Thanks,
Joseph Cosby

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

