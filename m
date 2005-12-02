Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVLBLrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVLBLrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLBLrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:47:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:9107 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932737AbVLBLrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:47:10 -0500
Date: Fri, 2 Dec 2005 12:47:09 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [patch 3/3] x86_64: Node local PDA -- allocate node local memory for pda
Message-ID: <20051202114708.GM997@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202082309.GC5312@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:23:09AM -0800, Ravikiran G Thirumalai wrote:
> Patch uses a static PDA array early at boot and reallocates processor PDA
> with node local memory when kmalloc is ready, just before pda_init.
> The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init for
> that cpu is called (to set the static per-cpu areas offset table etc)

Where is it needed?  Perhaps it should be just allocated in the 
CPU triggering the other CPU start instead. Then you could avoid that
or rather only define a __initdata boot_pda for the BP.

> 
> Index: linux-2.6.15-rc3/arch/x86_64/kernel/head64.c
> ===================================================================
> --- linux-2.6.15-rc3.orig/arch/x86_64/kernel/head64.c	2005-11-30 17:01:18.000000000 -0800
> +++ linux-2.6.15-rc3/arch/x86_64/kernel/head64.c	2005-11-30 17:07:14.000000000 -0800
> @@ -80,6 +80,7 @@
>  {
>  	char *s;
>  	int i;
> +	extern struct x8664_pda boot_cpu_pda[];

externs only belong in include files.

-Andi
