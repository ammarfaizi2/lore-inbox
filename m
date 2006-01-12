Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWALLkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWALLkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWALLkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:40:08 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55182 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964871AbWALLkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:40:07 -0500
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <43C5D34B.1090903@reub.net>
References: <20060109203711.GA25023@kroah.com>
	 <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
	 <20060109164410.3304a0f6.akpm@osdl.org>
	 <1136857742.14532.0.camel@localhost.localdomain>
	 <20060109174941.41b617f6.akpm@osdl.org>  <43C5D34B.1090903@reub.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Jan 2006 11:42:25 +0000
Message-Id: <1137066145.17090.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 16:55 +1300, Reuben Farrelly wrote:
> ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
> ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
> Unable to handle kernel NULL pointer dereference at virtual address 00000000

That is the critical bit. The SATA ports have no PCI resources assigned
for bus mastering (BAR 4). libata should have driven the device PIO in
this case but the resource should have been assigned.

