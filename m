Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWGMSSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWGMSSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWGMSSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:18:09 -0400
Received: from [198.99.130.12] ([198.99.130.12]:64166 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030268AbWGMSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:18:08 -0400
Date: Thu, 13 Jul 2006 14:17:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5] UML - Fix ZONE_HIGHMEM compilation error
Message-ID: <20060713181754.GA5343@ccure.user-mode-linux.org>
References: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org> <20060713012421.b59f05d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713012421.b59f05d4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 01:24:21AM -0700, Andrew Morton wrote:
> >  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
> 
> I spy an ARRAY_SIZE().

Yup, I did an ARRAY_SIZE pass a while ago, but I missed that somehow,
and some grepping shows there are a bunch more.

> Maybe this is an rc1-mm1 fix?  Did Christoph's patches break UML, perhaps??

Yes, it's this bit in mmzone.h:
    #ifdef CONFIG_HIGHMEM
	/*
	 * A memory area that is only addressable by the kernel through
	 * mapping portions into its own address space. This is for example
	 * used by i386 to allow the kernel to address the memory beyond
	 * 900MB. The kernel will set up special mappings (page
	 * table entries on i386) for each page that the kernel needs to
	 * access.
	 */
	ZONE_HIGHMEM,
    #endif

				Jeff
