Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVHHOZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVHHOZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVHHOZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:25:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21389 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932078AbVHHOZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:25:44 -0400
Date: Mon, 8 Aug 2005 16:24:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 5/8 Move descriptor table management into the sub-arch layer
Message-ID: <20050808142424.GA1913@elf.ucw.cz>
References: <42F4643E.4030402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F4643E.4030402@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> i386 Transparent paravirtualization subarch patch #5
> 
> This change encapsulates descriptor and task register management.
> 
> Diffs against: 2.6.13-rc4-mm1
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/include/asm-i386/desc.h
> ===================================================================
> --- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-03 16:24:09.000000000 -0700
> +++ linux-2.6.13/include/asm-i386/desc.h	2005-08-03 16:31:40.000000000 -0700
> @@ -27,19 +27,6 @@
>  
>  extern struct Xgt_desc_struct idt_descr, cpu_gdt_descr[NR_CPUS];
>  
> -#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
> -#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))

Is not asm volatile (no underscores) enough?

> -#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
> -#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))

Eh, I think volatile should be either "volatile" or "__volatile__",
but you not "__volatile".

-- 
if you have sharp zaurus hardware you don't need... you know my address
