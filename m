Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272899AbTHEQzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272898AbTHEQxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:53:18 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:49827 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272869AbTHEQvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:51:22 -0400
Date: Tue, 5 Aug 2003 18:51:17 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Ducrot Bruno <poup@poupinou.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805165117.GH18982@louise.pinerecords.com>
References: <20030805162604.GF18982@louise.pinerecords.com> <Pine.LNX.4.44.0308050946030.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308050946030.23977-100000@cherise>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [mochel@osdl.org]
> 
> > > > o  only enable cpufreq options if power management is selected
> > > > o  don't put cpufreq options in a separate submenu
> > > 
> > > Yes, but what I do not understand is why cpufreq need power management.
> > 
> > Because it is a power management option. :)
> > 
> > CONFIG_PM is a dummy option, it does not link any code into the kernel
> > by itself.
> 
> Actually, it does:
> 
> ./arch/arm/kernel/Makefile:obj-$(CONFIG_PM)             += pm.o
> ./arch/arm/mach-pxa/Makefile:obj-$(CONFIG_PM) += pm.o sleep.o
> ./arch/arm/mach-sa1100/Makefile:obj-$(CONFIG_PM)                        += pm.o sleep.o
> ./arch/i386/kernel/Makefile:obj-$(CONFIG_PM)            += suspend.o
> ./drivers/pci/Makefile:obj-$(CONFIG_PM)  += power.o
> ./kernel/Makefile:obj-$(CONFIG_PM) += pm.o power/
> 
> But, I agree with your change anyway. 

Trouble is, the same goes for ACPI -- it doesn't require that CONFIG_PM
code be present.

I think the correct x86 solution would be to introduce a real dummy
option for the menus, and imply CONFIG_PM if APM or swsusp (the two
options that seem to actually need CONFIG_PM code) is enabled.

-- 
Tomas Szepe <szepe@pinerecords.com>
