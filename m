Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932423AbWFEFvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWFEFvs (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 01:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWFEFvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 01:51:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932400AbWFEFvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 01:51:47 -0400
Date: Sun, 4 Jun 2006 22:51:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when
 resuming from disk
Message-Id: <20060604225140.cf87519f.akpm@osdl.org>
In-Reply-To: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 22:23:24 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

Please don't send word-wrapped emails.

> [  355.081000] swsusp: Need to copy 59004 pages
> [  355.081000] Intel machine check architecture supported.
> [  355.081000] Intel machine check reporting enabled on CPU#0.
> [  355.081000] swsusp: Restoring Highmem
> [  487.081000] APIC error on CPU0: 00(00)

What's this?

> [  487.203000] ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No
> context for object [c174d620] [20060310]

And this?

> [  487.203000] PM: Writing back config space on device 0000:00:00.0 at
> offset 1 (was 22300006, writing 32300006)
> [  487.203000] PCI: Setting latency timer of device 0000:00:01.0 to 64
> [  487.204000] PM: Writing back config space on device 0000:00:06.0 at
> offset 1 (was 2100005, writing 2100000)
> [  487.204000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
> [  487.204000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
> [  487.205000]  [<c0105c3c>] show_trace+0x2c/0x30
> [  487.205000]  [<c0105c6b>] dump_stack+0x2b/0x30
> [  487.205000]  [<c033d4fa>] schedule+0x6fa/0xa30
> [  487.205000]  [<c033e111>] schedule_timeout+0x51/0xc0
> [  487.205000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
> [  487.206000]  [<c012aada>] msleep+0x2a/0x50
> [  487.206000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
> [  487.208000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
> [  487.209000]  [<c022e6a0>] pci_enable_device+0x30/0x40
> [  487.211000]  [<e0a36ee0>] snd_cmipci_resume+0x30/0x110 [snd_cmipci]
> [  487.211000]  [<c023045a>] pci_device_resume+0x2a/0x80
> [  487.213000]  [<c02909a9>] resume_device+0x59/0xd0
> [  487.215000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
> [  487.217000]  [<c0290b85>] device_resume+0x15/0x1f
> [  487.219000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
> [  487.220000]  [<c014bcd5>] enter_state+0x145/0x190
> [  487.220000]  [<c014bdb9>] state_store+0x99/0xb0
> [  487.221000]  [<c01d1413>] subsys_attr_store+0x33/0x40
> [  487.222000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
> [  487.223000]  [<c0182361>] vfs_write+0x101/0x1f0
> [  487.224000]  [<c0182fec>] sys_write+0x4c/0x90
> [  487.225000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
> [  487.225000]  [<b7f40410>] 0xb7f40410
> [  487.227000] PCI: Enabling device 0000:00:06.0 (0000 -> 0001)
> [  487.227000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level,

The interesting thing is that we've done sleepy things like down() just
prior to this.  Do you have CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP
enabled?  If not, please turn them on, see what happens.

I don't see anything on that code path which would cause this.  Maybe I
missed it.

