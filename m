Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTLOOcY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTLOOcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:32:24 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:2936 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263638AbTLOOcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:32:22 -0500
Date: Mon, 15 Dec 2003 15:31:41 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215143141.GB23381@devserv.devel.redhat.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDDBDFE.5020707@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 03:58:22PM +0200, Vladimir Kondratiev wrote:
> Got it.
> Should I understand it this way: for system with >=1Gb RAM, I will be 
> unable to ioremap 256Mb region?
> It looks confusing. On my test system (don't ask details, I am not 
> alowed to share this info), I see
> video controller with 256Mb BAR. Does it mean this controller will not 
> work as well?

Video memory is generally not ioremap'd by the kernel (it may be mapped into
XFree's address space though)

> I thought about remapping only pages that have actual PCI devices behind,
> but this is problematic: access to config goes not always through 
> pci_exp_read_config_xxx and alike, raw access with bus/dev/fn numbers 
> used as well. And in 2.6, correct me if I wrong, raw access using 
> bus/dev/fn numbers goes to be the only way. Per-device access replaced 
> with per-bus, at least.

I would suspect you want to store the ioremap cookie for the config space in
the pci device struct; longer term that struct maybe needs to grow a few
function pointers to access config space too... 
