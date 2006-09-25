Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWIYGZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWIYGZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWIYGZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:25:35 -0400
Received: from gw.goop.org ([64.81.55.164]:4771 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751298AbWIYGZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:25:34 -0400
Message-ID: <45177664.3060103@goop.org>
Date: Sun, 24 Sep 2006 23:25:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain>	 <1158925997.26261.6.camel@localhost.localdomain>	 <1158926106.26261.8.camel@localhost.localdomain>	 <1158926215.26261.11.camel@localhost.localdomain>	 <1158926308.26261.14.camel@localhost.localdomain>	 <1158926386.26261.17.camel@localhost.localdomain>	 <4514663E.5050707@goop.org>	 <1158985882.26261.60.camel@localhost.localdomain>	 <45172AC8.2070701@goop.org>	 <1159146974.26986.30.camel@localhost.localdomain>	 <45173287.8070204@goop.org>	 <1159152678.26986.38.camel@localhost.localdomain>	 <45176865.7020300@goop.org> <1159164232.26986.59.camel@localhost.localdomain>
In-Reply-To: <1159164232.26986.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I don't think so.  There's *never* address subtraction, there's
> sometimes 32 bit wrap (glibc uses this to effect subtraction, sure).
> But there's no wrap here.
>   
Hm, I guess, so long as you assume the kernel data segment is always 
below the kernel heap.

> To test, I changed the following:
>
> --- smpboot.c.~8~	2006-09-25 15:51:50.000000000 +1000
> +++ smpboot.c	2006-09-25 16:00:36.000000000 +1000
> @@ -926,8 +926,9 @@
>  					      unsigned long per_cpu_off)
>  {
>  	unsigned limit, flags;
> +	extern char __per_cpu_end[];
>  
> -	limit = (1 << 20);
> +	limit = PAGE_ALIGN((long)__per_cpu_end) >> PAGE_SHIFT;
>   
limit is a size, rather than the end address, so this isn't quite right.

    J
