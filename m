Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbTIAK6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTIAK6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:58:15 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:8576 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S262866AbTIAK6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:58:12 -0400
Date: Mon, 1 Sep 2003 12:57:59 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
Message-ID: <20030901105759.GA17637@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: mochel@osdl.org,linux-kernel@vger.kernel.org
Subject: Re: Power Management Update

(Resend. Seems it didn't get through the first time.)

In mailing-lists linux-kernel, you wrote:
>
>I'm pleased to announce the release of the first patchset of power
>management changes for 2.6.0. The purpose of this release is to give
>people a chance to review and test the PM code before it's sent on to
>Linus.

I gave this patch a try...  All data concerning my computer (config
files, boot messages, dsdt, etc.) is available on
<http://perso.nerim.net/~tudia/bug-reports>.

On my computer, echoing anything to /sys/power/state does nothing at all.
Not even a line in the logs.

On the text console (but with XFree and kde running in the background),

        echo 1 > /proc/acpi/sleep

        the screen blinks and the fan speed goes up. (fan speed is set by
        bios. Loading module i2c reinitialize the motherboard sensors and
        make fan speed go up too. But here, i2c was not loaded nor
        compiled in.) In the logs, I have:

Stopping tasks: ==================================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
 hwsleep-0257 [16] acpi_enter_sleep_state: Entering sleep state [S1]
Back to C!
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue df60d800, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks... done

        Note that, sometimes, the computer waits after printing "Entering
        sleep state [S1]", and resumes if I hit the key. The screen is
        however fully lit, so I am not sure that this is a success.

        echo 3 > /proc/acpi/sleep

        Maybe the screen blinks a little bit, but I am not sure. It is so
        fast... In the logs, I have:

PM: Preparing system for suspend
Stopping tasks:
=========================================================|
Restarting tasks... done


        echo 4 > /proc/acpi/sleep

        Suspend is working, the computer writes things in the swapfile
        and shuts down. On resume, I have a kernel panic. I have hand
        written this:

Process swapper
Call queue:
        start_request
        ide_do_request
        __elv_do_drive_cmd
        generic_ide_suspend
        autoremove_wake_function
        printk
        suspend_device
        device_suspend
        prepare
        pm_resume
        do_initcalls
        init_workqueues
        init
        init
        kernel_thread_helper
Code: Bad EIP value
Kernel panic: Attemppted to kill init


Regards,

        Éric Brunet
