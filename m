Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWGAVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWGAVHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWGAVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:07:39 -0400
Received: from xenotime.net ([66.160.160.81]:51652 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751927AbWGAVHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:07:38 -0400
Date: Sat, 1 Jul 2006 14:10:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: SMBus access
Message-Id: <20060701141015.a4922e86.rdunlap@xenotime.net>
In-Reply-To: <m2irmhjb5t.fsf@phoenix.squirrel.nl>
References: <m2irmhjb5t.fsf@phoenix.squirrel.nl>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 22:57:34 +0200 Johan Vromans wrote:

> To get battery readings on some laptops it is necessary to interface
> with the SMBus that hangs of the EC. However, the current
> implementation of the EC driver does not permit other modules 
> read/write access. 
> 
> A trivial solution is to change acpi_ec_read/write from static to
> nonstatic, and export the symbols so other modules can use them.
> 
> Would there be any objections to apply this change?

a.  patch should also be sent to linux-acpi@vger.kernel.org (cc-ed)
b.  patch does not apply cleanly to latest kernel
c.  missing Signed-off-by: line (see Documentation/SubmittingPatches)
d.  incorrect patch filename directory level (see SubmittingPatches)



> -- Johan
> 
> --- drivers/acpi/ec.c~	2006-04-17 13:40:49.000000000 +0200
> +++ drivers/acpi/ec.c	2006-04-22 17:49:13.000000000 +0200
> @@ -305,20 +305,22 @@
>  }
>  #endif /* ACPI_FUTURE_USAGE */
>  
> -static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
> +int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
>  {
>  	if (acpi_ec_poll_mode)
>  		return acpi_ec_poll_read(ec, address, data);
>  	else
>  		return acpi_ec_intr_read(ec, address, data);
>  }
> -static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
> +EXPORT_SYMBOL(acpi_ec_read);
> +int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
>  {
>  	if (acpi_ec_poll_mode)
>  		return acpi_ec_poll_write(ec, address, data);
>  	else
>  		return acpi_ec_intr_write(ec, address, data);
>  }
> +EXPORT_SYMBOL(acpi_ec_write);
>  static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
>  {
>  	acpi_status status = AE_OK;
> -


---
~Randy
