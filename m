Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUIVRvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUIVRvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUIVRvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:51:41 -0400
Received: from gprs214-200.eurotel.cz ([160.218.214.200]:5256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266467AbUIVRvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:51:18 -0400
Date: Wed, 22 Sep 2004 19:50:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem with suspend and usb
Message-ID: <20040922175058.GA14891@elf.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz> <20040922094844.GA9197@elf.ucw.cz> <1095870490.3809.3.camel@taz.graycell.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095870490.3809.3.camel@taz.graycell.biz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well, turns out that the lastest -mm kernel is much worse.

Hmm, well, I'm not going to debug -vanilla when there's better
codebase pending in -mm, so -mm is better because it has chance to get
debugged.

> Found several problems:
> * Shutdown is very slow. After the message "acpi_power_off called"
> appears, it taken ~30s for the laptop to shutdown. Using 2.6.8 it shuts
> down immediately after that message is printed.

Insert printk's to see what is slow, then contact acpi list.

> * Suspend with ohci_hcd hangs. Removing the ohci_hcd module suspend
> works.
> Here's what's printed on the screen before hanging (I hand-write it so
> there could be some typos)
> 
> Freeing memory.... done (54077 pages freed)
> usbhid1-1:1.0: resume is unsafe!
> usb1-1: no poweroff yet, suspending instead.
> usb usb1: no poweroff yet, suspending instead.
> ............. swsusp: Need to copy 9776 pages
> ............. swsusp: critical section/: done (9840 pages copied)

Can you insert printks to ohci_hcd to see what went wrong there?

> * Network doesn't work after resuming. I'm using 8139cp. I tried "ifdown
> eth0 && ifup eth0" and network stil. doesn't work after suspend.
> Even tried "ifdown eth0 && modprobe -r 8139cp && modprobe 8139cp && ifup
> eth0" and network still doesn't work. Only started to work after reboot
> Here are the logs from the suspend request 

This looks like interrupt problem. Can you try noapic and/or disabling
acpi for irq routing?

> Sep 22 15:29:42 taz kernel: ** PCI interrupts are no longer routed automatically.  If this
> Sep 22 15:29:42 taz kernel: ** causes a device to stop working, it is probably because the
> Sep 22 15:29:42 taz kernel: ** driver failed to call pci_enable_device().  As a temporary
> Sep 22 15:29:42 taz kernel: ** workaround, the "pci=routeirq" argument restores the old
> Sep 22 15:29:42 taz kernel: ** behavior.  If this argument makes the device work again,
> Sep 22 15:29:42 taz kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
> Sep 22 15:29:42 taz kernel: ** so I can fix the driver.

Hmm, also try pci=routeirq.
										Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
