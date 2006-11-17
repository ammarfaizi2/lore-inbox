Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424925AbWKQVcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424925AbWKQVcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424924AbWKQVcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:32:36 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:29117 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755928AbWKQVce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:32:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Sqxria32bwcZecqVNmzP72ybv6NB66d2m88cg+DzOBSosHefmjw9PLUixtkRHu13ghFoelahiS+Oy7sbp6HzqgpnuqZCcEx6Jxmz5x9cSHPnWPQVoCJXTQnidnZ4o9Z5AR+sL5zt8c/qzX+kAnDn3iMzRmsn9zIc6OahJZBopYU=  ;
From: David Brownell <david-b@pacbell.net>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Fri, 17 Nov 2006 13:04:00 -0800
User-Agent: KMail/1.7.1
Cc: Len Brown <lenb@kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <200611142303.47325.david-b@pacbell.net> <455C8696.80508@linux.intel.com> <200611162222.44836.david-b@pacbell.net>
In-Reply-To: <200611162222.44836.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611171304.00889.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 10:22 pm, David Brownell wrote:
> On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -467,8 +467,8 @@ static u32 acpi_ec_gpe_handler(void *dat
> >                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> >         }
> >         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> > -       return status == AE_OK ?
> > -           ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> > +       WARN_ON(ACPI_FAILURE(status));
> > +       return ACPI_INTERRUPT_HANDLED;
> >  }
> >  
> 
> Strange ... applying this on top of the previous patch seems to work
> much better, but that WARN_ON hasn't triggered.  At least, not yet.
> Updating to RC6, with your two patches installed...

ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
7]
ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
_TIME

OK, I don't get the WARN_ON when these happen, so it's got to be one of the
other EC updates.

It'd be nice if this were easily reproducible ...

- Dave

