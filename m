Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbSJTQVD>; Sun, 20 Oct 2002 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJTQVD>; Sun, 20 Oct 2002 12:21:03 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:49849
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263203AbSJTQVC>; Sun, 20 Oct 2002 12:21:02 -0400
Date: Sun, 20 Oct 2002 12:11:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aha1542 bad deref in aha1542_intr_handle
Message-ID: <Pine.LNX.4.44.0210201206570.20993-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is that mailbox calculation correct?

printk(KERN_DEBUG "shost:%#x mbo=%#x mbi=%#x %#x %#x %#x\n",
        shost, mbo, mbi, scsi2int(mb[mbi].ccbptr), SCSI_BUF_PA(&ccb[0]),
        sizeof(struct ccb));

shost:0xc0683000 mbo=0x5d1733a mbi=0x8 0x680000 0x6831e8 0x2c

Unable to handle kernel paging request at virtual address d7ade1a4
 printing eip:
c02c37e5
*pde = 00000000
Oops: 0000
 
CPU:    0
EIP:    0060:[<c02c37e5>]    Not tainted
EFLAGS: 00010002
EIP is at aha1542_intr_handle+0x195/0x380
eax: 00000000   ebx: 00000004   ecx: 00000008   edx: c0681000
esi: c06811a8   edi: 05d17407   ebp: 00000046   esp: c05efef4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c05ee000 task=c0587ec0)
Stack: 00000000 c06811e8 00000000 00000000 00000004 c05ea380 c05eff2c c0681000 
       c05ee000 c068101c 00000286 c02c35f8 c0681000 00000000 c05eff9c c17affb4 
       c17affb4 c17affb4 00000001 c05eff9c 0000000a c010b98d 0000000a 00000000 
Call Trace:
 [<c02c35f8>] do_aha1542_intr_handle+0x68/0xc0
 [<c010b98d>] handle_IRQ_event+0x2d/0x50
 [<c010bcf4>] do_IRQ+0x114/0x210
 [<c0116fa6>] smp_apic_timer_interrupt+0xe6/0x150
 [<c0107060>] default_idle+0x0/0x40
 [<c010a658>] common_interrupt+0x18/0x20
 [<c0107060>] default_idle+0x0/0x40
 [<c010708b>] default_idle+0x2b/0x40
 [<c010711a>] cpu_idle+0x3a/0x50
 [<c0105000>] stext+0x0/0x20

Code: 8b 9c ba 88 01 00 00 85 db 0f 84 c2 00 00 00 8b 8b 10 01 00 

(gdb) list *aha1542_intr_handle+0x195
0xc02c37e5 is in aha1542_intr_handle (drivers/scsi/aha1542.c:535).
530
531     #ifdef DEBUG
532                     printk(KERN_DEBUG "...done %d %d\n", mbo, mbi);
533     #endif
534
535                     SCtmp = HOSTDATA(shost)->SCint[mbo];
536
537                     if (!SCtmp || !SCtmp->scsi_done) {
538                             printk(KERN_WARNING "aha1542_intr_handle: Unexpected interrupt\n");
539                             printk(KERN_WARNING "tarstat=%x, hastat=%x idlun=%x ccb#=%d \n", ccb[mbo].tarstat,

-- 
function.linuxpower.ca

