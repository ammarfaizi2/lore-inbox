Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290671AbSBTAsm>; Tue, 19 Feb 2002 19:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSBTAsd>; Tue, 19 Feb 2002 19:48:33 -0500
Received: from msg.vizzavi.pt ([212.18.167.162]:26574 "EHLO msg.vizzavi.pt")
	by vger.kernel.org with ESMTP id <S290671AbSBTAs0>;
	Tue, 19 Feb 2002 19:48:26 -0500
Date: Wed, 20 Feb 2002 00:58:11 +0000
From: "Paulo Andre'" <l16083@alunos.uevora.pt>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Oops in _every_ 2.5 kernel - SCSI changes
Message-ID: <20020220005811.C488@bleach>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.0
X-OriginalArrivalTime: 20 Feb 2002 00:48:19.0525 (UTC) FILETIME=[4A4C6750:01C1B9A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This is a very keen and motivated kernel hacker newbie here. That said, 
bear with me :)

I've been fighting with the 2.5 branch for sometime now in order to 
successfully boot it on a SCSI machine. I have no problems whatsoever 
with known 'good' 2.4 releases. So, in trying to do my homework I 
compiled 2.5.0 (or rather 2.5.1-pre1, since 2.5.0 is -greased-turkey) 
successfully but it chokes right in 2.5.1-pre2 (and any later kernel 
for that matter). I assume this has something to do with Jens' changes, 
at least regarding the Changelog..

pre2:
  - Greg KH: USB update
  - Richard Gooch: refcounting for devfs
  - Jens Axboe: start of new block IO layer

I'm rulling out USB stuff since it doesn't have any USB devices 
whatsoever (therefore no support compiled) and also I don't think it is 
devfs problem. I've fed the oops file to ksymoops and here's what it 
spits (btw, this was a cross-compile, which explains why ksymoops runs 
on a 2.4.17 kernel. I've used the correct vmlinux and System.map though 
and no modules):

ksymoops 2.4.3 on i686 2.4.17-prla2.  Options used
      -v vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.17-prla2/ (default)
      -m System.map (specified) Error (regular_file): read_ksyms stat 
/proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 
00000040
c019a1e3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c019a1e3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1f4d000     ecx: c1f8a260       edx: 00000000
esi: c1f4d018   edi: c1f4d134     ebp: c1f8a260       esp: c1091e3c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1091000)
Stack: c1091fbc c1091fbc c019a51e c1f4d000 c1091fbc c1091fbc c1091fd0 
c1f8a260
        c1091e78 ffffffff c02234c0 c1091e78 00000000 00000000 c1f4d000 
00000216
        00000001 00000019 00000000 00000000 c00b9f40 c017a7cb c1081000 
00000000
Call Trace: [<c019a51e>] [<c017a7cb>] [<c01cc4e7>] [<c017b306>] 
[<c017f0bc>]
    [<c017e6a2>] [<c01126e6>] [<c011274b>] [<c0112821>] [<c0112a43>] 
[<c0112994>]
    [<c0195977>] [<c0105023>] [<c0107004>]
Code: 8b 50 40 8b 40 3c eb 12 90 8d 74 26 00 f6 41 7a 02 74 07 
b8 >>EIP; c019a1e2 <scsi_initialize_merge_fn+2a/58>   <=====
Trace; c019a51e <scan_scsis+c6/444>
Trace; c017a7ca <scrup+6a/104>
Trace; c01cc4e6 <vgacon_cursor+17e/188>
Trace; c017b306 <set_cursor+6e/88>
Trace; c017f0bc <poke_blanked_console+60/64>
Trace; c017e6a2 <vt_console_print+2d2/2e4>
Trace; c01126e6 <__call_console_drivers+3a/4c>
Trace; c011274a <_call_console_drivers+52/58>
Trace; c0112820 <call_console_drivers+d0/d8>
Trace; c0112a42 <release_console_sem+72/78>
Trace; c0112994 <printk+104/110>
Trace; c0195976 <scsi_register_host+1ba/2b0>
Trace; c0105022 <init+6/114>
Trace; c0107004 <kernel_thread+28/38>
Code;  c019a1e2 <scsi_initialize_merge_fn+2a/58>
00000000 <_EIP>:
Code;  c019a1e2 <scsi_initialize_merge_fn+2a/58>   <=====
    0:   8b 50 40                  mov    0x40(%eax),%edx   <=====
Code;  c019a1e4 <scsi_initialize_merge_fn+2c/58>
    3:   8b 40 3c                  mov    0x3c(%eax),%eax
Code;  c019a1e8 <scsi_initialize_merge_fn+30/58>
    6:   eb 12                     jmp    1a <_EIP+0x1a> c019a1fc 
<scsi_initialize_merge_fn+44/58>
Code;  c019a1ea <scsi_initialize_merge_fn+32/58>
    8:   90                        nop   Code;  c019a1ea 
<scsi_initialize_merge_fn+32/58>
    9:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c019a1ee <scsi_initialize_merge_fn+36/58>
    d:   f6 41 7a 02               testb  $0x2,0x7a(%ecx)
Code;  c019a1f2 <scsi_initialize_merge_fn+3a/58>
   11:   74 07                     je     1a <_EIP+0x1a> c019a1fc 
<scsi_initialize_merge_fn+44/58>
Code;  c019a1f4 <scsi_initialize_merge_fn+3c/58>
   13:   b8 00 00 00 00            mov    $0x0,%eax  <0>Kernel panic: 
Attempted to kill init!


It oopses during the detection of the SCSI devices. This machine is an 
all-SCSI, Pentium-classic, with a AIC-7770 controller.

Some help would be much appreciated, since this is definitely a show 
stopper around here..

Thanks in advance,

// Paulo Andre'

  /~\ The ASCII
  \ / Ribbon Campaign
   X  Against HTML
  / \ Email!
