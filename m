Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUEKOkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUEKOkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEKOkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:40:19 -0400
Received: from lists.us.dell.com ([143.166.224.162]:30078 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264768AbUEKOiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:38:51 -0400
Date: Tue, 11 May 2004 09:38:33 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: gallir@atlas-iap.es, matthew.e.tolentino@intel.com,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] efivars: check enabled {2.6.6 doesn't boot with 4k stacks}
Message-ID: <20040511143833.GA14555@lists.us.dell.com>
References: <20040510172404.11a90ce9.rddunlap@osdl.org> <20040510210243.14bbd99b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510210243.14bbd99b.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 09:02:43PM -0700, Randy.Dunlap wrote:
> // linux-266
> // efivars_init and efivars_exit need to check efi_enabled
> // instead of assuming that the system is using EFI;

Good catch.  I missed the creation of that in the x86 EFI merge.

> +++ ./drivers/firmware/efivars.c	2004-05-10 20:45:55.000000000 -0700
> @@ -664,6 +664,9 @@ efivars_init(void)
>  	unsigned long variable_name_size = 1024;
>  	int i, rc = 0, error = 0;
>  
> +	if (!efi_enabled)
> +		return 0;

I would think this would be return -ENODEV; instead, yes?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
