Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTJUHR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTJUHR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:17:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53660 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262980AbTJUHR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:17:56 -0400
Date: Tue, 21 Oct 2003 00:12:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: lists@mdiehl.de, noah@caltech.edu, irda-users@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
Message-Id: <20031021001241.390a16df.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310210858550.4246-100000@notebook.home.mdiehl.de>
References: <20031020211706.5be33474.davem@redhat.com>
	<Pine.LNX.4.44.0310210858550.4246-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 09:12:53 +0200 (CEST)
Martin Diehl <lists@mdiehl.de> wrote:

> Last time I checked pci_dma_sync was meant to sync the mapping when 
> ownership gets transferred from busmaster to cpu, i.e. after hardware 
> used/modified the buffer. What about the other direction when the cpu 
> filled a reused streaming map to device and wants to pass ownership to the 
> busmaster - we need to flush cpu caches to make sure the busmaster sees 
> the modified data.

That's absolutely correct.

Several times I've noted that this is a BUG in the API, that there
is no way to sync the other way, someone just has to add the interface
hooks then all the platform maintainers will implement it.

Here, do this, add a new interface called pci_dma_sync_to_device()
with the appropriate args.  Add a NOP implementation to asm-i386/pci.h
and suitable documentation changes to Documentation/DMA-mapping.txt

When you send me that patch, I'll work with the platform maintainers
to take care of the rest.

Deal?
