Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUGOMKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUGOMKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUGOMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:10:49 -0400
Received: from nef.ens.fr ([129.199.96.32]:16388 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S266183AbUGOMKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:10:46 -0400
Date: Thu, 15 Jul 2004 14:10:43 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>, pavel@ucw.cz
Subject: swsuspend not working
Message-ID: <20040715121042.GB9873@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Thu, 15 Jul 2004 14:10:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With Pavel declaring that software suspend was mostly working on non-SMP
computers and that only device drivers were to remained to be fixed, I
felt that I needed to give it a try.

You see, on the three latest computers I have played with (two laptops
and one desktop), I never managed to get suspend to disk to work. The
best I got was a year ago for some revision of pmdisk were, for stripped
down kernels with no module loaded I could suspend and resume once in a
while. Then Patrick released a new version and it never worked again.
Then Patrick stopped working on that.

I have never tried swsusp2 because my goal, ultimately, is to have S3
working. I understand that S3 is much more difficult than S4 and that
swsusp2 does not deal with S3. So the plan is to have S4 on swsusp, then
S3. (Actually, my latest laptop seems to have S3 half working with
kernel parameter acpi_sleep=s3_bios, but S4 does not.)

As I said, I felt ready for trying again. I compiled a 2.6.8-rc1 kernel
with the barest possible configuration file: support for IDE, ext3,/proc,
keyboard and acpi. No mouse, no usb, no framebuffer, no agp, no preempt,
no apic, no module, etc. A useless kernel, obviously, but I tried to
maximize the odds to have S4 working.

I booted with " root=/dev/hda2 resume=/dev/hda5 init=/bin/sh". No initrd,
of course. Once I had a prompt, I mounted /proc and echoed 4 to
/proc/acpi/sleep. The screen blinked and 3 seconds later I was back at my
shell. The computer did not suspend. One very bad thing happened: in the
process, the fan controller was reset. It means that the fan went full
speed, while before it was in a low speed/low noise mode set up by the
bios. I know I cannot bring it back to the low speed/low noise setting
from linux, I must reboot the computer. But anyway, the computer did not
suspend.

Here are the kernel messages I got:
-----------------------------------------
dsmthdat-0462 [36] ds_method_data_get_val: Uninitialized Local[0] at node df72f10c
Freeing memory: .....|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
dsmthdat-0462 [36] ds_method_data_get_val: Uninitialized Local[0] at node df72f10c
dsmthdat-0462 [36] ds_method_data_get_val: Uninitialized Local[0] at node df72f90c
Restarting tasks... done
-------------------------------------------
(device 0000:00:1f.1 is the IDE controller. lspci output says it is
connected to IRQ 11, but /proc/interrupts gives IRQ 14 for ide0 and
nothing for IRQ 11)

What does that mean ? What can I do to debug the problem and have S4
working ? I am leaving for a long WE, but starting on Monday, I am
willing to try any patch or any kernel configuration to have things
working.

All relevant information on the computer (lspci, dsdt, kernel config,
full dmesg) is on http://tudia.nerim.net/bug-reports/

Thanks,

	Éric Brunet
