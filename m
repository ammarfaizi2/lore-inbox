Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTEORM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTEORM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:12:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47798 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264147AbTEORMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:12:44 -0400
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20030515065120.GA3469@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com>
	 <20030515065120.GA3469@Wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 May 2003 10:20:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 23:51, Andi Kleen wrote:
> On Wed, May 14, 2003 at 07:37:09PM -0700, john stultz wrote:
> > All,
> > 	This patch fixes a circular dependency (a function in mach_apic.h
> > requires hard_smp_processor_id() and hard_smp_processor_id() requires
> > macros from mach_apic.h) that has been in the subarch code for a bit,
> > but was hacked around with some #ifdefs. 
> > 
> > With the inclusion of the generic-subarch the hack was dropped and
> > bigsmp and summit promptly broke. So this makes things compile again. 
> 
> What broke exactly? I thought worked around this problem for the generic
> subarchitecture.


GET_APIC_ID was moved into mach_apic.h (it used to be wrapped in
CONFIG_X86_SUMMIT in apicdef.h). However, init_apic_ldr()  in
mach_apic.h uses hard_smp_processor_id() (in smp.h), which to complete
the circle, requires GET_APIC_ID from mach_apic.h

You did get around it in the generic subarch (which I love, by the way,
thanks so much for doing that work), but in a roundabout way. (via
#ifdef APIC_DEFINITION trickery). 


> Accessing the APIC directly this way just to work around a bad include
> looks quite ugly to me.

Yea, ok. I guess we can move GET_APIC_ID out into its own mach specific
.h file. That will eliminate the circularity as well. I'll respin the
patch later today.

thanks
-john


