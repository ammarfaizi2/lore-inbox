Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTLOTYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTLOTYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263886AbTLOTYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:24:16 -0500
Date: Mon, 15 Dec 2003 14:23:37 -0500
From: Alan Cox <alan@redhat.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: arjanv@redhat.com, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215192337.GA18811@devserv.devel.redhat.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDDBDFE.5020707@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks confusing. On my test system (don't ask details, I am not 
> alowed to share this info), I see
> video controller with 256Mb BAR. Does it mean this controller will not 
> work as well?

The 256Mb BAR turns up in a variety of graphic cards, and 512Mb in a few.
The kernel maps just enough memory for the frame buffer + cache. There isn't
enough space to map it all. User space apps may well have the 512Mb mapped 
into their address space, but that isnt the kernel one

> There is alternative solution, for each transaction to ioremap/unmap 
> corresponded page.
> I don't like it, it involves huge overhead.

ioremap means you can't use pci_exp_* from an interrupt so kmap is probably
needed. It is overhead but the design of the 386 left us with that problem on
x86 platforms and it isnt going to go away. On ia64/x86_64 etc its a non issue


