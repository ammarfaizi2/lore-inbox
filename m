Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTIHEJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIHEJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 00:09:25 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:36310 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261899AbTIHEJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 00:09:23 -0400
Date: Sun, 07 Sep 2003 21:06:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
cc: Patricia Gaughen <gone@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix Summit srat.h includes
Message-ID: <177650000.1062993966@[10.10.2.4]>
In-Reply-To: <1062959739.27214.2174.camel@nighthawk>
References: <1062959739.27214.2174.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was compiling for my plain 'ol PC, and was getting unresolved symbols
> for get_memcfg_from_srat() and get_zholes_size().  The CONFIG_NUMA
> definition right now allows it to be turned on for plain old X86_PC. 
> Does anyone know why this is?  

Yeah, distros want it, so they can ship one kernel for SMP that covers
NUMA and non-NUMA, switching dynamically.
 
> depends on SMP && HIGHMEM64G && 
>           (X86_PC || X86_NUMAQ || X86_GENERICARCH || 
>                   (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
> 
> In any case, the summit code incorrectly assumes in at least 2 places
> that NUMA && !NUMAQ means summit.  Someone was evidently trying to cover
> the generic subarch case, but that's already taken care of by the lovely
> config system and CONFIG_ACPI_SRAT.  This patch fixes those assumptions
> and adds a nice little warning for people that try to #include srat.h
> without having srat support turned on.  

Nice, thanks. Yeah, the generic NUMA on generic PC code will need a bit
of tidy up, but it should more or less work ;-)

Thanks,

M.

