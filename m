Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUIRIVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUIRIVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 04:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269161AbUIRIVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 04:21:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49796 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S269160AbUIRITt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 04:19:49 -0400
Date: Sat, 18 Sep 2004 10:20:04 +0200
From: "Oliver M. Bolzer" <oliver@gol.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla2xxx: frequent total lockups (2.6.8, 2.6.9-rc{1-mm5,2})
Message-ID: <20040918082003.GA1957@magi.fakeroot.net>
References: <20040915231657.GA2005@magi.fakeroot.net> <20040916163029.GA14441@praka.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916163029.GA14441@praka.san.rr.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:30:29AM -0700, Andrew Vasquez <andrew.vasquez@qlogic.com> wrote...

> > I'm currently setting up a new Dual Opteron box (Tyan Transport
> > GX28) equipped with a QLogic QLA2340 fibre channel HBA.
> > 
> > As soon as there is I/O load on the HBA, I start seeing
 
> Could you provide some details on the type of I/O load?  

Nothing special. cp-ing large data onto a regular ext3 filesystem,
dd-ing from /dev/zero to it. Since my last mail, I've seen system crashes
with the same oops without having anything mounted and thus no real I/O
via the HBA. Only if I completely pull the calbe and disconnect all
devices from the HBA, does it not crash.

> For another datapoint, did you have any problems with earlier driver
> versions (pre b21)?  2.6.8.1 had b14k...

I just tried 2.6.5 (b10?) and had the same oops in qla2x00_cmd_timeout.

> Hmm, could you enable some additional debug settings in the driver:
 
> Rerun your test, then forward over the log.

Done. The complete log, which is rather large, can be found at
http://www.cip.ifi.lmu.de/~bolzer/tmp/qla-problem/debug.log.1.gz
It has been taken with 2.6.9-rc1-mm5 (+ dma_fixups patch).

Lots of repetitions in there, so here are the interesting lookin parts:

Driver Loading
==============
QLogic Fibre Channel HBA Driver (ffffffffa0000000)
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 201
qla2300 0000:01:03.0: Found an ISP2312, irq 201, iobase 0xffffff0000006000
qla2300 0000:01:03.0: Configuring PCI space...
qla2300 0000:01:03.0: Configure NVRAM parameters...
qla2300 0000:01:03.0: Verifying loaded RISC code...
scsi(4): **** Load RISC code ****
scsi(4): Verifying Checksum of loaded RISC code.
scsi(4): Checksum OK, start firmware.
scsi(4): Issue init firmware.
qla2300 0000:01:03.0: Waiting for LIP to complete...
scsi(4): Asynchronous LIP RESET (f8f7).
qla2300 0000:01:03.0: LIP reset occured (f8f7).
scsi(4): LIP occured (f8f7).
qla2300 0000:01:03.0: LIP occured (f8f7).
scsi(4): Asynchronous LOOP UP (2 Gbps).
qla2300 0000:01:03.0: LOOP UP detected (2 Gbps).
scsi(4): F/W Ready - OK 
scsi(4): Asynchronous PORT UPDATE.
scsi(4): Port database changed ffff 0006.
scsi(4): fw_state=3 curr time=fffba5bf.
qla2300 0000:01:03.0: Topology - (Loop), Host Loop address 0x0
scsi(4): Configure loop -- dpc flags =0x80040
qla2x00_mailbox_command(4): **** FAILED. mbx0=4006, mbx1=7e, mbx2=0, cmd=6a ****
qla2x00_get_port_name(4): failed=102.
scsi(4): MBC_GET_PORT_NAME Failed, No FL Port
scsi(4): Alloc Target 0 @ 000001007e636000
scsi(4): Assigning target ID=00 @ 000001007e636000 to loop id=0x0066, port state
=0x4, port down retry=60
scsi(4): Alloc Lun 0 @ tgt 0.
scsi(4): Alloc Lun 1 @ tgt 0.
scsi(4): LOOP READY
DEBUG: detect hba 4 at address = 00000100032b03c8
scsi4 : qla2xxx
qla2300 0000:01:03.0: 
 QLogic Fibre Channel HBA Driver: 8.00.00b21-k-debug
  QLogic QLA2340 - 
  ISP2312: PCI-X (133 MHz) @ 0000:01:03.0 hdma+, host#=4, fw=3.03.02 IPX
  Vendor: IFT       Model: A16F-S1211        Rev: 341B
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:03.0: scsi(4:0:0:0): Enabled tagged queuing, queue depth 32.
SCSI device sdc: 2927173632 512-byte hdwr sectors (1498713 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
  Vendor: IFT       Model: A16F-S1211        Rev: 341B
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:03.0: scsi(4:0:0:1): Enabled tagged queuing, queue depth 32.
SCSI device sdd: 2927173632 512-byte hdwr sectors (1498713 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi4, channel 0, id 0, lun 1
Attached scsi generic sg3 at scsi4, channel 0, id 0, lun 1,  type 0
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2xxx_eh_abort: cmd already done sp=0000000000000000
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2xxx_eh_abort: cmd already done sp=0000000000000000
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x800.
cmd_timeout: Found in ISP 
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2xxx_eh_abort: cmd already done sp=0000000000000000
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip page_waitqueue+0x60/0x70
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2xxx_eh_abort: cmd already done sp=0000000000000000

>From here on, tons of UNDERRUN->did_error=2->Found in ISP messages with
the occasational "qla2xxx_eh_abort: cmd already done" mixed in, while
a dd from /dev/zero to the device was running, eventually leading to the
oops about 15-20min later. 

scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
cmd_timeout: Found in ISP 
scsi(4:0:0) UNDERRUN status detected 0x15-0x808.
scsi(4:0:0) qla2x00_done: did_error = 2, comp-scsi= 0x15-0x808.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2xxx_eh_abort: cmd already done sp=0000000000000000
Unable to handle kernel NULL pointer dereference at 00000000000001c8 RIP: 
<ffffffffa0005709>{:qla2xxx:qla2x00_cmd_timeout+841}
PML4 7e331067 PGD 7ddfc067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: qla2300 qla2xxx
Pid: 58, comm: kswapd0 Not tainted 2.6.9-rc1-mm5
RIP: 0010:[<ffffffffa0005709>] <ffffffffa0005709>{:qla2xxx:qla2x00_cmd_timeout+8
41}
RSP: 0018:ffffffff806589c8  EFLAGS: 00010096
RAX: 0000000000000000 RBX: 0000010036db3380 RCX: ffffffff80658a18
RDX: 0000000000000000 RSI: 0000000000000296 RDI: 00000100032b0448
RBP: 00000100032b0448 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000100032b03c8
FS:  0000002a968f5380(0000) GS:ffffffff806f1280(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000001c8 CR3: 0000000000101000 CR4: 00000000000006e0
Process kswapd0 (pid: 58, threadinfo 000001007fcb6000, task 000001007fc87070)
Stack: 000000000000000a 00000100032b2508 00000000801102c1 0000010002c209a0 
       0000010036db3380 ffffffffa00053c0 ffffffff80658a18 000000000000000a 
       0000000000000000 ffffffff80140540 
Call Trace:<IRQ> <ffffffffa00053c0>{:qla2xxx:qla2x00_cmd_timeout+0} 
       <ffffffff80140540>{run_timer_softirq+384} <ffffffff8013c131>{__do_softirq+113} 
       <ffffffff8013c1e5>{do_softirq+53} <ffffffff80110563>{apic_timer_interrupt+99} 
        <EOI> <ffffffff80163018>{shrink_cache+376} <ffffffff80163018>{shrink_cache+376} 
       <ffffffff801a5daf>{mb_cache_shrink_fn+111} <ffffffff80163a36>{shrink_zone+214} 
       <ffffffff80163e3a>{balance_pgdat+474} <ffffffff8016401b>{kswapd+267} 
       <ffffffff8014ccd0>{autoremove_wake_function+0} <ffffffff80131d90>{finish_task_switch+64} 

       <ffffffff8014ccd0>{autoremove_wake_function+0} <ffffffff80131df1>{schedule_tail+17} 

       <ffffffff8011086b>{child_rip+8} <ffffffff8015d720>{pdflush+0} 
       <ffffffff80163f10>{kswapd+0} <ffffffff80110863>{child_rip+0} 
       

Code: 48 8b 80 c8 01 00 00 49 3b 9c c4 00 01 00 00 75 43 31 c0 48 
RIP <ffffffffa0005709>{:qla2xxx:qla2x00_cmd_timeout+841} RSP <ffffffff806589c8>
CR2: 00000000000001c8
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


If there's any other debug level or code I should run, just let me know. 

-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
