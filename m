Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTBTUM5>; Thu, 20 Feb 2003 15:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBTUM5>; Thu, 20 Feb 2003 15:12:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:31898 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266926AbTBTUMj>;
	Thu, 20 Feb 2003 15:12:39 -0500
Date: Thu, 20 Feb 2003 12:20:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c
 with flush_tlb_all()
Message-Id: <20030220122017.027c023b.akpm@digeo.com>
In-Reply-To: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de>
References: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 20:22:39.0063 (UTC) FILETIME=[D03B6E70:01C2D91D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> This patch replaces the flush_map() function in the arch/i386/mm/pageattr.c
> file with flush_tlb_all() calls, as the flush_map() function wants to do
> the same, but just forgot the preempt_disable() and preempt_enable() calls.
> 

flush_map() is doing a wbinvd:

> -static void flush_kernel_map(void *dummy) 
> -{ 
> -	/* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
> -	if (boot_cpu_data.x86_model >= 4) 
> -		asm volatile("wbinvd":::"memory"); 

It appears that by replacing flush_map() with flush_tlb_all(), you are no
longer doing this?

