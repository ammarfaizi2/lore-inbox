Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTLBQwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLBQwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:52:14 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:55456 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261774AbTLBQwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:52:06 -0500
Date: Tue, 02 Dec 2003 08:51:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1627] New: system crashes after 3 hours test
Message-ID: <49580000.1070383916@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1627

           Summary: system crashes after 3 hours test.
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: dvnguyen@us.ibm.com
                CC: wmb@us.ibm.com


Distribution:
Hardware Environment:
pSeries p650
Software Environment:
2.6.0-test9
Problem Description:
Ran SPECweb99_SSL benchmark test for 3 hours and system crashed .
Here are some information about xmon:
0:mon> t
c0000007fc70fd00  c00000000035ddfc  .tcp_do_twkill_work+0x19c/0x1b0
c0000007fc70fdd0  c00000000035e064  .twkill_work+0x11c/0x1b4
c0000007fc70fe80  c00000000006457c  .worker_thread+0x280/0x3b8
c0000007fc70ff90  c000000000017d4c  .kernel_thread+0x4c/0x68
0:mon>
0:mon> r
R00 = 0000000000000001   R16 = 0000000000000000
R01 = c0000007fc70fd00   R17 = 0000000000000000
R02 = c000000000679000   R18 = 0000000000000000
R03 = c0000007fc2a5b80   R19 = 0000000000000000
R04 = c0000007fc2a4000   R20 = 0000000000c00000
R05 = 0000000000000000   R21 = 0000000000000000
R06 = c0000000005ec880   R22 = c000000000745ce8
R07 = c0000007f9000000   R23 = 0000000000000064
R08 = 00000000000d4c50   R24 = 0000000000000000
R09 = 0000000000000000   R25 = 0000000000000001
R10 = 0000000000000001   R26 = 0000000000000001
R11 = c0000007fc2a4010   R27 = c00000065069aef8
R12 = 0000000024000080   R28 = c00000062d56acf8
R13 = c0000000005aa000   R29 = c0000000004ea428
R14 = 0000000000000000   R30 = c0000000005927e8
R15 = 0000000000000000   R31 = c00000062d56ac80
pc  = c00000000035dce0   msr = 9000000000009032
lr  = c00000000035ddfc   cr  = 0000000084008080
ctr = 0000000000000000   xer = 0000000020000000   trap =      300
0:mon> S
msr  = 9000000000001032  sprg0= 0000000000000000
pvr  = 0000000000380201  sprg1= 0000000000000000
dec  = 000000003f96aab1  sprg2= 0000000000c00000
sp   = c0000007fc70f560  sprg3= c0000000005aa000
toc  = c000000000679000  dar  = 0000000000000000
srr0 = c00000000000a888  srr1 = 9000000000001032
asr  = 0000000000009001
sr00 = 0000000000000053  sr08 = 0000000000000053
sr01 = 0000000000000053  sr09 = 0000000000000053
sr02 = 0000000000000053  sr10 = 0000000000000053
sr03 = 0000000000000053  sr11 = 0000000000000053
sr04 = 0000000000000053  sr12 = 0000000000000053
sr05 = 0000000000000053  sr13 = 0000000000000053
sr06 = 0000000000000053  sr14 = 0000000000000053
sr07 = 0000000000000053  sr15 = 0000000000000053
Paca:
  Local Processor Control Area (LpPaca):
    Saved Srr0=0000000000000000  Saved Srr1=0000000000000000
    Saved Gpr3=0000000000000000  Saved Gpr4=0000000000000000
    Saved Gpr5=0000000000000000
  Local Processor Register Save Area (LpRegSave):
    Saved Sprg0=0000000000000000  Saved Sprg1=0000000000000000
    Saved Sprg2=0000000000000000  Saved Sprg3=0000000000000000
    Saved Msr  =0000000000000000  Saved Nia  =0000000000000000
0:mon> e
cpu 0: Vector: 300 (Data Access) at [c0000007fc70fa80]
    pc: c00000000035dce0 (.tcp_do_twkill_work+0x80/0x1b0)
    lr: c00000000035ddfc (.tcp_do_twkill_work+0x19c/0x1b0)
    sp: c0000007fc70fd00
   msr: 9000000000009032
   dar: 0
 dsisr: 42000000
  current = 0xc0000007fc7547b8
  paca    = 0xc0000000005aa000
    pid   = 10, comm = events/0
0:mon> s
Oops: Kernel access of bad area, sig: 11 [#1]
NIP: C00000000035DCE0 XER: 0000000020000000 LR: C00000000035DDFC
REGS: c0000007fc70fa80 TRAP: 0300    Not tainted
MSR: 9000000000009432 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000000000000000, DSISR: 0000000042000000
TASK = c0000007fc7547b8[10] 'events/0'  CPU: 0
GPR00: 0000000000000001 C0000007FC70FD00 C000000000679000 C0000007FC2A5B80
GPR04: C0000007FC2A4000 0000000000000000 C0000000005EC880 C0000007F9000000
GPR08: 00000000000D4C50 0000000000000000 0000000000000001 C0000007FC2A4010
GPR12: 0000000024000080 C0000000005AA000 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000C00000 0000000000000000 C000000000745CE8 0000000000000064
GPR24: 0000000000000000 0000000000000001 0000000000000001 C00000065069AEF8
GPR28: C00000062D56ACF8 C0000000004EA428 C0000000005927E8 C00000062D56AC80
NIP [c00000000035dce0] .tcp_do_twkill_work+0x80/0x1b0
Call Trace:
[c00000000035e064] .twkill_work+0x11c/0x1b4
[c00000000006457c] .worker_thread+0x280/0x3b8
[c000000000017d4c] .kernel_thread+0x4c/0x68
<0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..
=============================================

Quote here some debug info:
"I disassembled the kernel around where the crash occurs, and compared that to 
the source code.  It's a little hard to follow due to the inlining, but I think 
I see where in the source the crash is occurring.

tcp_do_twkill_work calls __tw_del_dead_node(tw), which calls  __hlist_del(&tw-
> tw_death_node).  I think the crash occurs in __hlist_del, at the line shown 
below.

static __inline__ void __hlist_del(struct hlist_node *n)
{                                                       
        struct hlist_node *next = n->next;              
        struct hlist_node **pprev = n->pprev;           
        *pprev = next;        <<<<<<---------- crash occurs here            
        if (next)                                       
                next->pprev = pprev;                    
}

The corresponding assembly code looks as follows:

c000000000376380:  eb 7c 00 00     ld      r27,0(r28)           
c000000000376384:  e9 3c 00 08     ld      r9,8(r28)            
c000000000376388:  3b bc ff 88     addi    r29,r28,-120         
c00000000037638c:  2e 3b 00 00     cmpdi   cr4,r27,0            
c000000000376390:  fb 69 00 00     std     r27,0(r9)  <<<---- crashes here 
c000000000376394:  41 92 00 08     beq-    cr4,c00000000037639c 
c000000000376398:  f9 3b 00 08     std     r9,8(r27)           
"
"The xmon output shows that r9 == 0.  Linking this back to the source code, this 
means that pprev == n->pprev == NULL in hlist_del."
"

I'll test the latest kernel (test11) and will have some infor posted back here.

Steps to reproduce:
Need to run SPECweb99_SSL benchmark to reproduce problem.


