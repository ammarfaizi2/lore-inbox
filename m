Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319299AbSHGTqm>; Wed, 7 Aug 2002 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319300AbSHGTql>; Wed, 7 Aug 2002 15:46:41 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:33511 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S319299AbSHGTqh>; Wed, 7 Aug 2002 15:46:37 -0400
Date: Wed, 7 Aug 2002 22:06:02 +0200 (CEST)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <gadio@netvision.net.il>
cc: <linux-kernel@vger.kernel.org>
Subject: [OOPS] ide-scsi
Message-ID: <Pine.LNX.4.33.0208072204180.19142-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a special cdimage which cdrdao can't handle very well.
Cdrdao starts the burning, after a minute the cdrecorder stops
and cdrdao can only be killed.

After this, when something touches the cdrecorder, come the
'scsi: aborting command due to timeout' messages. After this
sysrq-s or sysrq-u usualy triggers the oops, but sometimes
it's only triggered by the shutdown process.

Tried with kernel 2.4.19-rc3-ac5 and 2.4.19-ac4: same results
Later I will check older and not -ac kernels.

Here is the output of ksymoops:

Unable to handle kernel paging request at virtual address caea4bb9
ca8bf57e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<ca8bf57e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000051   ebx: c7458000   ecx: c026c598   edx: 00000177
esi: c8c77300   edi: caea4ba1   ebp: c026c710   esp: c8c17f48
ds: 0018   es: 0018   ss: 0018
Process client (pid: 253, stackpage=c8c17000)
Stack: c026c710 c9fe0260 00000286 c026c598 00000002 c026c751 c01829be c026c710
       c120c860 04000001 0000000f c8c17fc4 ca8bf50c c010988c 0000000f c9fe0260
       c8c17fc4 000001e0 c0249ae0 0000000f c8c17fbc c01099f2 0000000f c8c17fc4
Call Trace:    [<c01829be>] [<ca8bf50c>] [<c010988c>] [<c01099f2>] [<c010bb08>]
Code: ff 47 18 6a 01 55 e8 3b fd ff ff 31 c0 83 c4 08 e9 b6 01 00


>>EIP; ca8bf57e <[ide-scsi]idescsi_pc_intr+72/244>   <=====

>>ebx; c7458000 <_end+71e312c/a5c812c>
>>ecx; c026c598 <ide_hwifs+338/2030>
>>esi; c8c77300 <_end+8a0242c/a5c812c>
>>edi; caea4ba1 <END_OF_CODE+5bed7e/????>
>>ebp; c026c710 <ide_hwifs+4b0/2030>
>>esp; c8c17f48 <_end+89a3074/a5c812c>

Trace; c01829be <ide_intr+be/118>
Trace; ca8bf50c <[ide-scsi]idescsi_pc_intr+0/244>
Trace; c010988c <handle_IRQ_event+34/60>
Trace; c01099f2 <do_IRQ+6a/a8>
Trace; c010bb08 <call_do_IRQ+5/d>

Code;  ca8bf57e <[ide-scsi]idescsi_pc_intr+72/244>
00000000 <_EIP>:
Code;  ca8bf57e <[ide-scsi]idescsi_pc_intr+72/244>   <=====
   0:   ff 47 18                  incl   0x18(%edi)   <=====
Code;  ca8bf581 <[ide-scsi]idescsi_pc_intr+75/244>
   3:   6a 01                     push   $0x1
Code;  ca8bf583 <[ide-scsi]idescsi_pc_intr+77/244>
   5:   55                        push   %ebp
Code;  ca8bf584 <[ide-scsi]idescsi_pc_intr+78/244>
   6:   e8 3b fd ff ff            call   fffffd46 <_EIP+0xfffffd46> ca8bf2c4 <[ide-scsi]idescsi_end_request+0/248>
Code;  ca8bf589 <[ide-scsi]idescsi_pc_intr+7d/244>
   b:   31 c0                     xor    %eax,%eax
Code;  ca8bf58b <[ide-scsi]idescsi_pc_intr+7f/244>
   d:   83 c4 08                  add    $0x8,%esp
Code;  ca8bf58e <[ide-scsi]idescsi_pc_intr+82/244>
  10:   e9 b6 01 00 00            jmp    1cb <_EIP+0x1cb> ca8bf749 <[ide-scsi]idescsi_pc_intr+23d/244>

 <0>Kernel panic: Aiee, killing interrupt handler!

Bye,
Szabi


