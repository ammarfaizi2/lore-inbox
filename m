Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTENG02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTENGZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:25:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40149 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262282AbTENGZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:25:46 -0400
Date: Tue, 13 May 2003 21:24:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 715] New: panic at scsi_io_completion+0x171/0x480 (NULL pointer deref)
Message-ID: <4480000.1052886250@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: panic at scsi_io_completion+0x171/0x480 (NULL pointer
                    deref)
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: wescott_mike@emc.com


Distribution:RH-7.3
Hardware Environment:
   4x P-200 (smp)
   2 scsi bus aic7880: Ultra Wide
   cdrom is MATSHITA  Model: CD-ROM CR-504     Rev: ST20
Software Environment:
Problem Description:
    panic at panic at scsi_io_completion+0x171/0x480 (NULL pointer deref)
       with smp kernel and with smp kernel running nosmp

    problem does not occur with 2.4.18

Steps to reproduce:
   run dd if=/dev/cdrom of=/dev/null bs=2k and while that's active
   eject /dev/cdrom

console output:

# eject /dev/cdrom
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0208181
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0208181>]    Not tainted
EFLAGS: 00010203
EIP is at scsi_io_completion+0x171/0x480
eax: 00000012   ebx: db71be20   ecx: 00000004   edx: dfcf1300
esi: db71bee0   edi: 00000000   ebp: db71be20   esp: c036be90
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c036a000 task=c02ff0e0)
Stack: 00000005 00000000 dfcf1300 dfd59c00 00000000 08000002 dfdb3e00 dfd2c038 
       00000007 00000005 dfd20020 00000005 00000000 0003ac41 00000001 dfe1445f 
       dffa7260 00000082 dfd2c038 dfdb3e00 dfd2c038 c022480e db71be20 db71be20 
Call Trace:
 [<c022480e>] ahc_done+0x43e/0x490
 [<c022e4dd>] rw_intr+0x10d/0x120
 [<c0203203>] scsi_finish_command+0xd3/0xe0
 [<c0202fe9>] scsi_softirq+0xf9/0x210
 [<c011fc7b>] do_softirq+0x6b/0xd0
 [<c010b116>] do_IRQ+0xf6/0x110
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106ee0>] default_idle+0x0/0x40
 [<c01098d0>] common_interrupt+0x18/0x20
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106ee0>] default_idle+0x0/0x40
 [<c0106f0d>] default_idle+0x2d/0x40
 [<c0106fb2>] cpu_idle+0x52/0x70
 [<c0105000>] _stext+0x0/0x50
 [<c036c7f6>] start_kernel+0x146/0x150

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 89 42 7c eb 12 8b 7c 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


