Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUECVZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUECVZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUECVZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:25:40 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:17087 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S264022AbUECVXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:23:52 -0400
Message-ID: <4096B810.5060907@keyaccess.nl>
Date: Mon, 03 May 2004 23:22:24 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity
 removal)
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk> <4095BAA3.3050000@keyaccess.nl> <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk> <40968A9F.6070608@keyaccess.nl> <20040503194558.GF17014@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040503194558.GF17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------090700050701080305090600"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700050701080305090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:

>>However, any "cp" from cd-rom oopses the box.
> 
> oopses in driver, oopses by triggering BUG() or oopses in fs/*?  The last
> two would be more interesting - isofs _MUST_ be able to survive any IO
> errors, simply because CDs get scratched, etc. and that shouldn't crash
> the box.

Doesn't actually look all driver. The CD is good; works fine in this 
same drive with its own 2.0 kernel (and on other drives). Please note, 
this is a 386. Memory is good. dmesg and .config attached.

Very long crash, but in case it's helpful. Happens when copying anything 
from the sbpcd CD-ROM. In between the "do_exit, do_divide_error, 
do_page_fault, do_page_fault" oopses it seems to be attempting to give 
me back a prompt (it's not succeeding).

blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
blk: request botched
Unable to handle kernel paging request at virtual address 4a02e274
  printing eip:
c010fbec
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c010fbec>]    Not tainted
EFLAGS: 00010007   (2.6.5)
EIP is at schedule+0x1fd/0x5a1
eax: 1e40ba47   ebx: c02ee284   ecx: 6f89b7d5   edx: 55ce512b
esi: c06656b0   edi: 4a02e274   ebp: c07a1e84   esp: c07a1e50
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: 00000041 55ce512b 6f89b7d5 c06656b0 c06656d0 005b8d80 6cec9540 
000f422f
        c039e070 c039e230 c0527890 7fffffff 00000080 00000000 c01198e3 
c0148c60
        00000246 c06b4e10 00000000 00000040 c0253a1d c02ad380 00000000 
c0527890
Call Trace:
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0f 8b 4d dc 8b 51 04 8b 01 89 50 04 89 02 c7 41 04 00 02
  <6>note: syslogd[51] exited with preempt_count 2
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1d44   esp: c07a1d10
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c039e070 00000008 0000007b c009007b ffffff00 0459e440 70eaec00 
000f422f
        c039e070 c039e230 c084faa0 c02e4040 c039e070 0000000b c0114bc0 
c07a0000
        c0520000 c07a1e1c c0271701 c010755d 0000000b 00000000 4a02e274 
c010e23a
Call Trace:
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <6>note: syslogd[51] exited with preempt_count 5
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#3]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1c04   esp: c07a1bd0
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c039e070 00000008 c011007b c07a007b ffffff00 07ed6b40 747e7300 
000f422f
        c039e070 c039e230 00000000 00000000 c039e070 0000000b c0114bc0 
c07a0000
        c0840000 c07a1cdc c0271701 c010755d 0000000b 00000000 00000000 
c010e23a
Call Trace:
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <6>note: syslogd[51] exited with preempt_count 8
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#4]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1ac4   esp: c07a1a90
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c02eebd1 0000000b c0113350 c07a0000 c00975c0 0b80f240 7811fa00 
000f422f
        c039e070 c039e230 00000000 00000000 c039e070 0000000b c0114bc0 
c07a0000
        00000000 c07a1b9c c0271701 c010755d 0000000b 00000000 00000000 
c010e23a
Call Trace:
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <6>note: syslogd[51] exited with preempt_count 11
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#5]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1984   esp: c07a1950
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c02eebd2 0000000b c0113350 c07a0000 c00975c0 0f23bb80 7bb4c340 
000f422f
        c039e070 c039e230 00000000 00000000 c039e070 0000000b c0114bc0 
c07a0000
        00000000 c07a1a5c c0271701 c010755d 0000000b 00000000 00000000 
c010e23a
Call Trace:
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <6>note: syslogd[51] exited with preempt_count 14
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#6]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1844   esp: c07a1810
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c02eebd2 0000000b c0113350 c07a0000 c00975c0 12c684c0 7f578c80 
000f422f
        c039e070 c039e230 00000000 00000000 c039e070 0000000b c0114bc0 
c07a0000
        00000000 c07a191c c0271701 c010755d 0000000b 00000000 00000000 
c010e23a
Call Trace:
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <6>note: syslogd[51] exited with preempt_count 17
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c010fb19
*pde = 00000000
Oops: 0000 [#7]
PREEMPT
CPU:    0
EIP:    0060:[<c010fb19>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at schedule+0x12a/0x5a1
eax: 00000008   ebx: 00000000   ecx: c039e070   edx: c039e070
esi: c039e230   edi: c039e070   ebp: c07a1704   esp: c07a16d0
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c02eebd2 0000000b c0113350 c07a0000 c00975c0 16694e00 82fa55c0 
000f422f
        c039e070 c039e230 00000000 00000000 c039e070 0000000b c0114bc0 
c07a0000
        00000000 c07a17dc c0271701 c010755d 0000000b 00000000 00000000 
c010e23a
Call Trace:
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code: ff 0b 8b 4d ec 8b 75 ec 83 c1 20 8b 51 04 8b 46 20 89 50 04
  <1>Unable to handle kernel paging request at virtual address 0c347954
  printing eip:
0c347954
*pde = 00000000
Oops: 0000 [#8]
PREEMPT
CPU:    0
EIP:    0060:[<0c347954>]    Not tainted
EFLAGS: 00010006   (2.6.5)
EIP is at 0xc347954
eax: c066400c   ebx: c066400c   ecx: 00000000   edx: 00000001
esi: 00000001   edi: c0525078   ebp: c07a1444   esp: c07a1428
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 51, threadinfo=c07a0000 task=c039e070)
Stack: c0110019 a0e765d8 c4571968 00000001 c07a0000 00000206 c0524304 
c07a1458
        c0110056 00000000 c0524050 c0542690 c0524050 c02162a9 c0524218 
c023678f
        00000101 dac2a4b4 c023595b dac2a4b4 00000000 ffffffff c08148c4 
c0524218
Call Trace:
  [<c0110019>] __wake_up_common+0x2f/0x53
  [<c0110056>] __wake_up+0x19/0x39
  [<c02162a9>] sock_def_readable+0x62/0x64
  [<c023678f>] tcp_data_queue+0x2df/0x9bd
  [<c023595b>] tcp_ack+0x294/0x345
  [<c0237a17>] tcp_rcv_established+0x1df/0x673
  [<c023f555>] tcp_v4_do_rcv+0xdf/0xe1
  [<c023fa9a>] tcp_v4_rcv+0x543/0x78c
  [<c0227efc>] ip_local_deliver+0x8b/0x123
  [<c0228261>] ip_rcv+0x2cd/0x3cc
  [<c021a70b>] netif_receive_skb+0x137/0x165
  [<c021a7a9>] process_backlog+0x70/0xea
  [<c021a880>] net_rx_action+0x5d/0xd2
  [<c0116058>] do_softirq+0x8c/0x8e
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c0107507>] die+0x82/0xd8
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c011b218>] __wake_up_parent+0x30/0x66
  [<c011b331>] do_notify_parent+0xe3/0x1b6
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c0113350>] printk+0x104/0x160
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c011007b>] __wake_up_locked+0x5/0x11
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c010ef91>] recalc_task_prio+0x77/0x142
  [<c010f0f9>] try_to_wake_up+0x9d/0x14a
  [<c0110056>] __wake_up+0x19/0x39
  [<c010f531>] scheduler_tick+0x1b/0x4d4
  [<c0119636>] run_timer_softirq+0xfd/0x17f
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c010fb19>] schedule+0x12a/0x5a1
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0114bc0>] do_exit+0x26e/0x2ea
  [<c010755d>] do_divide_error+0x0/0xaa
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c010e40d>] do_page_fault+0x1d3/0x4a9
  [<c02e4040>] init_sunrpc+0x1b/0x40
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106fbc>] common_interrupt+0x18/0x20
  [<c02e007b>] check_version+0x766/0xa82
  [<c01238f6>] unlock_page+0x9/0x35
  [<c010e23a>] do_page_fault+0x0/0x4a9
  [<c0106ff9>] error_code+0x2d/0x38
  [<c012007b>] inter_module_unregister+0x47/0xd1
  [<c010fbec>] schedule+0x1fd/0x5a1
  [<c01198e3>] schedule_timeout+0x9e/0xa0
  [<c0148c60>] __pollwait+0x2d/0x94
  [<c0253a1d>] unix_poll+0x12/0x76
  [<c0148ef0>] do_select+0x182/0x2a1
  [<c0148c33>] __pollwait+0x0/0x94
  [<c0149296>] sys_select+0x274/0x47b
  [<c010bfe4>] old_select+0x67/0x77
  [<c0108498>] do_IRQ+0xe9/0x111
  [<c0106e4f>] syscall_call+0x7/0xb

Code:  Bad EIP value.
  <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

Rene.

--------------090700050701080305090600
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.5 (rene@7ixe4) (gcc version 3.2.3) #4 Mon May 3 22:33:54 CEST 2004
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000000850000 (usable)
8MB LOWMEM available.
On node 0 totalpages: 2128
  DMA zone: 2128 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=serial ro root=301 reboot=warm console=ttyS1
Initializing CPU#0
PID hash table entries: 64 (order 6: 512 bytes)
Using pit for high-res timesource
Console: colour VGA+ 80x25
Memory: 5928k/8512k available (1427k kernel code, 2172k reserved, 431k data, 96k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... No.
Calibrating delay loop... 8.19 BogoMIPS
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 00000000 00000000 00000000 00000000
CPU:     After all inits, caps: 00000000 00000000 00000000 00000000
CPU: 386
Checking 'hlt' instruction... OK.
Checking for popad bug... Buggy.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is an 8272A
loop: loaded (max 8 devices)
eth0: 3c5x9 found at 0x300, 10baseT port, address  00 20 af c1 37 1e, IRQ 10.
3c509.c:1.19b 08Nov2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
hda: 203MB, CHS=685/16/38
hdb: 162MB, CHS=903/8/46
 hda: hda1
 hdb: hdb1 hdb2
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker
Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
sb16: no OPL device at 0x220-0x222
ALSA device list:
  #0: Sound Blaster 16 at 0x220, irq 5, dma 1&5
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 1024)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
version 0 swap is no longer supported. Use mkswap -v1 /dev/hdb1
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
spurious 8259A interrupt: IRQ7.
eth0: Setting 3c5x9/3c5x9B half-duplex mode if_port: 0, sw_info: 1321
eth0: Setting Rx mode to 1 addresses.

--------------090700050701080305090600
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
# CONFIG_STANDALONE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
CONFIG_M386=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_REGPARM=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_PCI is not set
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
# CONFIG_BLK_DEV_IDE is not set
CONFIG_BLK_DEV_HD_ONLY=y
CONFIG_BLK_DEV_HD=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
# CONFIG_AZTCD is not set
# CONFIG_GSCD is not set
CONFIG_SBPCD=y
# CONFIG_MCD is not set
# CONFIG_MCDX is not set
# CONFIG_OPTCD is not set
# CONFIG_CM206 is not set
# CONFIG_SJCD is not set
# CONFIG_ISP16_CDI is not set
# CONFIG_CDU31A is not set
# CONFIG_CDU535 is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=y
# CONFIG_3C515 is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=0
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
CONFIG_SND_SB16=y
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SB16_CSP is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--------------090700050701080305090600--
