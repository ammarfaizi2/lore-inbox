Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJCOfT>; Wed, 3 Oct 2001 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276332AbRJCOfJ>; Wed, 3 Oct 2001 10:35:09 -0400
Received: from smtp1.us.dell.com ([143.166.224.25]:47447 "EHLO
	smtp1.us.dell.com") by vger.kernel.org with ESMTP
	id <S276330AbRJCOfE>; Wed, 3 Oct 2001 10:35:04 -0400
Date: Wed, 3 Oct 2001 09:35:33 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.10-ac4 panics when starting Oracle
Message-ID: <Pine.LNX.4.33.0110030932530.13876-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10-ac4 will panic when starting Oracle. Oracle mounts the database, 
and causes the following panic before it finishes with the opening. The 
kernel is pure 2.4.10-ac4 with the qla2x00 driver patched in. The box has 
8GB of RAM.


ksymoops 2.4.3 on i686 2.4.10-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-ac4/ (default)
     -m linux-2.4.10ac4/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01d1d00, System.map says c015c090.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 00023384
00023384
*pde = 2f631001
Oops: 0000
CPU:    3
EIP:    0010:[<00023384>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00023384   ebx: ef5fc020   ecx: 00000001   edx: ef611900
esi: ef877200   edi: fffe4000   ebp: ef8f00e0   esp: c3ff7df8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c3ff7000)
Stack: c014f4fd ef5fc020 c0004f18 c0137947 ef5fc020 00000001 00000202 eec7f618 
       00000202 c01b18f5 00000202 00000001 e83d7eac ef8f00e0 e83d7e00 c01b1a56 
       ef8f00e0 00000001 00000000 00000000 ef877000 e83d7e00 c01b1d9f e83d7e00 
Call Trace: [<c014f4fd>] [<c0137947>] [<c01b18f5>] [<c01b1a56>] [<c01b1d9f>] 
   [<c01b9acb>] [<c01aee0f>] [<c01b1074>] [<f893c2e1>] [<f8934ba2>] [<f8934493>] 
   [<c010899e>] [<c0108ba4>] [<c01053d0>] [<c01053d0>] [<c010af34>] [<c01053d0>] 
   [<c01053d0>] [<c01053fc>] [<c0105482>] [<c0118fa8>] 
Code:  Bad EIP value.

>>EIP; 00023384 Before first symbol   <=====
Trace; c014f4fc <end_kio_request+3c/60>
Trace; c0137946 <bounce_end_io_read+b6/170>
Trace; c01b18f4 <scsi_queue_next_request+44/110>
Trace; c01b1a56 <__scsi_end_request+96/150>
Trace; c01b1d9e <scsi_io_completion+1be/440>
Trace; c01b9aca <rw_intr+1ca/1e0>
Trace; c01aee0e <scsi_delete_timer+e/50>
Trace; c01b1074 <scsi_old_done+624/640>
Trace; f893c2e0 <[qla2x00]qla2100_callback+60/70>
Trace; f8934ba2 <[qla2x00]qla2100_done+132/160>
Trace; f8934492 <[qla2x00]qla2100_intr_handler+b2/130>
Trace; c010899e <handle_IRQ_event+5e/90>
Trace; c0108ba4 <do_IRQ+a4/f0>
Trace; c01053d0 <default_idle+0/40>
Trace; c01053d0 <default_idle+0/40>
Trace; c010af34 <call_do_IRQ+6/e>
Trace; c01053d0 <default_idle+0/40>
Trace; c01053d0 <default_idle+0/40>
Trace; c01053fc <default_idle+2c/40>
Trace; c0105482 <cpu_idle+52/70>
Trace; c0118fa8 <printk+128/140>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

