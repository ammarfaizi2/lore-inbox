Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVDFPGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVDFPGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVDFPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:06:05 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:15034 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262158AbVDFPGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:06:03 -0400
To: linux-os@analogic.com
Cc: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
References: <1112781027.2687.6.camel@laptop.blackstar.nl>
	<tnxzmwc9gun.fsf@arm.com>
	<Pine.LNX.4.61.0504061040420.22273@chaos.analogic.com>
From: Catalin Marinas <catalin.marinas@gmail.com>
Date: Wed, 06 Apr 2005 16:05:51 +0100
In-Reply-To: <Pine.LNX.4.61.0504061040420.22273@chaos.analogic.com> (Richard
 B. Johnson's message of "Wed, 6 Apr 2005 10:53:07 -0400 (EDT)")
Message-ID: <tnxoecs9c8g.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> wrote:
> 1 Megabyte of DMA RAM should be available using conventional
> means __get_dma_pages(GFP_KERNEL, 0x100) soon after boot.

The problem is that he needs to get this memory from the last MB only,
__get_dma_pages would return pages from ZONE_DMA but this is usually
at the beginning of RAM.

> Or just use mem= on the boot command line. This will tell
> the kernel the extent of memory to use. Any RAM after that
> is available. Your driver can access kernel variable, "num_physpages"
> to find the last page it is supposed to use.

But this means that you would need to modify all the drivers that need
DMA memory. Modifying the zones is actually transparent for the
drivers.

--
Catalin

