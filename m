Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWJAHPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWJAHPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 03:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWJAHPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 03:15:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWJAHPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 03:15:22 -0400
Date: Sun, 1 Oct 2006 00:15:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Keller <jpk@sgi.com>
Cc: linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       ayoung@sgi.com
Subject: Re: [PATCH 1/3] - Altix: Add initial ACPI IO support
Message-Id: <20061001001511.ae77d6b1.akpm@osdl.org>
In-Reply-To: <20060922145123.12414.81897.sendpatchset@attica.americas.sgi.com>
References: <20060922145123.12414.81897.sendpatchset@attica.americas.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 09:51:23 -0500
John Keller <jpk@sgi.com> wrote:

> First phase in introducing ACPI support to SN.

This:

--- gregkh-2.6.orig/include/linux/pci.h
+++ gregkh-2.6/include/linux/pci.h
@@ -405,6 +405,7 @@ extern struct bus_type pci_bus_type;
 extern struct list_head pci_root_buses;        /* list of all known PCI buses */
 extern struct list_head pci_devices;   /* list of all devices */
 
+void pcibios_fixup_device_resources(struct pci_dev *);
 void pcibios_fixup_bus(struct pci_bus *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);

breaks a bunch of architectures.

For example alpha has

void __init
pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus)

box:/usr/src/linux-2.6.18> grep -rl pcibios_fixup_device_resources .
./arch/alpha/kernel/pci.c
./arch/ia64/pci/pci.c
./arch/mips/pci/pci.c
./arch/powerpc/kernel/pci_64.c
./arch/powerpc/platforms/pseries/pci_dlpar.c
./include/asm-powerpc/pci.h

It needs work...
