Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWHLTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWHLTjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWHLTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 15:39:45 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:34486 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S932594AbWHLTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 15:39:44 -0400
Message-ID: <44DE2EA6.4060809@austin.rr.com>
Date: Sat, 12 Aug 2006 14:40:22 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in close when exiting fsx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ctl-c exiting fsx after a few hours with 2.6.18-rc4 got the following 
oops - anyone recognize it?
Although I didn't see cifs symbols on the call stack it is running on a 
cifs mount, but it is not
one I have seen before.

BUG: unable to handle kernel NULL pointer dereference at virtual address 
0000000 0
 printing eip:
c133064f
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: cifs nfsd exportfs lockd nfs_acl ipv6 sunrpc 
snd_pcm_oss snd_ mixer_oss snd_seq snd_seq_device af_packet edd ibm_acpi 
snd_intel8x0 snd_ac97_co dec snd_ac97_bus snd_pcm snd_timer snd 
soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c133064f>]    Not tainted VLI
EFLAGS: 00210002   (2.6.18-rc4-default #1)
EIP is at __down+0x56/0xc5
eax: f7708b6c   ebx: f7708b64   ecx: 00000000   edx: f5f77f04
esi: f5f5e030   edi: 00200246   ebp: 00000000   esp: f5f77ed8
ds: 007b   es: 007b   ss: 0068
Process fsx-linux (pid: 4038, ti=f5f76000 task=f5f5e030 task.ti=f5f76000)
Stack: 00000000 00000000 00000000 00000000 00000000 f76e24a0 00000000 
c1038908
       00000001 f5f5e030 c1013678 f7708b6c 00000000 f7708b40 f609f600 
f7708b64
       c132ed37 dff49a40 f5f76000 fa2da685 f611f8c0 f5a5406c 03240e72 
00000008
Call Trace:
 [<c1038908>] mempool_free+0x43/0x46
 [<c1013678>] default_wake_function+0x0/0xc
 [<c132ed37>] __down_failed+0x7/0xc
 [<fa2da685>] .text.lock.file+0x87/0x9a [cifs]
 [<c104e807>] __fput+0xab/0x148
 [<c104c453>] filp_close+0x4e/0x54
 [<c101773a>] put_files_struct+0x64/0xa6
 [<c1018581>] do_exit+0x1c7/0x675
 [<c10052b0>] do_syscall_trace+0x12b/0x172
 [<c1018a8b>] sys_exit_group+0x0/0xd
 [<c1002abf>] syscall_call+0x7/0xb
Code: 89 74 24 24 c7 44 24 28 78 36 01 c1 c7 06 02 00 00 00 9c 5f fa 83 
4c 24 20  01 8d 43 08 8b 48 04 8d 54 24 2c 89 50 04 89 44 24 2c <89> 11 
ff 43 04 89 4c 24  30 8b 43 04 48 01 03 0f 98 c0 84 c0 75
EIP: [<c133064f>] __down+0x56/0xc5 SS:ESP 0068:f5f77ed8
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1
 [<c1026618>] down_read+0x12/0x1f
 [<c101fcc8>] blocking_notifier_call_chain+0xe/0x29
 [<c10183d6>] do_exit+0x1c/0x675
 [<c101695e>] printk+0x14/0x18
 [<c1003dcd>] die+0x206/0x20e
 [<c13315bf>] do_page_fault+0x3ea/0x4b8
 [<c13311d5>] do_page_fault+0x0/0x4b8
 [<c10035d1>] error_code+0x39/0x40
 [<c133064f>] __down+0x56/0xc5
 [<c1038908>] mempool_free+0x43/0x46
 [<c1013678>] default_wake_function+0x0/0xc
 [<c132ed37>] __down_failed+0x7/0xc
 [<fa2da685>] .text.lock.file+0x87/0x9a [cifs]
 [<c104e807>] __fput+0xab/0x148
 [<c104c453>] filp_close+0x4e/0x54
 [<c101773a>] put_files_struct+0x64/0xa6
 [<c1018581>] do_exit+0x1c7/0x675
 [<c10052b0>] do_syscall_trace+0x12b/0x172
 [<c1018a8b>] sys_exit_group+0x0/0xd
 [<c1002abf>] syscall_call+0x7/0xb
Fixing recursive fault but reboot is needed!

