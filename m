Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270810AbTHCFhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 01:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270827AbTHCFhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 01:37:11 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:29574 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270810AbTHCFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 01:37:01 -0400
Date: Sat, 02 Aug 2003 22:36:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: barryn@pobox.com
Subject: [Bug 1033] New: floppy: bad sectors trigger oops and other chaos 
Message-ID: <97380000.1059889000@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1033

           Summary: floppy: bad sectors trigger oops and other chaos
    Kernel Version: 2.6.0-test2-bk2
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: barryn@pobox.com


Distribution: Mandrake cooker
Hardware Environment: x86, standard internal floppy drive
Software Environment: kernel compiled with Debian gcc 3.3.1 prerelease, -Os; it
also happens with gcc 2.95.3 and the default (-O2) compile option
Problem Description:
An attempt to read a floppy with a bad sector causes a kernel oops and a bunch
of error messages every 3-4 seconds until the thing gives up. Afterward,
keyboard input is basically ignored (it becomes impossible to switch virtual
consoles or to type into them, although the num/caps/scroll lock lights still
respond, and Magic SysRq still works).

BTW, I think I've gotten the same "can't type into or switch between VCs but the
lights still respond and I can still use Magic SysRq" problem (with no oops
though) when some CD recording errors happen. I'm not completely sure if it's an
error in CD recording that causes it (it has something to do with CD recording,
anyway), and that scenario is nearly impossible to reproduce on demand. This
floppy disk bug is quite easy to reproduce if you have a disk with a bad sector,
though.

Steps to reproduce:
1. Slide the write-protect tab on the floppy into the protected position.
2. Mount the floppy.
3. cat a file with a bad sector to /dev/null

I will attach the oopses soon.


Unable to handle kernel paging request at virtual address c3af5050
*pde = 0000d067
*pte = 03af5000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c025a3d2>]    Not tainted
EFLAGS: 00010246
EIP is at bad_flp_intr+0x9e/0xd8
eax: c3af5050   ebx: c0454200   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c5e37f60   esp: c5e37f58
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c5e36000 task=c5e42000)
Stack: 00000000 00000001 c5e37f84 c025ab8a c5e36000 c02585c0 c03d41c0 00000018
       00000282 00000002 00000002 c5e37f90 c02585d6 c03d4200 c5e37fec c012b40f
       00000000 c012b26c 00000000 00000000 c5e47a20 c5e47a18 00000000 c02585c0
Call Trace:
 [<c025ab8a>] rw_interrupt+0x1ee/0x33c
 [<c02585c0>] main_command_interrupt+0x0/0x1c
 [<c02585d6>] main_command_interrupt+0x16/0x1c
 [<c012b40f>] worker_thread+0x1a3/0x270
 [<c012b26c>] worker_thread+0x0/0x270
 [<c02585c0>] main_command_interrupt+0x0/0x1c
 [<c011b760>] default_wake_function+0x0/0x20
 [<c011b760>] default_wake_function+0x0/0x20
 [<c0108cb1>] kernel_thread_helper+0x5/0xc

Code: 8b 00 3b 44 13 30 76 16 a1 60 52 45 c0 c1 e0 05 80 88 34 52

floppy driver state
-------------------
now=4294901504 last interrupt=4294881496 diff=20008 last called handler=c02585c0
timeout_message=request done %d
last output bytes:
 0 90 4294880899
 3 80 4294880899
c1 90 4294880899
10 90 4294880899
 7 80 4294880899
 0 90 4294880899
 8 81 4294881088
 f 80 4294881088
 0 90 4294881088
2e 90 4294881088
 8 81 4294881278
e6 80 4294881298
 0 90 4294881298
2e 90 4294881298
 0 90 4294881298
13 90 4294881298
 2 90 4294881298
15 90 4294881298
1b 90 4294881298
ff 90 4294881298
last result at 4294881496
last redo_fd_request at 4294880899
40 20 20 2e  0 13  2
status=80
fdc_busy=1
cont=c03d4258
current_req=00000000
command_status=-1

floppy0: floppy timeout called
floppy.c: no request in request_done

floppy driver state
-------------------
now=4294904653 last interrupt=4294901646 diff=3007 last called handler=c0259950
timeout_message=redo fd request
last output bytes:
 7 80 4294880899
 0 90 4294880899
 8 81 4294881088
 f 80 4294881088
 0 90 4294881088
2e 90 4294881088
 8 81 4294881278
e6 80 4294881298
 0 90 4294881298
2e 90 4294881298
 0 90 4294881298
13 90 4294881298
 2 90 4294881298
15 90 4294881298
1b 90 4294881298
ff 90 4294881298
 8 80 4294901646
 8 80 4294901646
 8 80 4294901646
 8 80 4294901646
last result at 4294901646
last redo_fd_request at 4294901645
c3  0
status=80
fdc_busy=1
floppy_work.func=c0259950
cont=c03d4258
current_req=c3af5004
command_status=-1

floppy0: floppy timeout called
end_request: I/O error, dev fd0, sector 1950
Buffer I/O error on device fd0, logical block 1950


