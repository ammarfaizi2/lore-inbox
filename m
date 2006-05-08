Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWEHT0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWEHT0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWEHT0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:26:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:57483 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751293AbWEHT0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:26:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tlCVTc+d2yFRli7Qe45nZKk3WiR2a1Psmy9K/OWov2enhQLyx4S9jRmtXDPSscTv0yDenexU4aVeT32G/ZYLDGdTSsFm2TGZY1Bz8+S8XqrnE36oY9D+z+SuBlOaWdhKTASMn61hpc68nI+kuTLZTSX8/VZBBbYuZ90ImcYzGcc=
Date: Mon, 8 May 2006 23:24:31 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com, greg@kroah.com
Subject: Re: [patch] fix pciehp compile issue when CONFIG_ACPI is not enabled.
Message-ID: <20060508192431.GB7235@mipter.zuzino.mipt.ru>
References: <1147114470.3094.14.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147114470.3094.14.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 11:54:30AM -0700, Kristen Accardi wrote:
> Fix compile error when CONFIG_ACPI is not defined.

> --- 2.6-git.orig/include/acpi/actypes.h
> +++ 2.6-git/include/acpi/actypes.h
> @@ -348,6 +348,7 @@ struct acpi_pointer {
>   * Mescellaneous types
>   */
>  typedef u32 acpi_status;	/* All ACPI Exceptions */
> +#define acpi_status acpi_status
>  typedef u32 acpi_name;		/* 4-byte ACPI name */
>  typedef char *acpi_string;	/* Null terminated ASCII string */
>  typedef void *acpi_handle;	/* Actually a ptr to a NS Node */

The following in include/linux/pci-acpi.h is ugly

	#if !defined(acpi_status)
	typedef u32             acpi_status;
	#define AE_ERROR        (acpi_status) (0x0001)
	#endif

but you're adding more of it.

