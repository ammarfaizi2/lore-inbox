Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129989AbRBJBSU>; Fri, 9 Feb 2001 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130137AbRBJBSK>; Fri, 9 Feb 2001 20:18:10 -0500
Received: from brooks.civeng.adelaide.edu.au ([129.127.78.254]:36998 "EHLO
	brooks.civeng.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S129989AbRBJBR7>; Fri, 9 Feb 2001 20:17:59 -0500
From: "Stephen Carr" <sgcarr@civeng.adelaide.edu.au>
To: dilinger@mp3revolution.net
Date: Sat, 10 Feb 2001 11:46:58 +1030
Subject: Panics from 2.4.2-pre2 kernel - ksymoops output
Reply-to: sgcarr@civeng.adelaide.edu.au
CC: linux-kernel@vger.kernel.org
Message-ID: <3A852A32.24505.54CE670@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this message earlier but it does no seem to have got on the 
mailing list - I now suspect I have a hardware problem since  I 
reverted to the 2.2.16 kernel which was previously stable and also 
got a panic of the type

Welcome to Linux 2.2.16.
elizabeth login: Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

Stephen Carr

---------------------
Sorry All

I had to get ksymoops - here is the analysis of my latest panic.
It is hard to run ksymoops on the system as it now very unstable.

The system had the eepro100 NIC driver loaded as per Alan Cox's 
request when these panics occurred.

File system checks can cause a system lock up.

I hope this helps if not inform me as to what is required.

I am going back to the 2.2.x kernel - I am will to help if patch/fix is 
found - it take more time to do a filesystem check than to get a 
panic.

These panics are in time sequence.

--------------------------------------
ksymoops 2.3.7 on i686 2.4.2-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-pre2/ (default)
     -m /usr/src/linux/System.map (default)

-----------------------------------------------------------

This occurred during a filesystem check.

Unable to handle kernel paging request at virtual address 44000000
c02a5f39
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c02a5f39>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 24000000   ebx: 00000001   ecx: 00000001   edx: 000000ff
esi: c1570600   edi: ca91d400   ebp: ca91d400   esp: c02a5ea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: c01c3315 c1570600 00000001 00000000 00000001 
00000001 00000001 c1570600
       00000002 c02a5f34 c15ab0c8 00000000 00000018 c15e8c78 
00000002 00000000
       c01e62f0 c1570600 00000002 00000001 c1570600 00000000 
00000bb7 c01c265e
Call Trace: [<c01c3315>] [<c01e62f0>] [<c01c265e>] 
[<c01d3ce0>] [<c01c8724>] [<c
01d3fa1>] [<c010a769>]
       [<c010a95e>] [<c01071c0>] [<c01071c0>] [<c01090b8>] 
[<c01071c0>] [<c01071
c0>] [<c0100018>] [<c01071ec>]
       [<c010724e>] [<c0105000>] [<c01001d0>]
Code: 87 1c c0 00 06 57 c1 78 b0 5a c1 a1 3f 1d c0 78 b0 5a c1 c0

>>EIP; c02a5f39 <init_task_union+1f39/2000>   <=====
Trace; c01c3315 <scsi_io_completion+169/34c>
Trace; c01e62f0 <rw_intr+154/15c>
Trace; c01c265e <scsi_old_done+5a6/5c4>
Trace; c01d3ce0 <aic7xxx_isr+d8/310>
Trace; c01c8724 <aic7xxx_done_cmds_complete+28/38>
Trace; c01d3fa1 <do_aic7xxx_isr+89/ac>
Trace; c010a769 <handle_IRQ_event+51/7c>
Trace; c010a95e <do_IRQ+9a/ec>
Trace; c01071c0 <default_idle+0/34>
Trace; c01071c0 <default_idle+0/34>
Trace; c01090b8 <ret_from_intr+0/20>
Trace; c01071c0 <default_idle+0/34>
Trace; c01071c0 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c01071ec <default_idle+2c/34>
Trace; c010724e <cpu_idle+3a/50>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001d0 <L6+0/2>
Code;  c02a5f39 <init_task_union+1f39/2000>
00000000 <_EIP>:
Code;  c02a5f39 <init_task_union+1f39/2000>   <=====
   0:   87 1c c0                  xchgl  %ebx,(%eax,%eax,8)   <=====
Code;  c02a5f3c <init_task_union+1f3c/2000>
   3:   00 06                     addb   %al,(%esi)
Code;  c02a5f3e <init_task_union+1f3e/2000>
   5:   57                        pushl  %edi
Code;  c02a5f3f <init_task_union+1f3f/2000>
   6:   c1 78 b0 5a               sarl   $0x5a,0xffffffb0(%eax)
Code;  c02a5f43 <init_task_union+1f43/2000>
   a:   c1 a1 3f 1d c0 78 b0      shll   $0xb0,0x78c01d3f(%ecx)
Code;  c02a5f4a <init_task_union+1f4a/2000>
  11:   5a                        popl   %edx
Code;  c02a5f4b <init_task_union+1f4b/2000>
  12:   c1 c0 00                  roll   $0x0,%eax

Kernel panic: Aiee, killing interrupt handler!

--------------------------
Panic during backup

Unable to handle kernel NULL pointer dereference at virtual address 
00000000
c031d0c0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c031d0c0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 000000ff
esi: c156f600   edi: c156f600   ebp: 00000000   esp: c02a5ea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: c01c3315 c156f600 ffffff8b 00000076 00000001 00000001 
00000001 c156f600
       00000078 c02a5f34 c031d0c4 c031d0c8 00000010 c15add98 
00000078 00000000
       c01e62f0 c156f600 00000078 00000001 c156f600 00000000 
00000bb8 c01c265e
Call Trace: [<c01c3315>] [<c01e62f0>] [<c01c265e>] 
[<c01d3ce0>] [<c01c8724>] [<c
01d3fa1>] [<c010a769>]
       [<c010a95e>] [<c01071c0>] [<c01071c0>] [<c01090b8>] 
[<c01071c0>] [<c01071
       [<c010724e>] [<c0105000>] [<c01001d0>]
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00

>>EIP; c031d0c0 <_end+348c/1050a42c>   <=====
Trace; c01c3315 <scsi_io_completion+169/34c>
Trace; c01e62f0 <rw_intr+154/15c>
Trace; c01c265e <scsi_old_done+5a6/5c4>
Trace; c01d3ce0 <aic7xxx_isr+d8/310>
Trace; c01c8724 <aic7xxx_done_cmds_complete+28/38>
Code;  c031d0c0 <_end+348c/1050a42c>
00000000 <_EIP>:

Kernel panic: Aiee, killing interrupt handler!
------------------------------------------------------------------

Panic during reboot when doing filesystem check

Unable to handle kernel paging request at virtual address 44000000
c02a5f39
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c02a5f39>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 24000000   ebx: 00000001   ecx: 00000001   edx: 000000ff
esi: c1570600   edi: c4923c00   ebp: c4923c00   esp: c02a5ea8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a5000)
Stack: c01c3315 c1570600 00000001 00000000 00000001 
00000001 00000001 c1570600
       00000002 c02a5f34 c15ab0c8 00000000 0000000f c15e8c78 
00000002 00000000
       c01e62f0 c1570600 00000002 00000001 c1570600 00000000 
00000bb7 c01c265e
Call Trace: [<c01c3315>] [<c01e62f0>] [<c01c265e>] 
[<c01d3ce0>] [<c01c8724>] [<c
01d3fa1>] [<c010a769>]
       [<c010a95e>] [<c01071c0>] [<c01071c0>] [<c01090b8>] 
[<c01071c0>] [<c01071
       [<c010724e>] [<c0105000>] [<c01001d0>]
Code: 87 1c c0 00 06 57 c1 78 b0 5a c1 a1 3f 1d c0 78 b0 5a c1 c0

>>EIP; c02a5f39 <init_task_union+1f39/2000>   <=====
Trace; c01c3315 <scsi_io_completion+169/34c>
Trace; c01e62f0 <rw_intr+154/15c>
Trace; c01c265e <scsi_old_done+5a6/5c4>
Trace; c01d3ce0 <aic7xxx_isr+d8/310>
Trace; c01c8724 <aic7xxx_done_cmds_complete+28/38>
Code;  c02a5f39 <init_task_union+1f39/2000>
00000000 <_EIP>:
Code;  c02a5f39 <init_task_union+1f39/2000>   <=====
   0:   87 1c c0                  xchgl  %ebx,(%eax,%eax,8)   <=====
Code;  c02a5f3c <init_task_union+1f3c/2000>
   3:   00 06                     addb   %al,(%esi)
Code;  c02a5f3e <init_task_union+1f3e/2000>
   5:   57                        pushl  %edi
Code;  c02a5f3f <init_task_union+1f3f/2000>
   6:   c1 78 b0 5a               sarl   $0x5a,0xffffffb0(%eax)
Code;  c02a5f43 <init_task_union+1f43/2000>
   a:   c1 a1 3f 1d c0 78 b0      shll   $0xb0,0x78c01d3f(%ecx)
Code;  c02a5f4a <init_task_union+1f4a/2000>
  11:   5a                        popl   %edx
Code;  c02a5f4b <init_task_union+1f4b/2000>
  12:   c1 c0 00                  roll   $0x0,%eax

Kernel panic: Aiee, killing interrupt handler!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
