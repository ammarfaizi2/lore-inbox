Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268345AbTANCLX>; Mon, 13 Jan 2003 21:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268508AbTANCLX>; Mon, 13 Jan 2003 21:11:23 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:36859 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S268345AbTANCLV>; Mon, 13 Jan 2003 21:11:21 -0500
Date: Tue, 14 Jan 2003 13:20:03 +1100
From: Jason Thomas <jason@topic.com.au>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi bug hard locks machine
Message-ID: <20030114022003.GA599@topic.com.au>
References: <20030113030749.GC626@topic.com.au> <1042470172.18624.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042470172.18624.14.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more info for those interested, it seems to have started in 2.5.53
with the implementation of the mid level api.

heres a trace from 2.5.53 maybe this will make it easier to find.

Unable to handle kernel NULL pointer dereference at virtual address 00000030
 printing eip:
c0252ba3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0252ba3>]    Not tainted
EFLAGS: 00010086
EIP is at idescsi_abort+0x73/0x110
eax: 00000002   ebx: 00000086   ecx: d7cc5200   edx: 00000000
esi: d7c3e000   edi: d7c3e000   ebp: 00000007   esp: d7c3ff60
ds: 0068   es: 0068   ss: 0068
Process scsi_eh_0 (pid: 9, threadinfo=d7c3e000 task=d7d1a680)
Stack: c030dee0 00000002 d7c3e000 d7c8c980 c040e1ec d7c3e000 00000202 d7c3e000
       00000000 c024c7a2 d7cc5200 d7cc5200 d7cdf180 d7c3e000 c024c8c8 d7cc5200
       d7cdf180 d7cdf180 d7c3ffd4 c024d165 d7cc5200 d7cdf180 c0109d97 d7cc5200
Call Trace:
 [<c024c7a2>] scsi_try_to_abort_cmd+0x62/0x80
 [<c024c8c8>] scsi_eh_abort_cmd+0x38/0x70
 [<c024d165>] scsi_unjam_host+0xa5/0xf0
 [<c0109d97>] __down_failed_interruptible+0x7/0xc
 [<c024d289>] scsi_error_handler+0xd9/0x110
 [<c024d1b0>] scsi_error_handler+0x0/0x110
 [<c0108bfd>] kernel_thread_helper+0x5/0x18

Code: 39 42 30 74 67 8b 44 24 10 83 c0 10 89 04 24 e8 69 55 fc ff
 <6>note: scsi_eh_0[9] exited with preempt_count 2


On Mon, Jan 13, 2003 at 03:02:53PM +0000, Alan Cox wrote:
> Someone broke ide-scsi in 2.5. I've not had time to investigate why yet. If you 
> need ide-scsi use 2.4.
