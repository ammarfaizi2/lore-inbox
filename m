Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVJGV1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVJGV1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVJGV1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:27:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:53719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932532AbVJGV1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:27:51 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.10.06.19.19.22.673915@nn7.de>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>
Content-Type: text/plain
Date: Sat, 08 Oct 2005 07:25:51 +1000
Message-Id: <1128720351.17365.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 21:19 +0200, Soeren Sonnenburg wrote:
> On Mon, 03 Oct 2005 07:12:24 +0000, Soeren Sonnenburg wrote:
> 
> > Hi all,
> > 
> > when a dvd featuring some iso content is in the dvd-drive and the
> > machine is put to sleep mode, it will give the following oops on resume.
> > It is working without problems if no media is in the drive.
> > Voluntary preemption is ON.
> > Find below the dmesg output when a dvd is in the drive.
> 
> now it is:
> 
> GPR00: 00000080 EDEF5C00 EF894780 00079C96 000088B8 00000000 00000000 C05A8A50 
> GPR08: C05A8538 EDEF5CC8 00100000 00140040 22004222 
> NIP [c0006fcc] __delay+0xc/0x14
> LR [c02bc32c] ide_wait_not_busy+0x4c/0xc0
> Call trace:
>  [c02ba670] ide_do_request+0x5b0/0x990
>  [c02bab10] ide_do_drive_cmd+0xc0/0x190
>  [c02b72d0] generic_ide_resume+0x80/0xa0
>  [c0294260] resume_device+0x70/0x150
>  [c0294510] dpm_resume+0x100/0x1a0
>  [c02945ec] device_resume+0x3c/0xa0
>  [c05438cc] pmac_wakeup_devices+0xbc/0xe0
>  [c0544adc] pmu_ioctl+0x58c/0x9b0
>  [c008e344] do_ioctl+0x84/0x90
>  [c008e3dc] vfs_ioctl+0x8c/0x450
>  [c008e834] sys_ioctl+0x94/0xb0
>  [c0004820] ret_from_syscall+0x0/0x44

You haven't put the complete oops, what is the trap number ? Does it
help adding a delay in the wakeup code in drivers/ide/ppc/pmac.c ? Also,
is the problem present without preempt ?

Ben.

