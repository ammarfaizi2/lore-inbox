Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIWXVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIWXVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUIWXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:21:33 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:41353 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S267410AbUIWXT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:19:27 -0400
Subject: Re: problem with suspend and usb
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20040922175058.GA14891@elf.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz>
	 <20040922094844.GA9197@elf.ucw.cz>
	 <1095870490.3809.3.camel@taz.graycell.biz>
	 <20040922175058.GA14891@elf.ucw.cz>
Content-Type: text/plain
Organization: Graycell
Date: Fri, 24 Sep 2004 00:19:26 +0100
Message-Id: <1095981566.4339.16.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qua, 2004-09-22 at 19:50 +0200, Pavel Machek wrote:
[CCing acpdi-devel, sorry not to do it from the start but I didn't even
know that the ml existed, the mail below is about some problems I have
suspending, some are new in 2.6.9-rc2-mm2 other existed in 2.6.8]
> Hi!
> 
> > Well, turns out that the lastest -mm kernel is much worse.
> 
> Hmm, well, I'm not going to debug -vanilla when there's better
> codebase pending in -mm, so -mm is better because it has chance to get
> debugged.
> 
> > Found several problems:
> > * Shutdown is very slow. After the message "acpi_power_off called"
> > appears, it taken ~30s for the laptop to shutdown. Using 2.6.8 it shuts
> > down immediately after that message is printed.
> 
> Insert printk's to see what is slow, then contact acpi list.

OK, I inserted a printk between each line of acpi_power_off, I see
set_cpus_allowed finished and then the pause, then after ~30s the
poweroff, I never get to see the remaining printk.

> 
> > * Suspend with ohci_hcd hangs. Removing the ohci_hcd module suspend
> > works.
> > Here's what's printed on the screen before hanging (I hand-write it so
> > there could be some typos)
> > 
> > Freeing memory.... done (54077 pages freed)
> > usbhid1-1:1.0: resume is unsafe!
> > usb1-1: no poweroff yet, suspending instead.
> > usb usb1: no poweroff yet, suspending instead.
> > ............. swsusp: Need to copy 9776 pages
> > ............. swsusp: critical section/: done (9840 pages copied)
> 
> Can you insert printks to ohci_hcd to see what went wrong there?

Could you give a more precise instructions, I really know nothing about
kernel programming.
And I found something else, this only occurs when I have my usb mouse
plugged in. If there is no mouse plugged in, suspending  works and the 3
lines after "Freeing memory..." are not printed.
However, after resume I still need to remove and reinsert ohci_hcd
module to have usb work again, just like in 2.6.8.

> 
> > * Network doesn't work after resuming. I'm using 8139cp. I tried "ifdown
> > eth0 && ifup eth0" and network stil. doesn't work after suspend.
> > Even tried "ifdown eth0 && modprobe -r 8139cp && modprobe 8139cp && ifup
> > eth0" and network still doesn't work. Only started to work after reboot
> > Here are the logs from the suspend request 

I don't know how I tested it before, but the network works after
resuming if I remove the module and reinsert it.

> This looks like interrupt problem. Can you try noapic and/or disabling
> acpi for irq routing?
> 
Unfortunately my laptop doesn't even boot with those options

> > Sep 22 15:29:42 taz kernel: ** PCI interrupts are no longer routed automatically.  If this
> > Sep 22 15:29:42 taz kernel: ** causes a device to stop working, it is probably because the
> > Sep 22 15:29:42 taz kernel: ** driver failed to call pci_enable_device().  As a temporary
> > Sep 22 15:29:42 taz kernel: ** workaround, the "pci=routeirq" argument restores the old
> > Sep 22 15:29:42 taz kernel: ** behavior.  If this argument makes the device work again,
> > Sep 22 15:29:42 taz kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
> > Sep 22 15:29:42 taz kernel: ** so I can fix the driver.
> 
> Hmm, also try pci=routeirq.

This did nothing.

By the way, is there a swsusp specific list?

