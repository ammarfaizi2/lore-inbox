Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTKTEQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTKTEQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:16:58 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:34153 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264245AbTKTEQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:16:51 -0500
Date: Thu, 20 Nov 2003 01:15:47 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-Id: <20031120011547.5cda3305.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20031119133814.39dbd3b7.akpm@osdl.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
	<20031119133814.39dbd3b7.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003 13:38:14 -0800, Andrew Morton wrote:
>Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar> wrote:
>>
>> With the recent 2.6.0-test9-mm4 i can't start the vmware, it reports in vmware.log (debug ON):
>> 
>> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical memory: req=49152 avail=0 over
>> head=4096 maxRespage=106496
>> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical (in MB): nbVM=3 hostMem=512 ch
>> eckMemory=1
>> 
>> With linus tree from 2.6.0-test9-mm4/broken-out/linus.patch and 2.6.0-test3-mm3 don't have problem.
>
>hm, that's funny.
>
>> Any other test from broken-out to patch it?
>
>I can't immediately think what could have caused that.  Maybe if you were
>to strace vmware startup, see what is failing?

Sorry for my fast report (was hurried) Andrew and others, i don't checked the logs :(

Appears the same message that posted Jose Luis Domingo Lopez.

Now it will prove the patches and it will comment the results to them.

Thanks people!,

chau,
 djgera


 ------------[ cut here ]------------
kernel BUG at mm/memory.c:793!
invalid operand: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c014a62b>]    Tainted: P   VLI
EFLAGS: 00013282
EIP is at get_user_pages+0x11b/0x390
eax: c13fa819   ebx: db6e0000   ecx: 00000000   edx: d9fab8c0
esi: db6e0000   edi: 40630000   ebp: da172680   esp: db6e1d24
ds: 007b   es: 007b   ss: 0068
Process vmware-vmx (pid: 377, threadinfo=db6e0000 task=da271980)
Stack: da292940 da172680 40630000 00000001 db6e0000 db6e0000 db6e0000 00000002
       00000000 00000000 db6e0000 00040630 40630000 00000000 e095aa65 da271980
       da292940 40630000 00000001 00000001 00000000 db6e1da0 00000000 00000000
Call Trace:
 [<e095aa65>] HostIFGetUserPage+0x65/0xa0 [vmmon]
 [<e095ab00>] HostIF_LockPage+0x60/0x300 [vmmon]
 [<e095cb2d>] Vmx86_LockPage+0x7d/0xf0 [vmmon]
 [<e0957fdd>] __LinuxDriver_Ioctl+0x3bd/0xb80 [vmmon]
 [<c0143497>] do_page_cache_readahead+0xf7/0x180
 [<c013bf5c>] find_get_page+0x2c/0x60
 [<c0140970>] buffered_rmqueue+0xd0/0x180
 [<c0140acf>] __alloc_pages+0xaf/0x350
 [<e0959b37>] LinuxDriverQueue+0x17/0x40 [vmmon]
 [<c0140d8f>] __get_free_pages+0x1f/0x50
 [<c014ccca>] __vma_link+0x3a/0xa0
 [<c014cd8b>] vma_link+0x5b/0x90
 [<e095886e>] LinuxDriver_IoctlV4+0x5e/0x100 [vmmon]
 [<e09594a7>] LinuxDriver_Ioctl+0x177/0x210 [vmmon]
 [<c016d6b3>] sys_ioctl+0xf3/0x280
 [<c0159aa2>] sys_close+0x62/0xa0
 [<c038883f>] syscall_call+0x7/0xb

Code: 4c 8b 4c 24 40 89 7c 24 08 89 6c 24 04 89 54 24 0c 89 0c 24 e8 17 18 00 00 85 c0 74 4e 85 c0 7e 2f 83 f8 01 74 1e 83 f8 02 74 0d <0f> 0b 19 03 1a 76 3a c0 ff 46 14 eb 98 8b 54 24 3c ff 82 dc 01


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
