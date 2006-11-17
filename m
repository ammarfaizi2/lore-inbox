Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162403AbWKQGWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162403AbWKQGWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162402AbWKQGWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:22:49 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:53086 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162403AbWKQGWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:22:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=ehfjlrZQkWeN/CFQ4tYAfTa2tVx0nDcuP0VKr4hgy65vpTSIOdBQXvf/M1iKvoLs9Qt/b4T0gh9Dcceust7fs6A3uf1vx5/MlcfZsTRCKeGtoc7t70RJxLkb2liL3BdmEUGUql5qa6tWWYaWSO88Y6MCI/bURkzRiTN4Vuu0Fgk=  ;
X-YMail-OSG: 9jlG4XUVM1l7trQq_fg6CD70eDpVPKlbFqU7GlbOp1.VJUkh9XVk2ufa9yoxoIVuLQiJ.GRgpQdi4AObzqLqYA4D0T5eNO3QTE_ptiRZ54WRBkrmmJr9
From: David Brownell <david-b@pacbell.net>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Thu, 16 Nov 2006 22:22:43 -0800
User-Agent: KMail/1.7.1
Cc: Len Brown <lenb@kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net> <200611151710.26570.david-b@pacbell.net> <455C8696.80508@linux.intel.com>
In-Reply-To: <455C8696.80508@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611162222.44836.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -467,8 +467,8 @@ static u32 acpi_ec_gpe_handler(void *dat
>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
>         }
>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> -       return status == AE_OK ?
> -           ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> +       WARN_ON(ACPI_FAILURE(status));
> +       return ACPI_INTERRUPT_HANDLED;
>  }
>  

Strange ... applying this on top of the previous patch seems to work
much better, but that WARN_ON hasn't triggered.  At least, not yet.
Updating to RC6, with your two patches installed...

- Dave
