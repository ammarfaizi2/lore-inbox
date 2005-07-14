Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVGNW44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVGNW44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGNWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:54:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263164AbVGNWxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:53:43 -0400
Date: Thu, 14 Jul 2005 15:52:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, radsaq@gmail.com,
       rajesh.shah@intel.com
Subject: Re: [PATCH] Fix the recent C-state with FADT regression
Message-Id: <20050714155251.41f50a1f.akpm@osdl.org>
In-Reply-To: <20050714093025.A1694@unix-os.sc.intel.com>
References: <20050714093025.A1694@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
> 
> 
> Attached patch fixes the recent C-state based on FADT regression reported by
> Kevin.
> 
> Please apply.
> 
> Thanks,
> Venki
> 
> 
> Fix the regression with c1_default_handler on some systems where C-states come
> from FADT.
> 
> Thanks to Kevin Radloff for identifying the issue and also root causing on 
> exact line of code that is causing the issue.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> diff -purN  linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c.org linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c
> --- linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c.org	2005-07-14 23:19:45.038854688 -0700
> +++ linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c	2005-07-14 23:21:47.292269344 -0700
> @@ -881,7 +881,7 @@ static int acpi_processor_get_power_info
>  	result = acpi_processor_get_power_info_cst(pr);
>  	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
>  		result = acpi_processor_get_power_info_fadt(pr);
> -		if (result)
> +		if ((result) || (acpi_processor_power_verify(pr) < 2))
>  			result = acpi_processor_get_power_info_default_c1(pr);
>  	}
>

It turns out I've had this in my tree since July 6 (from Jindrich
Makovicka), sent to Len on July 9.  Maybe he's merged it somewhere already.

I have seven acpi patches here, some of which have been in -mm for a very
long time.  I'll resend them all.  Could someone please promptly ack them for
2.6.13 or merge them somewhere or nack the things?

Thanks.
