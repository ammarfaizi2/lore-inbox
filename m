Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135902AbRD3VHH>; Mon, 30 Apr 2001 17:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135906AbRD3VGr>; Mon, 30 Apr 2001 17:06:47 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:3732 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S135902AbRD3VGj>;
	Mon, 30 Apr 2001 17:06:39 -0400
Date: Mon, 30 Apr 2001 23:06:31 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: reproducable hangup with 2.4.3-ac14, when swap is on a fs
Message-ID: <Pine.A41.4.31.0104302301160.166352-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

if the kernel writes swaps out something to a swapfile, which is on
a filesystem the kernel hangs up. (the Oops is below)

I tried it with kernel 2.4.3-ac14 and 2.4.3-ac10, and it works perfectly
with 2.4.3-ac10.
the filesystem type does not matter, at least it hangs with ext2, and
reiserfs. the swapfile is correct.


I didn't type in the call trace, but if you need it, just let me know.
(there are lot's of adresses, so the first few lines scrolled out.)

Code: 03 4a 0c8b 1d 0c da 1e c0 01 c3 8b 11 f6 c2 01 7 4e 81 e2
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


than I hit ALT-SysRq-s

<6> SysRq: Emergency Sync
Syncing device 03:41 ... OK
Syncing device 03:42 ... OK
Syncing device 03:45 ... OK
Syncing device 03:46 ... kernel BUG at sched.c:541!
Invalid operand: 0000
CPU: 0
EIP: 0010:[<c010dc49>]
EFLAGS: 00010282
eax: 0000001b	ebx: c1ab1e78	ecx: c01eee9c	edx: 000091d0
esi: c0525a20	edi: c1ab0000	ebp: c1ab1e64	esp: c1ab1e38
ds: 0018  es: 0018  ss: 0018
process (pid:0, stackpage=c1ab1000)
Stack: c01c1096 0000021d c1ab1e78 c0525a20 c1ab0000 c0113c14 c025e9ac c1ab1e78
       c0525a20 c025ea10 c025ea10 00000000 c012b4ba c1b69620 00000346 00000001
       00000000 c1ab0000 c0525a6c c0525a6c c012b638 c0525a20 00000346 00000000
Call trace: [<c0113c14>] [<c012b4ba>] [<c012b638>] [<c012b75c>] [<c016dc9a>]
[<c016dcf8>] [<c010fd4e>] [<c011282b>] [<c0106fe9>] [<c010d5b8>] [<c010d683>]
[<c010d2c4>] [<cf042b68>] [<c0106ba4>] [<c010d2c4>] [<cf042b68>]

Code: 0f 0b 83 c4 08 89 f6 bf 00 e0 ff ff 21 e7 8b 47 34 89 45 f8
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

from System.map:
c0113c14 __run_task_queue
c012b4ba __wait_on_buffer
c012b638 sync_buffers
c012b75c fsync_dev
c016dc9a go_sync
c016dcf8 do_emergency_sync
c010fd4e panic
c011282b do_exit
c0106fe9 die
c010d5b8 do_page_fault
c010d683 do_page_fault
c010d2c4 do_page_fault
cf042b68 ???
c0106ba4 error_code
c010d2c4 do_page_fault
cf042b68 ???

than I hit ALT-SysRq-s again several times, and all the filesystems got
synced (in theory. really it messed up hdb6. the swapfile was on hdb2)


after this I tried it again.
it did the same, but after the Oops I saw this:

Printing EIP:
0000d67c

pgd entry c1731000: 0000000000000000
pmd entry c1731000: 0000000000000000
... pmd not present!

<here comes the Call trace and the other, but I didn't write it down...
if you need it, tell me)

Code: Bad EIP value



that's all I wanted to tell you :)
and sorry for the incomplete bugreport, but I saw lots of changes in
linux/fs/* so I think the bugfix is trivial for you :)
If you need anything, just let me know.

Bye,
Szabi


