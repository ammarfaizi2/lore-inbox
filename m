Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUBETgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUBETgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:36:25 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:32779
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266494AbUBETgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:36:14 -0500
Date: Thu, 5 Feb 2004 11:36:21 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040205193621.GE7658@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20040205184841.GB590@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pavel Machek <pavel@ucw.cz> [040205 10:50]:
> 
> > > Someone should really bug them to fix their BIOS. (BTW does keyboard work
> > > ok for you?) 

Ah, I think what's the keyboard problem. If I don't have usb compiled into
the kernel, my keyboard shows stuck keys continuously. I just posted my .config
at http://www.muru.com/linux/amd64/

> Attached is my cpufreq patch. You may still prefer yours, but this one
> has correct tables derived from ACPI.

Cool, I'll check it out.

> > There are some ACPI related issues though, such as: via-rhine gets wrong 
> > irq with ACPI on, system hangs with yenta_socket loaded if I 
> > connect/disconnect the power cord... So for now, I don't use the
> > PCMCIA.
> 
> They did something very stupid with io-ports at 0x4000. This should
> work around it. [Note, I probably have slightly different machine from
> you.]

Excellent, I'll try it out as well for the PCMCIA.

Here's a bios patch that gets rid of one error and allows the machine to
boot with ioapic option. I've not yet verified that it's this patch though.
With ioapic, the USB and network interrupts stop working, so there's
something else.

Tony						       

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-m6805-bios-warning

--- dsdt.dsl.orig	2004-02-03 23:34:13.000000000 -0800
+++ dsdt.dsl	2004-02-03 23:34:19.000000000 -0800
@@ -2922,7 +2922,7 @@
                     }
                 }
 
-                OperationRegion (CCRD, PCI_Config, 0x00, 0xA7)
+                OperationRegion (CCRD, PCI_Config, 0x00, 0xA8)
                 Field (CCRD, DWordAcc, Lock, Preserve)
                 {
                     Offset (0x04), 

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=Makefile

dump:
	./acpidmp DSDT > dsdt.orig && \
	cp dsdt.orig dsdt

decompile:
	./iasl -d dsdt

compile:
	./iasl -tc dsdt.dsl

install:
	cp dsdt.hex /usr/src/linux/drivers/acpi/tables/acpi_dsdt.c
--ReaqsoxgOBHFXBhH--
