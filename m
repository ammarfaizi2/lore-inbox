Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTJPOpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJPOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:45:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65198 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262987AbTJPOpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:45:20 -0400
Message-ID: <3F8EAEB5.5040102@austin.ibm.com>
Date: Thu, 16 Oct 2003 09:44:05 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.6.0-test7-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On reboot after heavy IO loads (tiobench) I keep getting the following 
oops. Happens right after the "turning off swap" message. Root FS is 
ext3, but the oops has happened while testing ext2 and ext3 with 
tiobench(xfs, jfs and rieser still to come).

kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
SMP
CPU:    2
EIP:    0060:[<c01756f7>]    Not tainted VLI
EFLAGS: 00010213
EIP is at __iget+0x67/0x80
eax: 00000000   ebx: f7528cb8   ecx: f767359c   edx: f7673594
esi: c6668400   edi: 0005dc97   ebp: f7c445f8   esp: f6c6fe40
ds: 007b   es: 007b   ss: 0068
Process S20reboot (pid: 20537, threadinfo=f6c6e000 task=f752d900)
Stack: f7673594 c017644b f7673594 f7c445f8 0005dc97 0005dc97 f29ee2c0 
c6668400
       f29ee2c0 c019d16b c6668400 0005dc97 f76f61dc fffffff4 f76ffa28 
f76ff9b4
       c0169cef f76ff9b4 f29ee2c0 f6c6ff38 00000000 f6c6ff38 f7fde760 
f6c6fee4
Call Trace:
 [<c017644b>] iget_locked+0x6b/0xc0
 [<c019d16b>] ext3_lookup+0x6b/0xd0
 [<c0169cef>] real_lookup+0xcf/0x100
 [<c0169fa6>] do_lookup+0xa6/0xc0
 [<c016a413>] link_path_walk+0x453/0x8b0
 [<c016ad99>] __user_walk+0x49/0x60
 [<c0165d6f>] vfs_stat+0x1f/0x60
 [<c016650b>] sys_stat64+0x1b/0x40
 [<c04103df>] syscall_call+0x7/0xb

Code: 04 a1 10 92 48 c0 89 48 04 89 42 08 c7 41 04 10 92 48 c0 89 0d 10 
92 48

Steve

