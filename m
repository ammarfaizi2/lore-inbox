Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUIKQoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUIKQoj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUIKQoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:44:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:10646 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268169AbUIKQoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:44:30 -0400
Message-ID: <41432AD4.2090003@suse.de>
Date: Sat, 11 Sep 2004 18:41:56 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, kevin-linux-kernel@scrye.com
Subject: Re: FYI: my current bigdiff
References: <20040909134421.GA12204@elf.ucw.cz> <20040910041320.DF700E7504@voldemort.scrye.com> <200409101646.01558.bjorn.helgaas@hp.com>
In-Reply-To: <200409101646.01558.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bjorn Helgaas wrote:

> I'm completely ignorant about how swsusp works; I guess this is my
> chance to learn.  "pci=routeirq" just causes us to do all the PCI
> ACPI IRQ routing at boot-time, before the drivers start up.  This
> happens in pci_acpi_init(), which is a subsys_initcall that is run
> at initial boot-time, but (I assume) not during a resume.

a resume is basically a fresh boot, including hardware initialization by
the compiled-in drivers (but not modules) but before starting init /
entering initrd, the old system state is read from swap, copied back and
somehow we continue where we left off at suspend time. Now the resume
methods of all device drivers are called, processes are restarted and we
are back in the game. (At least this is how i understood it all :-)

I can easily imagine that a driver with a slightly broken suspend /
resume method may fail without pci=routeirq if it does not do the irq
routing correctly during resume. It may work with pci=routeirq since
then everything is prepared for it before the resume actually happens.

Kevin may get away with unloading the usb host controller and the
prism54 drivers before suspend and reloading them after resume.

         Stefan
