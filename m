Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWJWEpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWJWEpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJWEpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:45:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751485AbWJWEpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:45:10 -0400
Date: Sun, 22 Oct 2006 21:45:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix minor error about efi memory_present
Message-Id: <20061022214508.6c4f30c6.akpm@osdl.org>
In-Reply-To: <453C3A29.4010606@intel.com>
References: <453C3A29.4010606@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 11:42:33 +0800
"bibo,mao" <bibo.mao@intel.com> wrote:

> Hi, 
>    Function efi_memory_present_wrapper parameter start/end is physical address,
> but function memory_present parameter is PFN, this patch converts physical
> address to PFN.
> 
>   Signed-off-by: bibo, mao <bibo.mao@intel.com>
> 
> thanks
> bibo,mao
> 
> diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
> index 519e63c..141041d 100644
> --- a/arch/i386/kernel/setup.c
> +++ b/arch/i386/kernel/setup.c
> @@ -846,7 +846,7 @@ efi_find_max_pfn(unsigned long start, un
>  static int __init
>  efi_memory_present_wrapper(unsigned long start, unsigned long end, void *arg)
>  {
> -	memory_present(0, start, end);
> +	memory_present(0, PFN_UP(start), PFN_DOWN(end));
>  	return 0;
>  }
>  

It doesn't _seem_ like a "minor error".  How come people's machines haven't
been crashing all over the place?

