Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTBKWFN>; Tue, 11 Feb 2003 17:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBKWFN>; Tue, 11 Feb 2003 17:05:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266564AbTBKWFL>;
	Tue, 11 Feb 2003 17:05:11 -0500
Subject: Re: [PATCH] 2/3 ACPI resource handling
From: Stephen Hemminger <shemminger@osdl.org>
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, t-kochi@bq.jp.nec.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <200302111459.35380.bjorn_helgaas@hp.com>
References: <200302111459.35380.bjorn_helgaas@hp.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045001693.17351.62.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Feb 2003 14:14:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 13:59, Bjorn Helgaas wrote:
> Note that this contains a couple structure copies; don't know your
> philosophy on those.
> 
> Bjorn
> 
> 
> diff -ur acpi-2/drivers/acpi/resources/rsxface.c acpi-3/drivers/acpi/resources/rsxface.c
> --- acpi-2/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:47.000000000 -0700
> +++ acpi-3/drivers/acpi/resources/rsxface.c	2003-02-09 22:13:52.000000000 -0700
> @@ -316,3 +316,65 @@
>  	status = acpi_rs_set_srs_method_data (device_handle, in_buffer);
>  	return_ACPI_STATUS (status);
>  }
> +
> +
> +#define copy_field(out, in, field)	out->field = in->field
> +#define copy_address(out, in)					\
> +	copy_field(out, in, resource_type);			\
> +	copy_field(out, in, producer_consumer);			\
> +	copy_field(out, in, decode);				\
> +	copy_field(out, in, min_address_fixed);			\
> +	copy_field(out, in, max_address_fixed);			\
> +	copy_field(out, in, attribute);				\
> +	copy_field(out, in, granularity);			\
> +	copy_field(out, in, min_address_range);			\
> +	copy_field(out, in, max_address_range);			\
> +	copy_field(out, in, address_translation_offset);	\
> +	copy_field(out, in, address_length);			\
> +	copy_field(out, in, resource_source);

If ACPI just used normal (ie short) variable names, then ugly macros
like this would not be necessary.


