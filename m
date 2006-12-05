Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967528AbWLEFpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967528AbWLEFpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967540AbWLEFpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:45:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57684 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967528AbWLEFpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:45:32 -0500
Date: Mon, 4 Dec 2006 21:45:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add an iterator index in struct pagevec
Message-Id: <20061204214519.2260855d.akpm@osdl.org>
In-Reply-To: <000101c7182d$3a0b6a10$ba88030a@amr.corp.intel.com>
References: <000101c7182d$3a0b6a10$ba88030a@amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 21:21:31 -0800
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> pagevec is never expected to be more than PAGEVEC_SIZE, I think a
> unsigned char is enough to count them.  This patch makes nr, cold
> to be unsigned char

Is that on the right side of the speed/space tradeoff?

> and also adds an iterator index. With that,
> the size can be even bumped up by 1 to 15.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> 
> diff -Nurp linux-2.6.19/include/linux/pagevec.h linux-2.6.19.ken/include/linux/pagevec.h
> --- linux-2.6.19/include/linux/pagevec.h	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19.ken/include/linux/pagevec.h	2006-12-04 19:18:21.000000000 -0800
> @@ -8,15 +8,16 @@
>  #ifndef _LINUX_PAGEVEC_H
>  #define _LINUX_PAGEVEC_H
>  
> -/* 14 pointers + two long's align the pagevec structure to a power of two */
> -#define PAGEVEC_SIZE	14
> +/* 15 pointers + 3 char's align the pagevec structure to a power of two */
> +#define PAGEVEC_SIZE	15
>  
>  struct page;
>  struct address_space;
>  
>  struct pagevec {
> -	unsigned long nr;
> -	unsigned long cold;
> +	unsigned char nr;
> +	unsigned char cold;
> +	unsigned char idx;
>  	struct page *pages[PAGEVEC_SIZE];
>  };
>  

I'd have thought that pagevec_init() would want to be involved in this, no?

I must say I'm a bit skeptical about the need for this.  But I haven't
looked closely at the blockdev-specific dio code yet.

