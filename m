Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTDBDt0>; Tue, 1 Apr 2003 22:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTDBDt0>; Tue, 1 Apr 2003 22:49:26 -0500
Received: from dsl081-142-120.chi1.dsl.speakeasy.net ([64.81.142.120]:22270
	"EHLO topaz") by vger.kernel.org with ESMTP id <S261452AbTDBDtZ>;
	Tue, 1 Apr 2003 22:49:25 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-bk5 spinlock warnings/errors
From: Narayan Desai <desai@mcs.anl.gov>
Date: Tue, 01 Apr 2003 22:01:02 -0600
Message-ID: <87el4l4kg1.fsf@mcs.anl.gov>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Portable Code,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.5.66-bk5 on an thinkpad t21. This model has BIOS
suspend to disk function that is independent from the OS. (I think
that this is implemented as S3BIOS in ACPI)

I am using the laptop with apm, and whenever i hibernate to disk and
resume, i get the following in dmesg:

uhci-hcd 00:07.2: suspend to state 3
include/linux/seqlock.h:52: spin_lock(kernel/timer.c:c0341894) already locked by include/linux/seqlock.h/52
arch/i386/kernel/timers/timer_tsc.c:85: spin_lock(arch/i386/kernel/time.c:c033ea40) already locked by arch/i386/kernel/apm.c/1244
arch/i386/kernel/apm.c:1252: spin_unlock(arch/i386/kernel/time.c:c033ea40) not locked
include/linux/seqlock.h:61: spin_unlock(kernel/timer.c:c0341894) not locked
uhci-hcd 00:07.2: resume
eth1: New link status: Connected (0001)
hda: dma_timer_expiry: dma status == 0x24
drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c037abe8) already locked by drivers/ide/ide-io.c/948
drivers/ide/ide-io.c:990: spin_unlock(drivers/ide/ide.c:c037abe8) not locked
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

Any pointers/patches would be appreciated.
 -nld
