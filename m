Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWH3X5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWH3X5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWH3X5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:57:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10165 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751190AbWH3X5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:57:22 -0400
Date: Wed, 30 Aug 2006 16:57:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 4/9] ia64 generic PAGE_SIZE
In-Reply-To: <20060830221607.1DB81421@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608301652270.5789@schroedinger.engr.sgi.com>
References: <20060830221604.E7320C0F@localhost.localdomain>
 <20060830221607.1DB81421@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Dave Hansen wrote:

> @@ -64,11 +64,11 @@
>   * Base-2 logarithm of number of pages to allocate per task structure
>   * (including register backing store and memory stack):
>   */
> -#if defined(CONFIG_IA64_PAGE_SIZE_4KB)
> +#if defined(CONFIG_PAGE_SIZE_4KB)
>  # define KERNEL_STACK_SIZE_ORDER		3
> -#elif defined(CONFIG_IA64_PAGE_SIZE_8KB)
> +#elif defined(CONFIG_PAGE_SIZE_8KB)
>  # define KERNEL_STACK_SIZE_ORDER		2
> -#elif defined(CONFIG_IA64_PAGE_SIZE_16KB)
> +#elif defined(CONFIG_PAGE_SIZE_16KB)
>  # define KERNEL_STACK_SIZE_ORDER		1
>  #else
>  # define KERNEL_STACK_SIZE_ORDER		0

Could we replace these lines with

#define KERNEL_STACK_SIZE_ORDER (max(0, 15 - PAGE_SHIFT)) 

?
