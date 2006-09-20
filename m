Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWITNHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWITNHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWITNHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:07:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44739 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751228AbWITNHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:07:05 -0400
Message-ID: <45113CF3.8010308@fr.ibm.com>
Date: Wed, 20 Sep 2006 15:06:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: rohitseth@google.com, devel@openvz.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Devel] [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
In-Reply-To: <1158718568.29000.44.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> 
> This is based on lot of discussions over last month or so.  I hope this
> patch set is something that we can agree and more support can be added
> on top of this.  Please provide feedback and add other extensions that
> are useful in the TODO list.

thanks rohit for this patchset. 

I applied it on rc7-mm1, compiles smoothly and boots. Here's a edge 
issue, I got this oops while rmdir a container with running tasks. 

C.
 

BUG: unable to handle kernel paging request at virtual address 00100100
 printing eip:
c01470ea
*pde = 00000000
Oops: 0000 [#1]
last sysfs file: /block/hda/range
Modules linked in:
CPU:    0
EIP:    0060:[<c01470ea>]    Not tainted VLI
EFLAGS: 00000282   (2.6.18-rc7-mm1-lxc2 #8)
EIP is at container_remove_tasks+0x21/0x3c
eax: 00000007   ebx: 000ffbb0   ecx: c13e4330   edx: 00000196
esi: c13e42f4   edi: 00000000   ebp: c6e39eb8   esp: c6e39eb0
ds: 007b   es: 007b   ss: 0068
Process rmdir (pid: 9081, ti=c6e38000 task=c7223710 task.ti=c6e38000)
Stack: c13e42f4 00000000 c6e39ec8 c0147206 c13e42c0 c0307e44 c6e39ed4 c012e060
       c13e42c0 c6e39eec c017c0ac 00000000 c13e42d8 c017c0cb c13e42c0 c6e39ef4
       c017c0d6 c6e39f04 c01f441e c0307de0 c0307de0 c6e39f0c c017c068 c6e39f30
Call Trace:
 [<c0147206>] free_container+0x18/0x95
 [<c012e060>] simple_containerfs_release+0x15/0x21
 [<c017c0ac>] config_item_cleanup+0x42/0x61
 [<c017c0d6>] config_item_release+0xb/0xd
 [<c01f441e>] kref_put+0x66/0x74
 [<c017c068>] config_item_put+0x14/0x16
 [<c017b760>] configfs_rmdir+0x16d/0x1b5
 [<c014ff07>] vfs_rmdir+0x54/0x96
 [<c015180c>] do_rmdir+0x8f/0xcc
 [<c0151888>] sys_rmdir+0x10/0x12
 [<c01027dc>] syscall_call+0x7/0xb
