Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269584AbUICFMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269584AbUICFMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 01:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269575AbUICFMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 01:12:51 -0400
Received: from mail-public.northwestel.net ([198.235.201.66]:27802 "EHLO
	yk-pvtmailprd-01.internal.messaging") by vger.kernel.org with ESMTP
	id S269601AbUICFMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 01:12:03 -0400
Date: Thu, 02 Sep 2004 22:08:56 -0700
From: Richard Whittaker <rwhittaker@northwestel.ca>
Subject: Linux 2.6.8 SegFaulting...
To: linux-kernel@vger.kernel.org
Message-id: <4137FC68.3010404@northwestel.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya..

We have a Proliant DL360 G3 running Linux 2.6.8. This machine has two 
CPUs, 3GB of memory, a pair of 146GB disks on the SmartArray 5i 
contoller, a QL2314 Fibrechannel card, and is using abou 60GB on an HP 
VA7400 via the Fibrechannel card. Under 2.6.6 and 1GB of memory this 
machine had run for 4 months without even a hiccup... As of yesterday, I 
added the space on the VA, and moved our MRTG monitoring system to the 
machine. Our MRTG currently monitors about 300 different elements, and 
is pretty I/O intensive. The website that the MRTG graphs are being 
written to is on the VA.

This machine crashed and burned in spectacular fashion last night for 
the first time in 4 months, and I was really suprised. The machine 
SegFaulted, but I couldn't get a capture of the stack spew... I had to 
power the machine off, and restart it this morning. The machine ran for 
about 4 hours, then SegFaulted again... I was able to at least see the 
Segfault info, and it was saying something about swapper. Power cycled, 
and about 5 hours later, Segfaulted again, but this time I was able to 
capture the DMESG output... I thought it might have been the software 
RAID device I'd made out of the two LUNS on the VA, but after wiping the 
LUNS out, and rebuilding them, and moving to LVM with striping the 
problem still persists.

Everything in this Kernel is statically linked, and everything is stock, 
right from ftp.kernel.org...

Now, I have a feeling that this has something to do with the I/O that 
I'm loading on the QLogic controller, but can't be absolutely certain... 
I pose the question here for perusal by the experts, and hopefully some 
suggestions about what I should look at, or do next...

DMESG output below..

Please help! :-)

Regards,
Richard.

---
Unable to handle kernel paging request at virtual address c543ad64
 printing eip:
c029812d
*pde = 00016067
*pte = 0543a000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c029812d>]    Not tainted
EFLAGS: 00010046   (2.6.8)
EIP is at __make_request+0x2e8/0x5b7
eax: c543ad50   ebx: d28c0f58   ecx: f72bfe18   edx: f72bfe18
esi: f72bfe18   edi: 00000000   ebp: f5da3b5c   esp: f5da3b18
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 1636, threadinfo=f5da2000 task=f73dea50)
Stack: f72bfe18 d28c0f58 00000003 00000000 00000000 02036970 00000000 
00000000
       00000008 00000008 00000001 d28c0f58 f5da3c30 f7ff4544 f72bfe18 
00000008
       c543ad50 f5da3bc0 c029855c f72bfe18 c543ad50 00000010 f7457a80 
00000000
Call Trace:
 [<c01055a3>] show_stack+0x80/0x96
 [<c010573a>] show_registers+0x15f/0x1ae
 [<c01058e2>] die+0xc0/0x189
 [<c011682b>] do_page_fault+0x20f/0x5b1
 [<c0105249>] error_code+0x2d/0x38
 [<c029855c>] generic_make_request+0x160/0x1de
 [<c031ff05>] __clone_and_map+0xfe/0x366
 [<c0320216>] __split_bio+0xa9/0x12a
 [<c0320335>] dm_request+0x9e/0xd1
 [<c029855c>] generic_make_request+0x160/0x1de
 [<c0298648>] submit_bio+0x6e/0x11a
 [<c01684a4>] ll_rw_block+0x67/0x8a
 [<c01b782c>] journal_commit_transaction+0x1921/0x1d41
 [<c01ba637>] kjournald+0x11e/0x3e2
 [<c01026c1>] kernel_thread_helper+0x5/0xb
Code: f6 40 14 10 75 4f 8b 96 74 01 00 00 81 7a 04 ad 4e ad de 75
 
root@wh-mrtgp1:/var/lib/amavis# 


