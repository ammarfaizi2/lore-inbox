Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTGJRym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269507AbTGJRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:54:42 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:13075 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269509AbTGJRyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:54:40 -0400
Date: Thu, 10 Jul 2003 19:09:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add xbox subarchitecture
Message-ID: <20030710190918.A12653@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anders Gustafsson <andersg@0x63.nu>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030710172802.GB27744@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030710172802.GB27744@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Thu, Jul 10, 2003 at 07:28:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
> +ifeq ($(CONFIG_X86_XBOX),y)
> +#XXX Compiling with optimization makes 1.1-xboxen 
> +#    crash while decompressing the kernel
> +CFLAGS_misc.o   := -O0
> +endif

I don't think this should go in until it's clear that it's not a gcc
problem.

> +	if (mach_pci_is_blacklisted(bus,PCI_SLOT(devfn),PCI_FUNC(devfn)))

there's a few space missing..

> +#ifndef __ASM_MACH_PCI_BLACKLIST_H
> +#define __ASM_MACH_PCI_BLACKLIST_H
> +
> +#define mach_pci_is_blacklisted(bus,dev,fn) ( (bus>1) || (bus&&(dev||fn)) || ((bus==0 && dev==0) && ((fn==1)||(fn==2))) )

#define mach_pci_is_blacklisted(bus, dev, fn) \
	((bus > 1) || (bus && (dev || fn)) || \
	((!bus && !dev) && ((fn == 1) || (fn == 2))))

or even better an inline function


