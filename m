Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTEFPDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTEFPDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:03:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36038 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263782AbTEFPDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:03:10 -0400
Date: Tue, 06 May 2003 08:15:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Keith Mannthey <kmannth@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, James Cleverdon <cleverdj@us.ibm.com>
Subject: Re: [RFC][PATCH] fix for clusterd io_apics
Message-ID: <13960000.1052234101@[10.10.2.4]>
In-Reply-To: <1052179450.16886.224.camel@dyn9-47-17-180.beaverton.ibm.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com><20030430163637.04f06ba6.akpm@digeo.com><1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com> <20030430192205.13491d61.akpm@digeo.com> <1052179450.16886.224.camel@dyn9-47-17-180.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The following is a patch to fix inconsistent use of the function
> set_ioapic_affinity. In the current kernel it is unclear as to weather
> the value being passed to the function is a cpu mask or valid apic id. 
> In irq_affinity_write_proc the kernel passes on a cpu mask but the kirqd
> thread passes on logical apic ids.  In flat apic mode this is not an
> issue because a cpu mask represents the apic value.  However in
> clustered apic mode the cpu mask is very different from the logical apic
> id.  
>   This is an attempt to do the right thing for clustered apics.  I
> clarify that the value being passed to set_ioapic_affinity is a cpu mask
> not a apicid.  Set_ioapic_affinity will do the conversion to logical
> apic ids.  Since many cpu masks don't map to valid apicids in clustered
> apic mode TARGET_CPUS is used as a default value when such a situation
> occurs.  I think this is a good step in making irq_affinity clustered
> apic safe.

Thanks Keith, looks great. The existing code in the main kernel is just
broken (and confusing as hell with it's mixed use of "mask").

M.

