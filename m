Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWJJN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWJJN3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWJJN3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:29:44 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:18971 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1750735AbWJJN3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:29:44 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=EaKRm+4v+vBHA1FUa4P7hAti7cO+69lllIz1nEBe2JXu7u5GMcF6FYXCOMLfVG4bWYv/YvbCeiliy6HbSNYKxBDyOoXAPmyXc5Cc3y0mrelgbxpMz4w9ueWbtXdyoo/o;
X-IronPort-AV: i="4.09,289,1157346000"; 
   d="scan'208"; a="96594865:sNHT148316994"
Date: Tue, 10 Oct 2006 08:29:42 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware/efivars: handle error
Message-ID: <20061010132941.GA11810@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20061010131949.GA9064@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010131949.GA9064@havoc.gtf.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	On Tue, Oct 10, 2006 at 09:19:49AM -0400, Jeff Garzik wrote:
> 
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
>  drivers/firmware/efivars.c      |    7 ++++++-
> 
> diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
> index 8ebce1c..5ab5e39 100644
> --- a/drivers/firmware/efivars.c
> +++ b/drivers/firmware/efivars.c
> @@ -639,7 +639,12 @@ efivar_create_sysfs_entry(unsigned long 
>  
>  	kobject_set_name(&new_efivar->kobj, "%s", short_name);
>  	kobj_set_kset_s(new_efivar, vars_subsys);
> -	kobject_register(&new_efivar->kobj);
> +	i = kobject_register(&new_efivar->kobj);
> +	if (i) {
> +		kfree(short_name);
> +		kfree(new_efivar);
> +		return 1;
> +	}
>  
>  	kfree(short_name);
>  	short_name = NULL;


Acked-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks Jeff!

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
