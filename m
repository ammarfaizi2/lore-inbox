Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTFBX5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 19:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTFBX5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 19:57:37 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9601 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264223AbTFBX5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 19:57:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Grover, Andrew" <andrew.grover@intel.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Date: Tue, 3 Jun 2003 10:12:07 +1000
User-Agent: KMail/1.5.1
Cc: "Paul P Komkoff Jr" <i@stingr.net>, <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A84725A2CC@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2CC@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031012.07832.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 07:01, Grover, Andrew wrote:
> I suspect this machine should be falling into one of the cases before
> this last one, thus making ACPI not use C3, or check for bus-mastering.
> I especially think this is the case because this appears to be a desktop
> system. It should not have a C3 address or a plvl3_lat less than 1000,
> yet it appears to, yes?

Sorry Andy I have no idea what you're talking about. Are there some details 
specifically about this machine you want me to provide?

Con
> > -----Original Message-----
> > From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> > On Sun, 1 Jun 2003, Con Kolivas wrote:
> > > I get the same problem here with acpi-20030522 applied to rc6
> > > P4 2.53 on an i845 mobo (P4PE).
> >
> > I think it could be the Bus Mastering event monitoring thing, can you
> > shoehorn this (HACK HACK) patch into 2.4?
> >
> > Index: linux-2.5.70-mm1/drivers/acpi/processor.c
> > ===================================================================
> > RCS file: /build/cvsroot/linux-2.5.70/drivers/acpi/processor.c,v
> > retrieving revision 1.1.1.1
> > diff -u -p -B -r1.1.1.1 processor.c
> > --- linux-2.5.70-mm1/drivers/acpi/processor.c	27 May 2003
> > 02:19:28 -0000	1.1.1.1
> > +++ linux-2.5.70-mm1/drivers/acpi/processor.c	29 May 2003
> > 11:32:00 -0000
> > @@ -711,11 +711,13 @@ acpi_processor_get_power_info (
> >  		 * use this in our C3 policy.
> >  		 */
> >  		else {
> > +			goto done;
> >  			pr->power.states[ACPI_STATE_C3].valid = 1;
> >  			pr->power.states[ACPI_STATE_C3].latency_ticks =
> >
> > US_TO_PM_TIMER_TICKS(acpi_fadt.plvl3_lat);
> >  			pr->flags.bm_check = 1;
> >  		}
> > +		done:
> >  	}
> >
> >  	/*

