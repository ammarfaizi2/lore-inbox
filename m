Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVDFJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVDFJui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 05:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVDFJuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 05:50:35 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:11714 "EHLO
	laptop.blackstar.nl") by vger.kernel.org with ESMTP id S262153AbVDFJua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 05:50:30 -0400
Subject: NOMMU - How to reserve 1 MB in top of memory in a clean way
From: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1112781027.2687.6.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Apr 2005 11:50:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I am currently working on the bfinnommu linux port for the BlackFin 533.
I need to grab the top 1 MB of memory so I can give it out to drivers
that need non-cached memory for DMA operations.

I've tried the following approaches (which each failed, in different
ways):

1. Allocate 1 MB in ZONE_DMA. This doesn't work because ZONE_DMA needs
to be in the bottom of memory (and I couldn't find a way around that),
and needs to be a minimum of 4 MB.
2. Create ZONE_NORMAL with all memory in it, but add a hole of 1 MB.
This crashes in the swapper somewhere.

What I want is a way to cleanly grab all pages in the top megabyte of
memory, so I can give them out in an implementation (to be written) of
dma_alloc_coherent and friends. That top megabyte would be set to
non-cached in the software cache manager.

If anyone can point me in the right direction, that would be great.

Regards,

Bas Vermeulen

