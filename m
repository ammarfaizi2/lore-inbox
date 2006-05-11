Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWEKEpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWEKEpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 00:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWEKEpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 00:45:24 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56476 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965123AbWEKEpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 00:45:22 -0400
Date: Thu, 11 May 2006 13:46:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, vgoyal@in.ibm.com, greg@kroah.com,
       mm-commits@vger.kernel.org
Subject: Re: + kconfigurable-resources-arch-dependent-changes-arch-a-i.patch
 added to -mm tree
Message-Id: <20060511134656.03540092.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200605110400.k4B404Oh002720@shell0.pdx.osdl.net>
References: <200605110400.k4B404Oh002720@shell0.pdx.osdl.net>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 20:57:19 -0700
akpm@osdl.org wrote:

> diff -puN arch/i386/Kconfig~kconfigurable-resources-arch-dependent-changes-arch-a-i arch/i386/Kconfig
> --- devel/arch/i386/Kconfig~kconfigurable-resources-arch-dependent-changes-arch-a-i	2006-05-10 20:57:18.000000000 -0700
> +++ devel-akpm/arch/i386/Kconfig	2006-05-10 20:57:18.000000000 -0700
> @@ -754,6 +754,13 @@ config PHYSICAL_START
>  
>  	  Don't change this unless you know what you are doing.
>  
> +config RESOURCES_32BIT
> +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	help
> +	  By default resources are 64 bit. This option allows memory and IO
> +	  resources to be 32 bit to optimize code size.
> +

Could you modify
- depends on EXPERIMENTAL
- depends on EXPERIMENTAL && !X86_PAE ?

In legacy_init_iomem_resources()(/arch/i386/kernel/setup.c)

	res->start = e820.map[i].addr;
	res->end = res->start + e820.map[i].size - 1;

e820.map[i].addr is unsigned long long.

-Kame


