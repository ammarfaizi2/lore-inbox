Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUAEUHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUAEUHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:07:18 -0500
Received: from bolt.sonic.net ([208.201.242.18]:55262 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S265445AbUAEUHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:07:15 -0500
Date: Mon, 5 Jan 2004 12:07:07 -0800
From: David Hinds <dhinds@sonic.net>
To: linux-kernel@vger.kernel.org
Cc: Amit <mehrotraamit@yahoo.co.in>, Russell King <rmk@arm.linux.org.uk>
Subject: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040105120707.A18107@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In arch/i386/kernel/setup.c we have:

	/* Tell the PCI layer not to allocate too close to the RAM area.. */
	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
	if (low_mem_size > pci_mem_start)
		pci_mem_start = low_mem_size;

which is meant to round up pci_mem_start to the nearest 1 MB boundary
past the top of physical RAM.  However this does not consider highmem.
Should this just be using max_pfn rather than max_low_pfn?

(I have a report of this failing on a laptop with a highmem kernel,
causing a PCI memory resource to be allocated on top of a RAM area)

-- Dave
