Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162078AbWKOXpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162078AbWKOXpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162077AbWKOXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:45:17 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:58782 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162075AbWKOXpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:45:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1Kk2hVh0t2f8+J1yJiiMplnaemsMg5dgeexCTXDIEqRYFXq59Ghd5xhF81XSsJctz/tHlr4gThbgluorsgU5Y+AIHHO0AbP2aNP5Ts76RfLhGDM5ZEe2x51cdis19dQKumZDtImfvLWh8lTEo/i3se7/7VCBrbV0gSpHvu2VEuw=  ;
X-YMail-OSG: fNiVXt0VM1lICk0O_iuNo0bZdVKtomN.eYLO9_A8WIDjmzHMfB5XYP0eLWRicm9OU1.DUJyRxwIGxPFOeS.N7tCTOaia.dRdQQHX0cLcNvUK34Zj98hDXg--
From: David Brownell <david-b@pacbell.net>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 13:56:52 -0800
User-Agent: KMail/1.7.1
Cc: Len Brown <lenb@kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com> <455B28B2.4010707@linux.intel.com>
In-Reply-To: <455B28B2.4010707@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611151356.52985.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
> ec1.patch
> 
> 
> Always enable GPE after return from notify handler.
> 
> From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> 
> 
> ---

Yes, this seems to resolve the regression as well as Len's ec_intr=0 boot param.

IMO this should get merged into 2.6.19 ASAP ...


>  drivers/acpi/ec.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e6d4b08..937eafc 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
>  
>         if (value & ACPI_EC_FLAG_SCI) {
>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> -               return status == AE_OK ?
> -                   ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>         }
>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
>         return status == AE_OK ?
