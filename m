Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVJJRAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVJJRAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVJJRAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:00:42 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:27079 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750945AbVJJRAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:00:41 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128720351.17365.48.camel@gaston>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 14:41:57 +0200
Message-Id: <1128948118.23434.13.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-08 at 07:25 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2005-10-06 at 21:19 +0200, Soeren Sonnenburg wrote:
> > On Mon, 03 Oct 2005 07:12:24 +0000, Soeren Sonnenburg wrote:
> > 
> > > Hi all,
> > > 
> > > when a dvd featuring some iso content is in the dvd-drive and the
> > > machine is put to sleep mode, it will give the following oops on resume.
> > > It is working without problems if no media is in the drive.
> > > Voluntary preemption is ON.
> > > Find below the dmesg output when a dvd is in the drive.
> > 
> > now it is:
[incomplet oops]

ok, here is the complete one:

BUG: soft lockup detected on CPU#0!
NIP: C0006FCC LR: C02BC32C SP: EDEF5C00 REGS: edef5b50 TRAP: 0901    Not tainted
MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
TASK = ef894780[3425] 'pbbuttonsd' THREAD: edef4000
Last syscall: 54 
GPR00: 00000080 EDEF5C00 EF894780 00079C96 000088B8 00000000 00000000 C05A8A50 
GPR08: C05A8538 EDEF5CC8 00100000 00140040 22004222 
NIP [c0006fcc] __delay+0xc/0x14
LR [c02bc32c] ide_wait_not_busy+0x4c/0xc0
Call trace:
 [c02ba670] ide_do_request+0x5b0/0x990
 [c02bab10] ide_do_drive_cmd+0xc0/0x190
 [c02b72d0] generic_ide_resume+0x80/0xa0
 [c0294260] resume_device+0x70/0x150
 [c0294510] dpm_resume+0x100/0x1a0
 [c02945ec] device_resume+0x3c/0xa0
 [c05438cc] pmac_wakeup_devices+0xbc/0xe0
 [c0544adc] pmu_ioctl+0x58c/0x9b0
 [c008e344] do_ioctl+0x84/0x90
 [c008e3dc] vfs_ioctl+0x8c/0x450
 [c008e834] sys_ioctl+0x94/0xb0
 [c0004820] ret_from_syscall+0x0/0x44
hdc: Enabling MultiWord DMA 2
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
hdc: irq timeout: status=0xc0 { Busy }
ide: failed opcode was: unknown
hdc: DMA disabled
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
hdc: ATAPI reset complete

> You haven't put the complete oops, what is the trap number ? Does it
> help adding a delay in the wakeup code in drivers/ide/ppc/pmac.c ? Also,

are you talking about increasing this delay 
#define IDE_WAKEUP_DELAY    (1*HZ) or sth. to pmac_ide_do_resume() ?

> is the problem present without preempt ?

Currently it is:
Preemption Model (Voluntary Kernel Preemption (Desktop))

I will try.
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

