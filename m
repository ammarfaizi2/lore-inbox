Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFBUsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFBUs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:48:29 -0400
Received: from fmr06.intel.com ([134.134.136.7]:57083 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262470AbTFBUsU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:48:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Date: Mon, 2 Jun 2003 14:01:42 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2CC@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Thread-Index: AcMoEIJjdxWWC1qYTCiCZufIZAy5ggBOQ/9g
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Con Kolivas" <kernel@kolivas.org>
Cc: "Paul P Komkoff Jr" <i@stingr.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Jun 2003 21:01:42.0367 (UTC) FILETIME=[2B15BEF0:01C3294A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect this machine should be falling into one of the cases before
this last one, thus making ACPI not use C3, or check for bus-mastering.
I especially think this is the case because this appears to be a desktop
system. It should not have a C3 address or a plvl3_lat less than 1000,
yet it appears to, yes?

Regards -- Andy

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca] 
> Sent: Sunday, June 01, 2003 12:23 AM
> To: Con Kolivas
> Cc: Paul P Komkoff Jr; linux-kernel@vger.kernel.org
> Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
> Importance: High
> 
> 
> On Sun, 1 Jun 2003, Con Kolivas wrote:
> 
> > I get the same problem here with acpi-20030522 applied to rc6
> > P4 2.53 on an i845 mobo (P4PE).
> 
> I think it could be the Bus Mastering event monitoring thing, can you 
> shoehorn this (HACK HACK) patch into 2.4?
> 
> Index: linux-2.5.70-mm1/drivers/acpi/processor.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.70/drivers/acpi/processor.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 processor.c
> --- linux-2.5.70-mm1/drivers/acpi/processor.c	27 May 2003 
> 02:19:28 -0000	1.1.1.1
> +++ linux-2.5.70-mm1/drivers/acpi/processor.c	29 May 2003 
> 11:32:00 -0000
> @@ -711,11 +711,13 @@ acpi_processor_get_power_info (
>  		 * use this in our C3 policy.
>  		 */
>  		else {
> +			goto done;
>  			pr->power.states[ACPI_STATE_C3].valid = 1;
>  			pr->power.states[ACPI_STATE_C3].latency_ticks = 
>  				
> US_TO_PM_TIMER_TICKS(acpi_fadt.plvl3_lat);
>  			pr->flags.bm_check = 1;
>  		}
> +		done:
>  	}
>  
>  	/*
> -- 
> function.linuxpower.ca
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
