Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTBJQeH>; Mon, 10 Feb 2003 11:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTBJQeG>; Mon, 10 Feb 2003 11:34:06 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:28855 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264954AbTBJQeF>; Mon, 10 Feb 2003 11:34:05 -0500
Message-ID: <3E47D6C6.90901@blue-labs.org>
Date: Mon, 10 Feb 2003 11:43:50 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: remove_wait_queue, scheduling while atomic OOPS, 2.5.59
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine doesn't seem to like 2.5.59...

Unable to handle kernel paging request at virtual address a6bb009c
 printing eip:
c011f1b7
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c011f1b7>]    Not tainted
EFLAGS: 00013002
EIP is at remove_wait_queue+0x17/0x30
eax: e6632000   ebx: 00003292   ecx: a6bb009c   edx: e6bb809c
esi: d0298008   edi: d0298000   ebp: 00100000   esp: e6633f04
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1372, threadinfo=e6632000 task=e6739340)
Stack: d0298008 c0164f84 00000000 dc89abc4 00000015 c016529b e6633f3c 
00000000
       e6632000 00000304 e6632000 0000a40f 00000001 00000000 c0164fb0 
d0298000
       00000000 fffffff4 00000020 00000000 e7bf384c bffff398 c01656b6 
00000015
Call Trace:
 [<c0164f84>] poll_freewait+0x24/0x50
 [<c016529b>] do_select+0x13b/0x240
 [<c0164fb0>] __pollwait+0x0/0xd0
 [<c01656b6>] sys_select+0x2e6/0x4e0
 [<c010955f>] syscall_call+0x7/0xb

Code: 89 11 53 9d ff 48 10 8b 40 08 83 e0 08 75 02 5b c3 5b e9 62
 <6>note: X[1372] exited with preempt_count 1
mtrr: MTRR 3 not used
mtrr: MTRR 3 not used
bad: scheduling while atomic!
Call Trace:
 [<c011db21>] schedule+0x2f1/0x300
 [<c011de0f>] wait_for_completion+0x8f/0xe0
 [<c011db90>] default_wake_function+0x0/0x40
 [<c011db90>] default_wake_function+0x0/0x40
 [<c0357fb9>] hcd_unlink_urb+0x1b9/0x2a0
 [<c0373d50>] hid_irq_in+0x0/0xa0
 [<c0358842>] usb_unlink_urb+0x32/0x40
 [<c03841ec>] input_close_device+0x2c/0x30
 [<c0385902>] mousedev_release+0x62/0x120
 [<c0154090>] __fput+0xe0/0xf0
 [<c0152364>] filp_close+0x74/0xa0
 [<c012285c>] put_files_struct+0x5c/0xd0
 [<c0122f50>] do_exit+0x130/0x2d0
 [<c0109c75>] die+0x85/0x90
 [<c011c3da>] do_page_fault+0x14a/0x45c
 [<c0456aa8>] __kfree_skb+0xa8/0x140
 [<c04c68cf>] unix_stream_recvmsg+0xff/0x360
 [<c013bee1>] buffered_rmqueue+0xb1/0x150
 [<c0107a00>] __switch_to+0x100/0x150
 [<c011d9bf>] schedule+0x18f/0x300
 [<c011c290>] do_page_fault+0x0/0x45c
 [<c0109709>] error_code+0x2d/0x38
 [<c011f1b7>] remove_wait_queue+0x17/0x30
 [<c0164f84>] poll_freewait+0x24/0x50
 [<c016529b>] do_select+0x13b/0x240
 [<c0164fb0>] __pollwait+0x0/0xd0
 [<c01656b6>] sys_select+0x2e6/0x4e0
 [<c010955f>] syscall_call+0x7/0xb

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


