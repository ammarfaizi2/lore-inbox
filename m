Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFCHHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFCHHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFCHHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:07:30 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:27047 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261168AbVFCHHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:07:13 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Parag Warudkar <kernel-stuff@comcast.net>
Date: Fri, 03 Jun 2005 09:05:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Message-ID: <42A01D40.12033.25D284@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <200506021950.35014.kernel-stuff@comcast.net>
References: <1117754453.17804.51.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103671@20050603.065415Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Possibly the code could auto-detect the brokenness during initialization by 
executing inl(pmtmr_ioport) a few hundred times and watch for monotony.

Regards,
Ulrich


On 2 Jun 2005 at 19:50, Parag Warudkar wrote:

> On Thursday 02 June 2005 19:20, john stultz wrote:
> > Could you see if the slowness you're feeling is correlated to the
> > acpi_pm timesource?
> 
> Speaking of which, the below code from arch/i386/timer_pm.c looks particularly 
> more taxing to me - 3 times read from ioport in a loop - not sure how many 
> time that executes. 
> 
> static inline u32 read_pmtmr(void)
> {
>         u32 v1=0,v2=0,v3=0;
>         /* It has been reported that because of various broken
>          * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
>          * source is not latched, so you must read it multiple
>          * times to insure a safe value is read.
>          */
>         do {
>                 v1 = inl(pmtmr_ioport);
>                 v2 = inl(pmtmr_ioport);
>                 v3 = inl(pmtmr_ioport);
>         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
>                         || (v3 > v1 && v3 < v2));
> 
> Shouldn't that loop be limited to the broken chipsets - why would correct 
> people with correctly working chipsets carry this extra burden? (Or is it 
> insignificant?)
> 
> -- 
> Because we don't think about future generations, they will never forget us.
> 		-- Henrik Tikkanen


