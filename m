Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTGAHpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTGAHpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:45:16 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:25483 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261168AbTGAHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:45:03 -0400
Date: Tue, 1 Jul 2003 18:03:55 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: can't get linux to perform a bios suspend (was: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend)
Message-ID: <20030701080355.GA6404@zip.com.au>
References: <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au> <20030618103528.GB203@elf.ucw.cz> <20030621142400.GB5388@zip.com.au> <20030622151549.GD199@elf.ucw.cz> <20030623005814.GA583@zip.com.au> <20030623095058.GB6158@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623095058.GB6158@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 11:50:58AM +0200, Pavel Machek wrote:
> Modification you did is wrong; I'd try
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
>         if ((state == 4) && (state_string[1] != 'b')) {
> 	        software_suspend();
>                 goto Done;
>         }
> #endif  

Well I went the brute force way:

        /*
#ifdef CONFIG_SOFTWARE_SUSPEND
        if (state == 4) {
                software_suspend();
                goto Done;
        }
#endif
        */

Since it's h/w suspend I cared about, I didn't think it was important
to retain sw suspend.

> Does s3 work for you? s3 and s4bios should be really similar.

No. They both die in similar and different ways. :) s3 suspends to ram
(ie laptop goes sleepies) but on resume the kernel is totally hung. s4b
completely fails to suspend and the kernel doesn't like accepting input.
It still functions as the mouse generates synaptics errors and there's
continuous error output re eth0 but otherwise it's a dead duck.

Here is the console output for s3 and s4bios under 2.5.73-bk8:

s3:

Stopping tasks: XFree86 entered refrigerator
=klogd entered refrigerator
=init entered refrigerator
=khubd entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=pccardd entered refrigerator
=pccardd entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=portmap entered refrigerator
=rpciod entered refrigerator
=lockd entered refrigerator
=syslogd entered refrigerator
=acpid entered refrigerator
=gpm entered refrigerator
=inetd entered refrigerator
=cupsd entered refrigerator
=sendmail entered refrigerator
=sshd entered refrigerator
=rpc.statd entered refrigerator
=atd entered refrigerator
=cron entered refrigerator
=fetchmail entered refrigerator
=xdm entered refrigerator
=getty entered refrigerator
=getty entered refrigerator
=xdm entered refrigerator
=|
Suspending devices
Suspending devices
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
Suspending devices
Badness in local_bh_enable at kernel/softirq.c:109
Call Trace:
 [<c011e7b8>] local_bh_enable+0x38/0x60
 [<c0277dc8>] e100_config_wol+0x74/0x78
 [<c0276821>] e100_do_wol+0xd/0x50
 [<c0277283>] e100_suspend+0x2b/0x74
 [<c01f9da7>] pci_device_suspend+0x3f/0x4c
 [<c0262b8b>] device_suspend+0x6b/0xe8
 [<c022597c>] acpi_system_save_state+0x70/0x98
 [<c0225a80>] acpi_suspend+0x58/0xa8
 [<c0225cbf>] acpi_system_write_sleep+0xfb/0x13c
 [<c0145bee>] vfs_write+0x9e/0xd0
 [<c0145ca0>] sys_write+0x30/0x50
 [<c0108d33>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:109
Call Trace:
 [<c011e7b8>] local_bh_enable+0x38/0x60
 [<c0277986>] e100_config+0x9a/0x104
 [<c0276827>] e100_do_wol+0x13/0x50
 [<c0277283>] e100_suspend+0x2b/0x74
 [<c01f9da7>] pci_device_suspend+0x3f/0x4c
 [<c0262b8b>] device_suspend+0x6b/0xe8
 [<c022597c>] acpi_system_save_state+0x70/0x98
 [<c0225a80>] acpi_suspend+0x58/0xa8
 [<c0225cbf>] acpi_system_write_sleep+0xfb/0x13c
 [<c0145bee>] vfs_write+0x9e/0xd0
 [<c0145ca0>] sys_write+0x30/0x50
 [<c0108d33>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:109
Call Trace:
 [<c011e7b8>] local_bh_enable+0x38/0x60
 [<c0274d35>] e100_exec_non_cu_cmd+0x12d/0x1c8
 [<c0277990>] e100_config+0xa4/0x104
 [<c0276827>] e100_do_wol+0x13/0x50
 [<c0277283>] e100_suspend+0x2b/0x74
 [<c01f9da7>] pci_device_suspend+0x3f/0x4c
 [<c0262b8b>] device_suspend+0x6b/0xe8
 [<c022597c>] acpi_system_save_state+0x70/0x98
 [<c0225a80>] acpi_suspend+0x58/0xa8
 [<c0225cbf>] acpi_system_write_sleep+0xfb/0x13c
 [<c0145bee>] vfs_write+0x9e/0xd0
 [<c0145ca0>] sys_write+0x30/0x50
 [<c0108d33>] syscall_call+0x7/0xb

uhci-hcd 0000:00:07.2: suspend to state 3

After this is suspended nicely (laptop led was flashing indicating s2r 
suspend). The ethernet dirver is the intel eepro100 one.

s4bios:

Stopping tasks: XFree86 entered refrigerator
=klogd entered refrigerator
=init entered refrigerator
=khubd entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=pccardd entered refrigerator
=pccardd entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=portmap entered refrigerator
=rpciod entered refrigerator
=lockd entered refrigerator
=syslogd entered refrigerator
=acpid entered refrigerator
=gpm entered refrigerator
=inetd entered refrigerator
=cupsd entered refrigerator
=sendmail entered refrigerator
=sshd entered refrigerator
=rpc.statd entered refrigerator
=atd entered refrigerator
=cron entered refrigerator
=fetchmail entered refrigerator
=xdm entered refrigerator
=getty entered refrigerator
=xdm entered refrigerator
=getty entered refrigerator
=|
Suspending devices
Suspending devices
hda: start_power_step(step: 0)
hda: completing PM request, suspend
uhci-hcd 0000:00:07.2: resume
e100: e100_deisolate_driver: device configuration failed
e100: eth0: start_ru: wait_scb failed
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
Devices Resumed
e100: eth0: e100_wait_exec_simple: failed
...
e100: eth0: e100_wait_exec_simple: failed
Synaptics driver lost sync at 1st byte
...
Synaptics driver lost sync at 1st byte
e100: eth0: e100_wait_exec_simple: failed
...

The Synaptics driver errors were caused by me moving the mouse. I was testing
to see if there was any sort of life left in the kernel. The e100 errors
kept on being produced ed-nauseum at a rate of about 1/second.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
