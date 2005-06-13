Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVFMJ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFMJ2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVFMJ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:28:51 -0400
Received: from gate.corvil.net ([213.94.219.177]:55047 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261445AbVFMJ2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:28:49 -0400
Message-ID: <42AD51C8.4000703@draigBrady.com>
Date: Mon, 13 Jun 2005 10:28:40 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Remy_B=F6hmer?= <remy.bohmer@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bigphysarea for 2.6.10 en 2.6.11
References: <a7fe805f05061113426c86ba92@mail.gmail.com>
In-Reply-To: <a7fe805f05061113426c86ba92@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remy Böhmer wrote:
> I have pulled the bigphysarea patch (as posted by Nick Martin for
> kernel 2.6.9) towards the kernels 2.6.10 and 2.6.11.
> Maybe there is somebody out there who can use it.
> 
> (it only suits the i386 kernel, I have not done this job for other platforms.)
> First the 2.6.10 version is listed below, after this the 2.6.11 version
> 
> Have fun with it!
> 
> Remy
> 
> linux-2.6.10.bigphys/mm/bigphysarea.c
> --- linux-2.6.10.orig/mm/bigphysarea.c   Wed Dec 31 19:00:00 1969
> +++ linux-2.6.10.bigphys/mm/bigphysarea.c        Mon Nov 15 15:49:01 2004
> +static
> +int __init bigphysarea_setup(char *str)
> +{
> +       int par;
> +       if (get_option(&str,&par)) {
> +               bigphysarea_pages = par;
> +               // Alloc the memory
> +               bigphysarea =
> alloc_bootmem_low_pages(bigphysarea_pages<<PAGE_SHIFT);
> +               if (!bigphysarea) {
> +                       printk(KERN_CRIT "bigphysarea: not enough
> memory for %d pages\n",bigphysarea_pages);
> +                       return -ENOMEM;
> +               }
> +
> +               // register the resource for it
> +               mem_resource.start = bigphysarea;

That should be:   mem_resource.start = virt_to_phys(bigphysarea);
Otherwise you could get a collision?

-- 
Pádraig Brady - http://www.pixelbeat.org
--
