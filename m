Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUFXXgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUFXXgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUFXXgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:36:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28663 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265841AbUFXXfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:35:18 -0400
Date: Thu, 24 Jun 2004 16:33:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add required dependencies to X86_NUMAQ
Message-ID: <3450000.1088120038@flay>
In-Reply-To: <20040624231033.GF26669@fs.tum.de>
References: <20040624231033.GF26669@fs.tum.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you select another option, you have to ensure that the dependencies 
> of the selected options are met.
> 
> The following patch adds to X86_NUMAQ the required dependencies for the 
> selected NUMA:
> 
> --- linux-2.6.7-mm2-full/arch/i386/Kconfig.old	2004-06-24 22:42:32.000000000 +0200
> +++ linux-2.6.7-mm2-full/arch/i386/Kconfig	2004-06-24 22:44:53.000000000 +0200
> @@ -65,6 +65,7 @@
>  
>  config X86_NUMAQ
>  	bool "NUMAQ (IBM/Sequent)"
> +	depends on SMP && HIGHMEM64G
>  	select DISCONTIGMEM
>  	select NUMA
>  	help

Mmmm. As we already have this:

config NUMA
        bool "Numa Memory Allocation and Scheduler Support"
        depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SU
MMIT && ACPI))
        default n if X86_PC
        default y if (X86_NUMAQ || X86_SUMMIT)

do we really need to cascade it back out like that into everything that
selects NUMA? Perhaps we should make NUMA select SMP && HIGHMEM64G, rather
than depend on it?

M.

