Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTIQQsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTIQQsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:48:36 -0400
Received: from fmr04.intel.com ([143.183.121.6]:18901 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262593AbTIQQsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:48:33 -0400
Subject: Re: [BKPATCH] ACPI 20030916 for 2.4.23-pre4
From: Len Brown <len.brown@intel.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030917153542.GA22959@sgi.com>
References: <Pine.LNX.4.44.0309151824360.2914-100000@logos.cnet>
	 <1063759840.13038.23.camel@linux.local>  <20030917153542.GA22959@sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1063814257.2676.2.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Sep 2003 11:57:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jesse,
yes, this and your pci_irq.c fix are in the queue and should pop out in
linux-acpi-test-2.*.* shortly; hopefully making linux-acpi-release-2.*.*
by the end of the week.

-Len

On Wed, 2003-09-17 at 11:35, Jesse Barnes wrote:
> Can you please push this one as well?  Thanks.
> 
> Jesse
> 
> 
> diff -Nru a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> --- a/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
> +++ b/drivers/acpi/tables.c	Tue Sep  9 10:24:34 2003
> @@ -69,7 +69,8 @@
>  
>  static unsigned long		sdt_pa;		/* Physical Address */
>  static unsigned long		sdt_count;	/* Table count */
> -static struct acpi_table_sdt	*sdt_entry;
> +
> +static struct acpi_table_sdt	sdt_entry[ACPI_MAX_TABLES];
>  
>  void
>  acpi_table_print (
> @@ -425,12 +426,6 @@
>  			sdt_count = ACPI_MAX_TABLES;
>  		}
>  
> -		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
> -		if (!sdt_entry) {
> -			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
> -			return -ENOMEM;
> -		}
> -
>  		for (i = 0; i < sdt_count; i++)
>  			sdt_entry[i].pa = (unsigned long) mapped_xsdt->entry[i];
>  	}
> @@ -475,12 +470,6 @@
>  			printk(KERN_WARNING PREFIX "Truncated %lu RSDT entries\n",
>  				(sdt_count - ACPI_MAX_TABLES));
>  			sdt_count = ACPI_MAX_TABLES;
> -		}
> -
> -		sdt_entry = alloc_bootmem(sdt_count * sizeof(struct acpi_table_sdt));
> -		if (!sdt_entry) {
> -			printk(KERN_ERR "ACPI: Could not allocate mem for SDT entries!\n");
> -			return -ENOMEM;
>  		}
>  
>  		for (i = 0; i < sdt_count; i++)

