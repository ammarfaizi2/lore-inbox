Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290845AbSAaCr7>; Wed, 30 Jan 2002 21:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290846AbSAaCrq>; Wed, 30 Jan 2002 21:47:46 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:36468 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S290845AbSAaCrX>;
	Wed, 30 Jan 2002 21:47:23 -0500
Date: Thu, 31 Jan 2002 02:55:21 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5 kernels - SCSI related issues
Message-ID: <20020131025521.A11899@bleach>
In-Reply-To: <20020131013622.A262@bleach> <20020131014034.B262@bleach>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020131014034.B262@bleach>; from l16083@alunos.uevora.pt on Thu, Jan 31, 2002 at 01:40:34 +0000
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 31 Jan 2002 02:47:17.0237 (UTC) FILETIME=[9871D250:01C1AA01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's the ksymoops output for the oops I told you about in the 
previous email..


Unable to handle kernel NULL pointer dereference at virtual address 
000000040
c01c0263
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c0263>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1f4b000     ecx: c1f8a360       edx: 00000000
esi: c1f4b018   edi: c1f4b134     ebp: c1f8a360       esp: c1091e3c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1091000)
Stack: c1091fbc c1091fbc c01c059e c1f4b000 c1091fbc c1091fbc c1091fd0 
c1f8a360
        c1091e78 ffffffff c0249100 c1091e78 00000000 00000000 c1f4b000 
00000212
        00000001 00000019 00000000 00000000 c00ba300 c017ad2b c1081000 
00000000
Call Trace: [<c01c059e>] [<c017ad2b>] [<c01f10c7>] [<c017b866>] 
[<c017f61c>]
    [<c017ec02>] [<c01131c6>] [<c011322b>] [<c0113301>] [<c0113523>] 
[<c0113474>]
    [<c01bb9f7>] [<c0105023>] [<c0107004>]
Code: 8b 50 40 8b 40 3c eb 12 90 8d 75 26 00 f6 41 7a 02 74 07 b8

>> EIP; c01c0262 <scsi_initialize_merge_fn+2a/58>   <=====
Trace; c01c059e <scan_scsis+c6/444>
Trace; c017ad2a <scrup+6a/104>
Trace; c01f10c6 <vgacon_cursor+17e/188>
Trace; c017b866 <set_cursor+6e/88>
Trace; c017f61c <poke_blanked_console+60/64>
Trace; c017ec02 <vt_console_print+2d2/2e4>
Trace; c01131c6 <__call_console_drivers+3a/4c>
Trace; c011322a <_call_console_drivers+52/58>
Trace; c0113300 <call_console_drivers+d0/d8>
Trace; c0113522 <release_console_sem+72/78>
Trace; c0113474 <printk+104/110>
Trace; c01bb9f6 <scsi_register_host+1ba/2b0>
Trace; c0105022 <init+6/114>
Trace; c0107004 <kernel_thread+28/38>
Code;  c01c0262 <scsi_initialize_merge_fn+2a/58>
00000000 <_EIP>:
Code;  c01c0262 <scsi_initialize_merge_fn+2a/58>   <=====
    0:   8b 50 40                  mov    0x40(%eax),%edx   <=====
Code;  c01c0264 <scsi_initialize_merge_fn+2c/58>
    3:   8b 40 3c                  mov    0x3c(%eax),%eax
Code;  c01c0268 <scsi_initialize_merge_fn+30/58>
    6:   eb 12                     jmp    1a <_EIP+0x1a> c01c027c 
<scsi_initialize_merge_fn+44/58>
Code;  c01c026a <scsi_initialize_merge_fn+32/58>
    8:   90                        nop    Code;  c01c026a 
<scsi_initialize_merge_fn+32/58>
    9:   8d 75 26                  lea    0x26(%ebp),%esi
Code;  c01c026e <scsi_initialize_merge_fn+36/58>
    c:   00 f6                     add    %dh,%dh
Code;  c01c0270 <scsi_initialize_merge_fn+38/58>
    e:   41                        inc    %ecx
Code;  c01c0270 <scsi_initialize_merge_fn+38/58>
    f:   7a 02                     jp     13 <_EIP+0x13> c01c0274 
<scsi_initialize_merge_fn+3c/58>
Code;  c01c0272 <scsi_initialize_merge_fn+3a/58>
   11:   74 07                     je     1a <_EIP+0x1a> c01c027c 
<scsi_initialize_merge_fn+44/58>
Code;  c01c0274 <scsi_initialize_merge_fn+3c/58>
   13:   b8 00 00 00 00            mov    $0x0,%eax

  <0>Kernel panic: Attempted to kill init!

Hope this helps
