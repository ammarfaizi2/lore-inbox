Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263400AbUKZWkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbUKZWkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbUKZWg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:36:58 -0500
Received: from mail.charite.de ([160.45.207.131]:30086 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262420AbUKZWdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:33:53 -0500
Date: Fri, 26 Nov 2004 23:33:50 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: EIP in fib_release_info (2.6.9-ac4)
Message-ID: <20041126223350.GH30987@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened after I added a reject route and tried to remove it
later on:
% route add 172.21.11.150 reject
...
% route del 172.21.11.150 reject
Segmentation fault

After a while, this happened (and ifconfig etc. did all hang):

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0302f1c
*pde = 00000000
Oops: 0002 [#1]
SMP 
Modules linked in: ipt_limit psmouse ipt_state iptable_filter ip_tables ip_conntrack_ftp ip_conntrack tg3 rtc
CPU:    0
EIP:    0060:[<c0302f1c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-ac4) 
EIP is at fib_release_info+0x73/0xb9
eax: 00000000   ebx: f7d80a80   ecx: f7d80ae0   edx: 00000000
esi: f7d80ae4   edi: f75e51c8   ebp: 00000000   esp: d1e60e50
ds: 007b   es: 007b   ss: 0068
Process route (pid: 7726, threadinfo=d1e60000 task=f5f476b0)
Stack: f75e4230 00000001 c0305015 00000020 000000fe d1e60ea0 00000000 f7d8e5e0 
       00000020 f75e51c0 d1e60f20 c2176180 960b15ac c2176180 fffffffd d1e60f20 
       d1e60ea0 c0302737 d1e60ea0 00000000 0000001c 00000019 00000000 00000000 
Call Trace:
 [<c0305015>] fn_hash_delete+0x1c2/0x202
 [<c0302737>] ip_rt_ioctl+0x163/0x165
 [<c02bba87>] sock_map_fd+0x117/0x164
 [<c02fdeca>] inet_ioctl+0xb8/0xe7
 [<c02bc495>] sock_ioctl+0x1d8/0x297
 [<c014fba7>] fget+0x49/0x5e
 [<c015fbc3>] sys_ioctl+0x170/0x28d
 [<c0103d2b>] syscall_call+0x7/0xb
Code: 8d 4b 08 8b 51 04 85 c0 89 02 74 03 89 50 04 c7 43 08 00 01 10 00 c7 41 04 00 02 20 00 8d 4b 60 8d 73 64 8b 41 04 8b 56 04 85 c0 <89> 02 74 03 89 50 04 c7 41 04 00 01 10 00 c7 46 04 00 02 20 00 

