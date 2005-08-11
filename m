Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVHKFkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVHKFkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVHKFkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:40:07 -0400
Received: from fsmlabs.com ([168.103.115.128]:28881 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750877AbVHKFkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:40:05 -0400
Date: Wed, 10 Aug 2005 23:45:56 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: zach@vmware.com
cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
In-Reply-To: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
Message-ID: <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com>
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005 zach@vmware.com wrote:

> Add an accessor function for getting the per-CPU gdt.  Callee must already
> have the CPU.

This one seems superfluous to me, does accessing it indirectly generate 
better code too?

> Patch-base: 2.6.13-rc5-mm1
> Patch-keys: i386 desc xen
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/include/asm-i386/desc.h
> ===================================================================
> --- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 20:17:21.000000000 -0700
> +++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:41:03.000000000 -0700
> @@ -39,6 +39,8 @@
>  extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
>  DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
>  
> +#define get_cpu_gdt_table(_cpu) (per_cpu(cpu_gdt_table, _cpu))
> +
>  DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
