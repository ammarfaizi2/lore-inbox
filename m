Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWFQW3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWFQW3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWFQW3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 18:29:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:64672 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751012AbWFQW3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 18:29:39 -0400
Subject: Re: [PATCH] powerpc: enable CPU_FTR_CI_LARGE_PAGE for cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200606171759.k5HHxkjG004420@hera.kernel.org>
References: <200606171759.k5HHxkjG004420@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 08:29:10 +1000
Message-Id: <1150583350.23600.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 17:59 +0000, Linux Kernel Mailing List wrote:
> commit ce221982e0bef039d7047b0f667bb414efece5af
> tree fa01b712522338d3f19ee5a6fedace7b7149c430
> parent 19242b240793ac769f5b91b68a5e43dd39f0c530
> author Arnd Bergmann <arnd.bergmann@de.ibm.com> Thu, 15 Jun 2006 15:09:16 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 18 Jun 2006 00:56:24 -0700
> 
> [PATCH] powerpc: enable CPU_FTR_CI_LARGE_PAGE for cell
> 
> Reflect the fact that the Cell Broadband Engine supports 64k
> pages by adding the bit to the CPU features.

Are you sure you want that in ? The SPU code upstream isn't ready for
64k pages yet... I spotted at least:

__spu_trap_data_seg() and get_kernel_slb()

Those need to encode the proper page size. I think you have patches for
that already. I wouldn't enable 64k pages with the abvoe without these
as you may end up with infinite hash fault loops due to the mismatch
between page size encoding in the hash table an in the SLB.

Ben.


