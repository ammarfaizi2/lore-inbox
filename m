Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWCTIzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWCTIzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWCTIzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:55:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38844 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932249AbWCTIzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:55:05 -0500
Date: Mon, 20 Mar 2006 09:54:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org, mactel-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060320085412.GA1772@elf.ucw.cz>
References: <20060319184325.GA7605@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319184325.GA7605@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-03-06 18:43:25, Matthew Garrett wrote:
> The EFI spec states that the data size of an EFI variable is 64 bits. 
> "unsigned long", on the other hand, isn't on IA32.
> 
> diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
> index bda5bce..488c24c 100644
> --- a/drivers/firmware/efivars.c
> +++ b/drivers/firmware/efivars.c
> @@ -110,7 +110,7 @@ static LIST_HEAD(efivar_list);
>  struct efi_variable {
>  	efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
>  	efi_guid_t    VendorGuid;
> -	unsigned long DataSize;
> +	__u64	      DataSize;
>  	__u8          Data[1024];
>  	efi_status_t  Status;
>  	__u32         Attributes;

Please, use u64 (not __u64).

									Pavel

-- 
86:        {
