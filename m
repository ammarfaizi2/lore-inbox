Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVAHATp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVAHATp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVAHATR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:19:17 -0500
Received: from mail.tyan.com ([66.122.195.4]:6151 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261762AbVAHARP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:17:15 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291358@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: jamesclv@us.ibm.com
Cc: Andi Kleen <ak@muc.de>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 16:28:49 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then sepertate that into init_amd and init_intel.

YH

-----Original Message-----
From: James Cleverdon [mailto:jamesclv@us.ibm.com] 
Sent: Friday, January 07, 2005 4:13 PM
To: YhLu
Cc: Andi Kleen; Matt Domsch; linux-kernel@vger.kernel.org;
discuss@x86-64.org; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

Clustered APIC systems need the phys_proc_id to come from the APIC ID 
register.  Intel prefers that non-clustered systems get their 
phys_proc_id from the cpuid opcode.

So, using c->x86_apicid is unlikely to satisfy both parties.


On Friday 07 January 2005 04:04 pm, YhLu wrote:
> arch/x86_64/kernel/setup.c
>
> static void __init detect_ht(struct cpuinfo_x86 *c)
>
>                 phys_proc_id[cpu] = phys_pkg_id(index_msb);
>
> --->
> 			  Phy_proc_id[cpu] = cpu_to_node[cpu];
> Or
>    	      // that is initial apicid
>           phys_proc_id[cpu] = c->x86_apicid >>
> hweight32(c->x86_num_cores - 1);
>
> YH
>
> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de]
> Sent: Friday, January 07, 2005 2:18 PM
> To: YhLu
> Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
> jamesclv@us.ibm.com; suresh.b.siddha@intel.com
> Subject: Re: 256 apic id for amd64
>
> On Fri, Jan 07, 2005 at 01:44:19PM -0800, YhLu wrote:
> > Can you consider to use c->x86_apicid to get phy_proc_id, that is
> > initial apicid.?
>
> Where?
>
> -Andi

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
