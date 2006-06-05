Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750709AbWFEQbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWFEQbK (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWFEQbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:31:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:4425 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWFEQbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:31:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=mIuCfMNU/exFCYlqNVIv0spZWZrizc2SQajD3IMT8j9GoxLV0pH4m4scVgmP3Pl3I
	2gc/ai44jLtGaXWoUpwOg==
Message-ID: <44845C27.3000006@google.com>
Date: Mon, 05 Jun 2006 09:30:31 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andy Whitcroft <apw@shadowen.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

panic on NUMA-Q during LTP. Was fine in -mm2.

BUG: unable to handle kernel paging request at virtual address 22222232
  printing eip:
c012cf84
*pde = 25b5a001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /devices/pci0000:00/0000:00:0a.0/resource
Modules linked in:
CPU:    12
EIP:    0060:[<c012cf84>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc5-mm3-autokern1 #1)
EIP is at check_deadlock+0x19/0xe1
eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0
ds: 007b   es: 007b   ss: 0068
Process mkdir09 (pid: 18319, threadinfo=e47ea000 task=e5f91ab0)
Stack: e4453030 22222222 00000000 e459231c c012d015 22222222 00000001 
e4008000
        e459231c e47ea000 e47ebf1c e5f91ab0 c012d1ce e459231c 00000000 
e47ea000
        e47ebf1c e459231c 00000246 c02f1d74 e459231c e47ebf1c e47ea000 
e47ebf1c
Call Trace:
  [<c012d015>] check_deadlock+0xaa/0xe1
  [<c012d1ce>] debug_mutex_add_waiter+0x4a/0x5c
  [<c02f1d74>] __mutex_lock_slowpath+0x9e/0x1cb
  [<c01648a9>] do_rmdir+0x67/0xc2
  [<c02001da>] __put_user_4+0x12/0x18
  [<c016490f>] sys_rmdir+0xb/0xe
  [<c02f2f1f>] syscall_call+0x7/0xb
Code: 0c 68 60 07 31 c0 e8 22 c0 fe ff 58 fa 5b 5e 5f 5d c3 55 83 3d cc 
11 36 c0 00 57 56 53 8b 6c 24 14 8b 7c 24 18 0f 84 c1 00 00 00 <8b> 55 
10 31 c0 85 d2 0f 84 b6 00 00 00 8b 1a 31 f6 8b 83 c4 04
EIP: [<c012cf84>] check_deadlock+0x19/0xe1 SS:ESP 0068:e47ebec0
