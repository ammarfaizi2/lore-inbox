Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVAHAaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVAHAaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVAHA3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:29:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32651 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261620AbVAHA1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:27:06 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: YhLu <YhLu@tyan.com>
Subject: Re: 256 apic id for amd64
Date: Fri, 7 Jan 2005 16:26:57 -0800
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@muc.de>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
References: <3174569B9743D511922F00A0C943142307291358@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C943142307291358@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071626.57918.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already done, although not dividing along AMD vs. Intel lines.  
phys_pkg_id() indirects through the subarch table.  See 
genapic_cluster.c and genapic_flat.c for details.

We may need a third subarch for AMD's Extended APIC mode boxes.

Can you suggest some heuristics for detecting such a system and 
discerning it from a clustered APIC box?  (Hopefully, without using MPS 
or ACPI table ID string lookups.)


On Friday 07 January 2005 04:28 pm, YhLu wrote:
> Then sepertate that into init_amd and init_intel.
>
> YH
>
> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Friday, January 07, 2005 4:13 PM
> To: YhLu
> Cc: Andi Kleen; Matt Domsch; linux-kernel@vger.kernel.org;
> discuss@x86-64.org; suresh.b.siddha@intel.com
> Subject: Re: 256 apic id for amd64
>
> Clustered APIC systems need the phys_proc_id to come from the APIC ID
> register.  Intel prefers that non-clustered systems get their
> phys_proc_id from the cpuid opcode.
>
> So, using c->x86_apicid is unlikely to satisfy both parties.
>
> On Friday 07 January 2005 04:04 pm, YhLu wrote:
> > arch/x86_64/kernel/setup.c
> >
> > static void __init detect_ht(struct cpuinfo_x86 *c)
> >
> >                 phys_proc_id[cpu] = phys_pkg_id(index_msb);
> >
> > --->
> > 			  Phy_proc_id[cpu] = cpu_to_node[cpu];
> > Or
> >    	      // that is initial apicid
> >           phys_proc_id[cpu] = c->x86_apicid >>
> > hweight32(c->x86_num_cores - 1);
> >
> > YH
> >
> > -----Original Message-----
> > From: Andi Kleen [mailto:ak@muc.de]
> > Sent: Friday, January 07, 2005 2:18 PM
> > To: YhLu
> > Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
> > jamesclv@us.ibm.com; suresh.b.siddha@intel.com
> > Subject: Re: 256 apic id for amd64
> >
> > On Fri, Jan 07, 2005 at 01:44:19PM -0800, YhLu wrote:
> > > Can you consider to use c->x86_apicid to get phy_proc_id, that is
> > > initial apicid.?
> >
> > Where?
> >
> > -Andi

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
